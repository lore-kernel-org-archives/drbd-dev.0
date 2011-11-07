Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 7 Nov 2011 10:48:28 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Florian Haas <florian@hastexo.com>
Message-ID: <20111107094828.GF15431@barkeeper1-xen.linbit>
References: <1320595796-5181-1-git-send-email-florian@hastexo.com>
	<20111107093240.GD15431@barkeeper1-xen.linbit>
	<4EB7A65F.4080501@hastexo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EB7A65F.4080501@hastexo.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] fix missing directory creation in "make install"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Nov 07, 2011 at 10:35:27AM +0100, Florian Haas wrote:
> > As /var/run/ is a tmpfs on many distros now, subdirs and other things in
> > it need to be recreated anyways as needed, which drbdsetup is actually
> > supposed to be doing.
> 
> Then you might want to look into drbdsetup,
> because at least on 8.4.0 it does not do so.

There is some mkdir() in there.

It obviously only mkdir */run/drbd, not */run/ itself
(which, I think, it should not).
So an other reason not to use the braindead autofoo "defaults".

Should we paint it pink?

	Lars
