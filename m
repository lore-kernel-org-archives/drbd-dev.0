Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A17DA1011BF7
	for <drbd-dev@lists.linbit.com>; Mon,  8 Jul 2019 19:53:57 +0200 (CEST)
Received: by mail-io1-f68.google.com with SMTP id m24so27779005ioo.2
	for <drbd-dev@lists.linbit.com>; Mon, 08 Jul 2019 10:53:57 -0700 (PDT)
Received: from [192.168.1.20] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	l5sm24148521ioq.83.2019.07.08.10.53.55
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Jul 2019 10:53:56 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <f3251c75-2571-299e-b388-625017e8686a@gmail.com>
Date: Mon, 8 Jul 2019 11:53:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] wait_event called while nested inside another wait_event,
 using the same wait queue
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

change_cluster_wide_state() calls wait_event, nested inside the condition-test of another
wait_event call, using *the same wait queue* for both the outer and the inner wait calls.

I don't understand the intended kernel model precisely enough to know if this is a subtle bug,
or if it's really guaranteed OK to do this.  But it's pretty suspicious if it hasn't been
thought through carefully, so I thought I'd mention it.

The outer wait on resource->state_wait occurs when drbd_set_role() calls stable_state_change()
to wait for the condition of a successful change_role().  change_role() is called for the
condition-test and calls change_cluster_wide_state() which issues the inner (nested) wait on
resource->state_wait, waiting for cluster_wide_reply_ready().

Possibly it could work or fail depending on changes to the kernel wait implementation.
    For example, suppose the underlying wait implementation held a wait-queue lock during the
    condition check.  Calling wait_event nested inside the condition-test of another wait_event
    on the same wait_queue would lead to a recursive lock-acquisition attempt.  (On the other
    hand that may only prove that the implementation can't hold such a lock.)

The nested usage does not seem to have any bad effects (now that my wait implementation no
longer holds a wait-queue lock during the condition-test).

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index c3371e18..409b9afc 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -4195,6 +4195,18 @@ change_cluster_wide_state(bool (*change)(struct change_context *, enum change_ph
 				    &request, reach_immediately);
 	have_peers = rv == SS_CW_SUCCESS;
 	if (have_peers) {
+		// We are here as the change_state macro from inside the condition of
+		//	    wait_event_interruptible((resource)->state_wait,
+		//		    (rv = (change_state)) != SS_IN_TRANSIENT_STATE);
+		//
+		//XXX Is it really kosher to now use that same resource->state_wait
+		//    in another wait_event while we are nested within the first one?
+		//
+		// In drbd_set_role():
+		//	rv = stable_state_change(resource,
+		//		change_role(resource, role, flags, with_force, &err_str));
+		// where change_role() calls this function.
+		//
 		if (wait_event_timeout(resource->state_wait,
 				       cluster_wide_reply_ready(resource),
 				       twopc_timeout(resource)))
