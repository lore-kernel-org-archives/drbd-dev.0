Return-Path: <mps@arvanta.net>
Received: from fx.arvanta.net (static-213-198-238-194.adsl.eunet.rs
	[213.198.238.194])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id AC2BB4203B4
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2022 19:01:14 +0100 (CET)
Date: Mon, 14 Nov 2022 19:01:12 +0100
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Roland Kammerer <roland.kammerer@linbit.com>
Message-ID: <Y3KCaAhsz9ViOKz9@m1>
References: <Y2j1Lmr2afaEYvBu@m1>
 <Y3IB2V2TXOzNac1H@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3IB2V2TXOzNac1H@rck.sh>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [BUG] drbdadm_parser.c:1968:63: error: 'glob_t' has
 no member named 'gl_flags'
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

[ Please Cc to me, I'm not subscribed to this mailing list ]

On Mon, 2022-11-14 at 09:52, Roland Kammerer wrote:
> On Mon, Nov 07, 2022 at 01:08:14PM +0100, Milan P. Stanić wrote:
> > Hi,
> > 
> > [ Please Cc to me, I'm not subscribed to this mailing list ]
> > 
> > I'm trying to build drbd-tools 9.22.0 on Alpine Linux which is based on
> > musl libc (and not glibc).
> > 
> > [...]
> > 
> > Musl libc glob.h doesn't have gl_flags nor GLOB_MAGCHAR because it is
> > non standard glibc extension.
> 
> thanks for reporting, this should be fixed in
> https://github.com/LINBIT/drbd-utils/commit/33d5e8f7066116bd0a706c7cdda4950895164d34
> 
> > I reverted https://github.com/LINBIT/drbd-utils/commit/4a1b590090bf676cdfb10c198505b95b9eeb3120
> > commit and then drbd-tools builds fine.
> > 
> > Not sure is this revert safe to push drbd-utils in next Alpine release
> > (which planned for next week) or there is better fix.
> 
> I think reverting for now is perfectly fine, this deserved a fix, but I
> don't think it actually happened in the wild that often... Or you pick
> the proposed fix, which would be a good test for us as well. Currently

I picked above commit and build with it passed fine.
Thank you for fix.

> I'm not sure when the next official release will be done, current gut
> feeling is not enough interesting things people would wait for has have
> happened.

-- 
Kind regards

> 
> Regards, rck
