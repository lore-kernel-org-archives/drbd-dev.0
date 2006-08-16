Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Aug 2006 16:41:01 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710362551D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: handling of concurrent writes with two primaries
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Now I'm past my problems with crashing due to completing requests too
soon, I'm on to the next issue where I'm getting concurrent writes from
both sides (with allow-two-primaries set); to explain a little first -
in my case, even though I have two primaries set, I use them
sequentially and only one node is issuing writes at any given time -
however, at certain times I actually want to switch over to the other
node and at this time there is a small window when some requests can be
issued on both sides (if you care, I'm actually running Xen virtual
machines on one node using DRBD disks as the virtual block devices for
the VMs and live migrating the VMs to the other node).

Now, I realize it's my problem to ensure consistency in this case,
however, in looking at the code in receive_Data I think there are
perhaps some issues as follows:

If I understand things correctly, the code when a conflict is detected
is written as:

	if (already-received-ack)
		wait for existing req to complete then carry on
	else
		if (UNIQE flag set)
			throw request away (no Ack sent)
		else
			send Discard msg and mark original request as
acknowledged the carry on

I think there are a couple of issues here:

1. I think you are assuming that when a node sends an Ack followed by a
Data request for the same block, the Ack will arrive first. Since it's
sent on the meta data socket and the data is sent on the data socket,
this may not be true.

2. If the UNIQE flag is set, then I don't see how the partner node will
make any progress - you never send an Ack and do not disconnect - if the
partner also sees the conflict then he will do the Discard msg
processing, but I don't think this is guaranteed - I'm probably missing
something, but if the partner gets the request and _then_ issues a write
to the same location, I don't think it will do the right thing... the
partner will simply discard and you are left hanging...

I'm wondering if it mightn't be better to adopt a simpler policy of
always waiting for outstanding requests to finish - it doesn't matter
what order they finish in (since there are no guarantees in this
case)... Of course, there is a definite deadlock potential here that
needs to be thought about...

Simon
