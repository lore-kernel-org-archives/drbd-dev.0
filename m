Return-Path: <jiri@resnulli.us>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 83E7C420AFF
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2023 10:26:25 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
	5b1f17b1804b1-3fe12baec61so5173765e9.2
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2023 01:26:25 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:26:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <ZNSfLomTSZy/4b8W@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, netdev@vger.kernel.org,
	philipp.reisner@linbit.com, pshelar@ovn.org, jmaloy@redhat.com,
	edumazet@google.com, tipc-discussion@lists.sourceforge.net,
	lars.ellenberg@linbit.com, ying.xue@windriver.com,
	dev@openvswitch.org, johannes@sipsolutions.net,
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

Wed, Aug 09, 2023 at 08:26:41PM CEST, kuba@kernel.org wrote:
>Only three families use info->userhdr and fixed headers
>are discouraged for new families. So remove the pointer
>from struct genl_info to save some space. Compute
>the header pointer at runtime. Saved space will be used
>for a family pointer in later patches.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

I'm fine with the existing message, but what Johannes suggests is also
ok.
