Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4FF9742066F
	for <drbd-dev@lists.linbit.com>; Wed,  9 Aug 2023 23:40:08 +0200 (CEST)
Message-ID: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Date: Wed, 09 Aug 2023 22:59:47 +0200
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jiri@resnulli.us,
	netdev@vger.kernel.org, philipp.reisner@linbit.com,
	pshelar@ovn.org, jmaloy@redhat.com, edumazet@google.com,
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
	dev@openvswitch.org, lars.ellenberg@linbit.com,
	pabeni@redhat.com, drbd-dev@lists.linbit.com, jacob.e.keller@intel.com
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

On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> Only three families use info->userhdr and fixed headers
> are discouraged for new families. So remove the pointer
> from struct genl_info to save some space. Compute
> the header pointer at runtime. Saved space will be used
> for a family pointer in later patches.

Seems fine to me, but I'm not sure I buy the rationale that it's for
saving space - it's a single pointer on the stack? I'd probably argue
the computation being pointless for basically everyone except for a
handful users?

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes
