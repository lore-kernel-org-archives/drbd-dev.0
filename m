Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 27 Feb 2008 17:51:44 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
Message-ID: <20080227165144.GA7101@barkeeper1.linbit>
References: <1204044621.1040.62.camel@localhost.localdomain>
	<1204128048.10864.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1204128048.10864.51.camel@localhost.localdomain>
Subject: [Drbd-dev] Re: [DRBD-user] [PATCH] dopd should notify when peer is
	dead (was "Refusing to be Primary while peer is not outdated"
	when peer is dead?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Feb 27, 2008 at 05:00:48PM +0100, Brice Figureau wrote:
> Hi again,
> 
> I now have a better understanding of the issue I posted in drbd-user
> yesterday, which seems to be a bug in dopd/drbd-peer-updater, hence I'm
> posted this mail in the dev list.
> 
> Note that dopd works fine in the other failover scenario (the other node
> is still alive and can be contacted by other means).

thanks, our Rasto (who wrote the dopd and related things) is reviewing
this (and was working on it, anyways). so expect it to be commited to
heartbeat development this way or an other soonish.

> So here is a dopd patch fixing this issue. I only slightly tested it
> with the above scenario (with good results), so use at your own risks,
> etc...
> I'm not sure if I should send the patch on drbd-dev or on the linux-ha

dopd is maintained by linbit,
even though it is part of the heartbeat package (nice of them).

> lists, so I'm trying first here (the problem is drbd related).

thanks for that, they may have been pretty annoyed for us
committing semi-broken software to their project (again). :->

-- 
: Lars Ellenberg                           http://www.linbit.com :
: DRBD/HA support and consulting             sales at linbit.com :
: LINBIT Information Technologies GmbH      Tel +43-1-8178292-0  :
: Vivenotgasse 48, A-1120 Vienna/Europe     Fax +43-1-8178292-82 :
__
please use the "List-Reply" function of your email client.
