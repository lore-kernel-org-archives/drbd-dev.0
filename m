Return-Path: <lmb@suse.de>
Date: Thu, 19 Aug 2004 12:32:21 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <20040819103221.GM9601@marowsky-bree.de>
References: <20040728080645.GB7918@tmathiasen> <200408182131.36198.philipp.reisner@linbit.com> <20040818225708.GY9601@marowsky-bree.de> <200408191115.42139.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408191115.42139.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

On 2004-08-19T11:15:41,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> I will look into it, probabely it is easy to do... [I can not remeber
> what we changed there...]

I'm also sweet-talking our maintenance crew because I really want to
avoid that ;-)

> BTW: I thought that RPMs have dependencies too. Why is it not possible
>      to express something like
> 
>      km_drbd-0.7.1 requires  >=  drbd-0.7.1 (user-package)
> 
>      in the dependencies of the kernel module package...

Because YaST2 Online Update does not evaluate these dependencies.
("Updates are not allowed to change package dependencies in a stable
product.")

So, I'm not happy with either the change in drbd nor our online update
system - either one on it's own would be fine, but the combination
thereof is somewhat annoying ;-)

But, there's hope, I think. I'll try to weasle out of that policy. I can
be really good with weasel words. ;)

(I also don't think any drbd using customer would only update the
kernel, but not drbd, or update drbd user-space but not the kernel.
I claim that's a somewhat ridiculous policy in this case...)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \        This space          /
SUSE Labs, Research and Development |       intentionally        |
SUSE LINUX AG - A Novell company    \        left blank          /
