Return-Path: <Lars.Ellenberg@linbit.com>
Date: Tue, 25 Jul 2006 03:57:03 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Milind Dumbare <milind.dumbare@gmail.com>
Subject: Re: [Drbd-dev] Bug?
Message-ID: <20060725015703.GG4596@soda.linbit>
References: <44C4E271.3080607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C4E271.3080607@gmail.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-07-24 20:38:33 +0530
\ Milind Dumbare:
> Hi,
> First of all to tell I am working on x86_64 machine.
> 
> The structure ioctl_get_config has size 576(bytes) and its padded with
> int (4byte) so it makes 580 (bytes). And compiler will align it to 584
> (bytes), as 580 is not completely divisible by 8 while 584 is.
>
> So don't you think drbd_sizeof_sanity_check.c:21 should be
> 
>        SZO(struct ioctl_get_config,    576)
> rather than
>        SZO(struct ioctl_get_config,    580)

when filing bugs, please state against which version you complain.
(in this case, I guess 8-pre something tarball).
when it is not the latest version, check whether it has already been
fixed, as I think for this issue recent versions (svn) are fixed, and
we now have compile time asserts instead of runtime asserts in place.

yes, we probably should upload some new 8pre-something tarballs.

thanks,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
