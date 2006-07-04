Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Re: [DRBD-user] drbd_panic() in drbd_receiver.c
Date: Tue, 4 Jul 2006 11:01:32 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671031FB378@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Thanks -- I'm actually starting with drbd 7 just because it's _much_
easier for me to test (we have a complete build/install/test
infrastructure currently based on using 0.7) however I will push the
changes into the head of the trunk as soon as I can.

FWIW, I have the set-state, NegDReply and NegDSReply stuff coded and
running; I'm using a known bad disk and no panics so far! -- the only
issue I have now is that I think I need to kick the resync processing
when a NegDSReply is received -- /proc/drbd always shows the resync as
100% and stalled;

BTW: do you have any suggestions for handling the bitmap and meta-data
write failures?

Also - let me know if you think you would incorporate these changes into
the 0.7 branch - if so, I'll send patches (oh and let me know what the
'approved' mechanism for sending patches is please).

Simon

-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com]
On Behalf Of Philipp Reisner
Sent: Tuesday, July 04, 2006 6:08 AM
To: drbd-dev@linbit.com
Cc: drbd-user@linbit.com
Subject: [Drbd-dev] Re: [DRBD-user] drbd_panic() in drbd_receiver.c

Am Montag, 3. Juli 2006 19:03 schrieb Graham, Simon:
> ...

Excellent ideas. In case you really start to work on this, please
base your work on the drbd-8.0 code, preferably the trunk.

PS: Moving this thread over to drbd-dev, is a good idea.

-Philipp
--=20
