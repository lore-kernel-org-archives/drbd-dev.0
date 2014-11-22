Return-Path: <lars.ellenberg@linbit.com>
Date: Sat, 22 Nov 2014 23:08:01 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org
Message-ID: <20141122220801.GX307@soda.linbit>
References: <546E6D1F.9070300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546E6D1F.9070300@gmail.com>
Subject: Re: [Drbd-dev] [DRBD-user] FIX MEs for spinlocks in drbd_worker.c
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

On Thu, Nov 20, 2014 at 05:37:19PM -0500, nick wrote:
> Greetings Lars,
> I am wondering about removing the spin locks around the linked list
> operators in worker.c or do we need to test it first it first on
> actual hardware.
> Cheers Nick

Unless you have deep insight in the inner workings of DRBD
and their interactions, I'd strongly recommend to go find
some other fixmes.

That is much more complicated than just removing those lines and hope
for the best. Otherwise they would not be there (and not FIXME tag to
find them).

Maybe you just want to reverse-sort your grep for fixmes,
so that the bottom of the list gets some love, too.

Thanks,
	Lars

