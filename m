Return-Path: <aconole@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
	(us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4B61142018E
	for <drbd-dev@lists.linbit.com>; Tue, 15 Aug 2023 14:56:07 +0200 (CEST)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20230814214723.2924989-1-kuba@kernel.org>
	<20230814214723.2924989-4-kuba@kernel.org>
Date: Tue, 15 Aug 2023 08:49:08 -0400
In-Reply-To: <20230814214723.2924989-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Aug 2023 14:47:16 -0700")
Message-ID: <f7twmxwxygr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: axboe@kernel.dk, dev@openvswitch.org, jiri@resnulli.us,
	netdev@vger.kernel.org, jacob.e.keller@intel.com,
	philipp.reisner@linbit.com, jmaloy@redhat.com,
	linux-block@vger.kernel.org, edumazet@google.com,
	tipc-discussion@lists.sourceforge.net, lars.ellenberg@linbit.com,
	Jiri Pirko <jiri@nvidia.com>, ying.xue@windriver.com,
	johannes@sipsolutions.net, pabeni@redhat.com,
	davem@davemloft.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [ovs-dev] [PATCH net-next v3 03/10] genetlink:
 remove userhdr from struct genl_info
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

Jakub Kicinski <kuba@kernel.org> writes:

> Only three families use info->userhdr today and going forward
> we discourage using fixed headers in new families.
> So having the pointer to user header in struct genl_info
> is an overkill. Compute the header pointer at runtime.
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Seems the OVS side didn't change from v2 so still:

Reviewed-by: Aaron Conole <aconole@redhat.com>

