Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] drbdsetup  events patch to announce Split-brain
Date: Thu, 25 Oct 2007 08:24:55 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47A1B@EXNA.corp.stratus.com>
In-Reply-To: 200710251215.47192.philipp.reisner@linbit.com
References: <BD7042533C2F8943A6A4257A9E31C454F479FA@EXNA.corp.stratus.com>
	200710251215.47192.philipp.reisner@linbit.com
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
Currently we do not use the payload for anything.  I was just being
paranoid thinking that we might need it in the future.  But you can drop
it if you wish.  If we have a pressing need for it in the future, we'll
deal with it then.

Thanks.
EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Thursday, October 25, 2007 6:16 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] drbdsetup events patch to announce Split-brain

On Monday 01 October 2007 23:24:02 Montrose, Ernest wrote:
> Hi,
>
> Included here is a small patch that I find useful when monitoring with
> drbdsetup().  It adds the ability to generate an netlink event to user
> space when drbd Split-brain and disconnect.  Based on that event we
can
> then take action. I could not find a more
> convenient way to know that a split-brain occurred other then looking
in
> /var/log/messages.
>

Hi Ernest,

I have nearly overlooked this patch...=20
You are right, it is definitely a good idea to have that.=20

I just need to change the tag number for the split_brain flag,
since that number is already allocated in drbd-8.2.0.=20

The question I have, what is the flag good for ? Do you envision
an future use of it ?  otherwise I would drop it, it is possible
to have such an cn packet, that does not carry any futher data...

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
