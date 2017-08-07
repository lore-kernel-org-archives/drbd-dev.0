Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1A915105800A
	for <drbd-dev@lists.linbit.com>; Mon,  7 Aug 2017 16:25:03 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id t201so8568460wmt.1
	for <drbd-dev@lists.linbit.com>; Mon, 07 Aug 2017 07:25:02 -0700 (PDT)
Date: Mon, 7 Aug 2017 16:25:01 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <20170807142500.GU15992@rck.sh>
References: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3566e764-27b8-82e5-1f8e-c613e5a3a5b1@users.sourceforge.net>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 00/13] DRBD-receiver: Fine-tuning for six
 function implementations
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Sep 10, 2016 at 10:20:10PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Sep 2016 22:13:22 +0200
> 
> Several update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (13):
>   Use kmalloc_array() in receive_uuids()
>   Delete an error message for a failed kmalloc_array() call
>   Move an assignment in receive_uuids()
>   Improve a size determination in drbd_do_features()
>   Delete an unnecessary initialisation in receive_sizes()
>   Improve a size determination in receive_sizes()
>   Delete an error message for a failed kzalloc() call in receive_sizes()
>   Move an assignment in receive_sizes()
>   Improve determination of sizes in receive_SyncParam()
>   Delete error messages for failed resource allocations in receive_SyncParam()
>   Improve a size determination in receive_protocol()
>   Delete error messages for failed resource allocations in receive_protocol()
>   Improve determination of sizes in receive_Barrier()
> 
>  drivers/block/drbd/drbd_receiver.c | 45 ++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)

Hi Markus,

looks like these got overlooked. I took all of them except the ones that
remove the debug-output (sorry, I don't see a reason for these), and
squashed them accordingly. We will send them upstream soon.

Thanks, rck
