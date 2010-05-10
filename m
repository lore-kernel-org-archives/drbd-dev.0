Return-Path: <iustin@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 208331005412
	for <drbd-dev@lists.linbit.com>; Mon, 10 May 2010 17:40:41 +0200 (CEST)
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com
	[172.25.105.81]) by smtp-out.google.com with ESMTP id o4AFUH7X013051
	for <drbd-dev@lists.linbit.com>; Mon, 10 May 2010 08:30:17 -0700
Received: from fxm9 (fxm9.prod.google.com [10.184.13.9])
	by kpbe17.cbf.corp.google.com with ESMTP id o4AFUFck006950
	for <drbd-dev@lists.linbit.com>; Mon, 10 May 2010 08:30:16 -0700
Received: by fxm9 with SMTP id 9so822467fxm.28
	for <drbd-dev@lists.linbit.com>; Mon, 10 May 2010 08:30:15 -0700 (PDT)
Date: Mon, 10 May 2010 17:30:12 +0200
From: Iustin Pop <iustin@google.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20100510153012.GL5175@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] Question regarding usermode_helper and lack
	of	{before|after}_resync_source
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,

I'm curious if there is a reason why there is before_resync_target but
not before_resync_source. Probably the rationale is that noone needed it
before :)

Background: the current capabilities to configure resync order or number
of resyncs per machine is doable either via manual pause-sync actions,
or via the syncer's '--after' parameter. However, in environment where
this is dynamic, it's hard to create a static map, and it would be
useful to have such a before_resync_source action that the helper can
act on - e.g. to pause the minor, to set its sync speed based on current
machine status, etc.

So… would it make sense to send a patch adding these two actions
(before/after)?

thanks,
iustin
