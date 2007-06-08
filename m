Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Resync Stalls at 100% patch problem
Date: Fri, 8 Jun 2007 07:45:26 -0400
Message-ID: <BD7042533C2F8943A6A4257A9E31C454F47926@EXNA.corp.stratus.com>
In-Reply-To: 200706081151.04454.philipp.reisner@linbit.com
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
Ah! Vacation.. I will test it out and let you know if I find any issues.

Thanks!

EM--

-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]=20
Sent: Friday, June 08, 2007 5:51 AM
To: drbd-dev@linbit.com
Cc: Montrose, Ernest
Subject: Re: [Drbd-dev] Resync Stalls at 100% patch problem

On Thursday 07 June 2007 00:14:13 Montrose, Ernest wrote:
> Phil,
> I looked into the patch issue a bit more.
> This problem happens if we acquire the req_lock early.  What I think
is
> going on is this:
>
> Primary host ---->attach---> send_state()
> Peer -----> receive_state()-->after_state_ch()-->send_bitmap()
> Primary Host ---->receive_bitmap()***Unexpected cstate "Connected"
> Peer ----> send_state()
> Primary Host --->receive_state() and we are deadlock.
>
> The primary host is receiving the bitmap too early.  Essentially the
> peer should call send_state() before calling after_state_ch()
>
> I noticed the patch had moved that logic after calling
after_state_ch()
> so moving it back before after_state_ch() should be OK.  Any reason
why
> it was moved down?
>
> I tested the included patch that moved just before we call
> after_state_ch().
> Let me know.
>

Hi Ernest,

Sorry for the slow responses recently. We had a public holiday here,
and I was out in the mountains...

I have now committed a patch very similar to your suggestion.

-phil
--=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
