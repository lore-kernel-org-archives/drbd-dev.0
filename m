Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Date: Fri, 28 May 2010 10:07:11 +0200
References: <20100526190403.fcf8d536.rdunlap@xenotime.net>
In-Reply-To: <20100526190403.fcf8d536.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005281007.11478.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd sparse warnings
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 27. Mai 2010, um 04:04:03 schrieb Randy Dunlap:
> Hi,
> 
> When I build a Linux kernel with "make C=1" to invoke sparse,
> I see 135 sparse warnings like (shorter list):
> 
> 
> linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:931:39: error: attribute 'require_context': unknown attribute
> linux-2.6.34-git11/drivers/block/drbd/drbd_int.h:1212:69: error: attribute 'require_context': unknown attribute
[...]

We have a patched sparse here. 

I tried to get those improvements into sparse upstream, but
at that time the sparse maintainer was not very active...

http://marc.info/?l=linux-sparse&m=120696665813430&w=4

> 
> What is the meaning and usage of require_context in drbd_int.h?
> 

I guess I will remove that stuff from DRBD in Linux mainline.

Or someone steps up, and helps to get those sparse improvements 
into sparse ;)

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
