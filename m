Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Resync Stalls at 100% patch problem
Date: Fri, 8 Jun 2007 11:51:02 +0200
References: <BD7042533C2F8943A6A4257A9E31C454F47923@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47923@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706081151.04454.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thursday 07 June 2007 00:14:13 Montrose, Ernest wrote:
> Phil,
> I looked into the patch issue a bit more.
> This problem happens if we acquire the req_lock early.  What I think is
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
> I noticed the patch had moved that logic after calling after_state_ch()
> so moving it back before after_state_ch() should be OK.  Any reason why
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
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
