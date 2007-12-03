Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD][PATCH] drbd_bitfild_endian.patch
Date: Mon, 3 Dec 2007 17:52:03 +0100
References: <474AF52C.6090409@ru.mvista.com> <474C12E0.6020306@ru.mvista.com>
	<20071127105512.GA28512@racke.local>
In-Reply-To: <20071127105512.GA28512@racke.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712031752.03934.philipp.reisner@linbit.com>
Cc: Maxim Uvarov <muvarov@ru.mvista.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 27 November 2007 11:55:12 Lars Ellenberg wrote:
> On Tue, Nov 27, 2007 at 12:51:44PM +0000, Maxim Uvarov wrote:
> > By the way, Lars,  don't  use if defined(__LITTLE_ENDIAN) condition
> > because  __LITTLE_ENDIAN and __BIG_ENDIAN are always defined :)
>
> in userland, yes.
> in kernel, no.
>
> in kernel there is no "if BYTE_ORDER == __LITTLE_ENDIAN",
> there is only "ifdef __LITTLE_ENDIAN".
>
> unless you prove me wrong.

Hi,

I have decided to go with Maxim's initial approach == Lars' approach.

I decided for that because according to GCC's documentation the
layout of bit-fields is part of the platform's ABI. It is not
compiler version dependant...

Please review commit 
d43cf82288b7cbd703aa0b587c4ab32605fb97c5

Thanks!

Changing the protocol is not an option for drbd-8.0. The protocol
is frozen (for little endian).

That breaks of course rolling upgrades for users of existing
clusters on bit-endian machines.... if there are any.

BTW: If we really want we could even fix this, since we know
     that _pad is always 0 .... but it is not worth the effort
     when there are no users out there.

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
