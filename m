Return-Path: <moreyroof@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AC3CC2E2E5EF
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2008 18:43:47 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so626784fgg.13
	for <drbd-dev@lists.linbit.com>; Fri, 19 Sep 2008 09:43:46 -0700 (PDT)
Message-ID: <91a37e890809190919g5a746367g54e76d36e1a825f6@mail.gmail.com>
Date: Fri, 19 Sep 2008 10:19:03 -0600
From: "Morey Roof" <moreyroof@gmail.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] New Features
In-Reply-To: <20080919155343.GD9779@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48D3378E.3020201@gmail.com> <20080919155343.GD9779@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I have been programming professionally for about 12 years with C/C++
in various system.  I have worked on various parts of Linux for
companies but I never submitted work to be included until recently.
So I am a bit new to the get stuff out there model, but I am quite
experienced working on very large and complex projects.

What has allowed me to start working on some open source projects
recently is the move to a job for a college where such work is
welcomed and encouraged instead of the traditional business models
where everything is a closely guarded secret.  We have been using DRBD
for a while and I have found that there are several itches I would
like to scratch, so to speak.

Let me know if you need more information.

Thanks,

Morey

On Fri, Sep 19, 2008 at 9:53 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Thu, Sep 18, 2008 at 11:24:30PM -0600, Morey Roof wrote:
>> I have been using DRBD and really like but I have wanted to add some new
>> features to it and I wanted to ask you guys what you need and
>> requirements you may have on patches to DRBD.
>
> Could you tell us about your background, and prior coding experience,
> and how much time you think you want to spend on this?
>
> In the drbd module, we currently do not actively work on new features
> that would be suitable to be implemented by anyone not very familiar
> with the drbd code base.  If you think you are, let me know...
>
> Finding and squashing bugs is always a wellcome contribution.
>
> Userland could be improved, e.g. adding an "include" statement
> to the drbd.conf grammar, which would allow to have the configuration
> split out in /etc/drbd.conf.d/*.conf.
>
> Error messages can be improved, in both kernel and userland.
>
> The community would be happy to see some detailed walk-throughs from
> scratch for drbd integration with pacemaker, including various typically
> deployed services on top of drbd.
>
> I'd be happy to see a recent and solid HA-DRBD-NFS howto,
> so if you feel that would be a task for you,
> set up an HA-DRBD-NFSv4 server, and document everything needed to make
> it behave as expected (document the expectations as well) in face of
> failover, switchover, node reboot, cluster reboot, replication link failure,
> other component failures, various administrative tasks.
>  An advanced variation on the theme: "load balancing" HA-DRBD-NFSv4
> cluster, using multiple drbd, each with its own file system, fsid, and
> HA-ip, and then switchover at will, without causing server nor client
> hickups.
>
> --
> : Lars Ellenberg
> : LINBIT | Your Way to High Availability
> : DRBD/HA support and consulting http://www.linbit.com
>
> DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev
>
