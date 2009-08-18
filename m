Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 18 Aug 2009 22:59:10 +0200
References: <479b87b70908160900ue855e71l8212d7f6936064c4@mail.gmail.com>
In-Reply-To: <479b87b70908160900ue855e71l8212d7f6936064c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908182259.10699.philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] Patch for an up-to-date script/patch-kernel
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 16. August 2009 18:00:21 schrieb Guillaume Plessis:
> Hello DRBD-devs,
> I encountered problems building a DRBD 8.3.2 patch with a 2.6.30.4 kernel
> (missing lru_cache.h, drbd_vli.h, drbd_tracing.c and drbd_tracing.h).
>
> You'll find as attachement a patch that fixes the patch-building process by
> filling "include_linux" and "drbd_source" with the good values.
>
> I hope it will be useful.
>
> Keep up the good work.
>

Whow the second patch of this kind within a few days. I never expected
that people actually patch DRBD into their kernels...

I have applied it.

Other than that we aim to get DRBD merged to Linux upstream with the 
2.6.32 release. You can track out integration work from here:

git://git.drbd.org/linux-2.6-drbd.git

-Phil

