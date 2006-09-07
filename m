Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD-8 - system hangs when NegDReply received
Date: Thu, 7 Sep 2006 10:21:22 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038AFC6A@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Lars Ellenberg" <Lars.Ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


> I am still working on a monster patch to consolidate all the
> request functionality in one place, so it is more obvious what should
> and should not happen.
> I may be wrong here, but you cannot simply end the master request and
> free the req because you get a NegDReply. the local part (submit_bio)
> may still be on the fly.
> you have to use drbd_end_req with appropriate flags...

I had the same thought when I started looking at this - however,
currently reads do NOT use this approach since a read is only issued on
one side - receive_DataReply does just complete the master bio for
example; in fact, I mostly copied the code from this routine.

Do you have any idea when your monster patch will be ready?
Simon
