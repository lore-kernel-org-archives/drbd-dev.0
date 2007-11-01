Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] DRBD8: nodes deadlock in PausedSync{ST]
Date: Thu, 1 Nov 2007 08:03:19 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A28@EXNA.corp.stratus.com>
In-Reply-To: 200710311446.42512.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C454F47A25@EXNA.corp.stratus.com>
	200710311446.42512.philipp.reisner@linbit.com
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks! I will test it all and let you know of any issues.

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Wednesday, October 31, 2007 9:47 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] DRBD8: nodes deadlock in PausedSync{ST]

On Monday 29 October 2007 23:33:29 Montrose, Ernest wrote:
> Hi all,
> I have been struggling with a problem here where the nodes enter
> PausedSync[T|S] and stay there.
> This happens when one node come up from a fresh attach, connect
> sequence.  I think the issue happens this way. Say we have two volumes
> drbd5 and drbd16 and we attempt to connect both of them at roughly the
> same time.  Futhermore, drbd5 and 16 will require syncing say as sync
> target. What I observe is this:
> *	drbd16 is connecting and drbd5 is syncing. So 16 is paused isp=3D1
> *	drbd16 enters receive_state() but before acquiring the req_lock
> that thread loses the CPU to drbd5 that is finishing syncing.
After_isp
> is cleared on 16 giving drbd16 the green light to continue syncing. So
> far so good.
> *	Now drbd16 resumes with the old peer_isp=3D1
> *	So now we are paused forever.
>
> So I think receive_state() is just racy but I could be wrong. I am
> really not sure how to fix this but I include a patch here that may
help
> to at least illustrate the problem. It seems close window for this
> particular race somewhat.
>

Hi Ernest,

You patch fixes the issue.

I spent an hour or so to understanding the exact timing, and drew=20
diagrams of it... it is fixed with that change. No race left, I think.

I committed it to my git tree.

-Phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
