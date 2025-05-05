Return-Path: <philipp.reisner@linbit.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7E62A160645
	for <drbd-dev@lists.linbit.com>; Mon,  5 May 2025 16:26:25 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
	5b1f17b1804b1-43cfba466b2so36871365e9.3
	for <drbd-dev@lists.linbit.com>; Mon, 05 May 2025 07:26:25 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "zhengbing . huang" <zhengbing.huang@easystack.cn>
Subject: Re: [PATCH] rdma: Fix cm leak
Date: Mon,  5 May 2025 16:26:22 +0200
Message-ID: <20250505142623.424049-1-philipp.reisner@linbit.com>
In-Reply-To: <20250425102421.1673048-1-zhengbing.huang@easystack.cn>
References: <20250425102421.1673048-1-zhengbing.huang@easystack.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: drbd-dev@lists.linbit.com
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

Hi Zhengbing,

Yes, I agree. I follow your explanation of what happened and your
proposed fix. I think we also need to clear the DSB_CONNECT_REQ bit in
the RDMA_CM_EVENT_ESTABLISHED case.

Please see my proposal, which is slightly modified from your original
patch.

Best regards,
 Philipp

zhengbing.huang (1):
  rdma: Fix cm leak

 drbd/drbd_transport_rdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.49.0

