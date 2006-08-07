Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 7 Aug 2006 09:33:12 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671034711DB@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 - after_state_ch() can attempt to terminate
	worker thread with wait==true
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Near the end of after_state_ch() there are several clauses that stop
(and restart) receiver and worker threads synchronously - since this
function is called from both the worker and receiver thread context,
these calls cannot be made synchronously (and an ASSERT in
_drbd_thread_stop will fire).

There seem to be a couple of issues here:

1. Is it the intention that after_state_ch is always called from the
worker thread? If so, then the calls in drbd_receiver and
   drbd_fs need to change to submit work items

2. No matter what, it should not issue synchronous calls to
drbd_thread_stop for non-current threads.

3. In receive_state() -- should after_state_ch() be called at all if the
preceding call to _drbd_set_state fails? It seems a
   bit wrong to me to pass in the new state to after_state_ch when you
know this does not represent the actual new state...

4. Ditto receive_outdate().

Simon
