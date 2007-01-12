Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 229DD2D9E014
	for <drbd-dev@lists.linbit.com>; Fri, 12 Jan 2007 14:53:36 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] oopses in 2.6.19.1
Date: Fri, 12 Jan 2007 14:53:37 +0100
References: <20070110123116.GX15730@kwaak.net>
	<20070111171205.GC15730@kwaak.net>
	<20070111180322.GD15730@kwaak.net>
In-Reply-To: <20070111180322.GD15730@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121453.37277.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 11. Januar 2007 19:03 schrieb Ard van Breemen:
> On Thu, Jan 11, 2007 at 06:12:05PM +0100, Ard van Breemen wrote:
> > Your patch, but fixed with ^^^^ and working. (I do have unrelated
> > oopses).
>
> On the Inconsistent side, it starts to oops. During the first
> sink I do a disconnect, and then...
> I will pay more attention on the next oops on what was I doing.
>

Hi Ard,

I am running out of time now. I will look into this issue
on Monday. Just the usual questions:

* Was there Application-IO during the resync ?
* Happened it when the resync was supposed to be finished ?
* Can you (easily) reproduce it ?

Thanks,
 Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
