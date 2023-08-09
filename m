Return-Path: <kuba@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2B2BC420171
	for <drbd-dev@lists.linbit.com>;
	Thu, 10 Aug 2023 00:02:49 +0200 (CEST)
Date: Wed, 9 Aug 2023 15:02:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20230809150246.4d1c0be6@kernel.org>
In-Reply-To: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-4-kuba@kernel.org>
	<6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jiri@resnulli.us,
	netdev@vger.kernel.org, philipp.reisner@linbit.com,
	pshelar@ovn.org, jmaloy@redhat.com, edumazet@google.com,
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
	dev@openvswitch.org, lars.ellenberg@linbit.com,
	pabeni@redhat.com, drbd-dev@lists.linbit.com,
	davem@davemloft.net, jacob.e.keller@intel.com
Subject: Re: [Drbd-dev] [PATCH net-next 03/10] genetlink: remove userhdr
 from struct genl_info
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

On Wed, 09 Aug 2023 22:59:47 +0200 Johannes Berg wrote:
> On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> > Only three families use info->userhdr and fixed headers
> > are discouraged for new families. So remove the pointer
> > from struct genl_info to save some space. Compute
> > the header pointer at runtime. Saved space will be used
> > for a family pointer in later patches.  
> 
> Seems fine to me, but I'm not sure I buy the rationale that it's for
> saving space - it's a single pointer on the stack? I'd probably argue
> the computation being pointless for basically everyone except for a
> handful users?

Fair, I'll update all the commit messages.

> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks!
