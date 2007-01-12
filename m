Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Date: Fri, 12 Jan 2007 14:50:45 +0100
References: <20070110123116.GX15730@kwaak.net>
	<20070111143845.GB15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
In-Reply-To: <20070111171205.GC15730@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121450.46273.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 11. Januar 2007 18:12 schrieb Ard van Breemen:
> On Thu, Jan 11, 2007 at 03:38:45PM +0100, Ard van Breemen wrote:
> > s/CRYPTO_ALG_TYPE_DIGEST/CRYPTO_ALG_TYPE_HASH/g
>
> Your patch, but fixed with ^^^^ and working. (I do have unrelated
> oopses).

Hi Ard,

This has gone to SVN Yesterday.
http://lists.linbit.com/pipermail/drbd-cvs/2007-January/001426.html

Today I finally convinced myself that it really works. It computes
the same values, using the new and the old API. It seems to work.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
