Return-Path: <lars.ellenberg@linbit.com>
Date: Tue, 27 Nov 2007 11:55:12 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [Drbd-dev] [DRBD][PATCH] drbd_bitfild_endian.patch
Message-ID: <20071127105512.GA28512@racke.local>
References: <474AF52C.6090409@ru.mvista.com>
	<20071126150621.GD14702@racke.local>
	<474C12E0.6020306@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474C12E0.6020306@ru.mvista.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Nov 27, 2007 at 12:51:44PM +0000, Maxim Uvarov wrote:
> By the way, Lars,  don't  use if defined(__LITTLE_ENDIAN) condition 
> because  __LITTLE_ENDIAN and __BIG_ENDIAN are always defined :)

in userland, yes.
in kernel, no.

in kernel there is no "if BYTE_ORDER == __LITTLE_ENDIAN",
there is only "ifdef __LITTLE_ENDIAN".

unless you prove me wrong.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
