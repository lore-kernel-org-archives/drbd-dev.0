Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 730DB4203D8
	for <drbd-dev@lists.linbit.com>; Thu,  5 Mar 2020 14:11:33 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id a5so6249893wmb.0
	for <drbd-dev@lists.linbit.com>; Thu, 05 Mar 2020 05:11:33 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id v2sm9147580wme.2.2020.03.05.05.03.02
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 05 Mar 2020 05:03:03 -0800 (PST)
Resent-Message-ID: <20200305130301.GE19467@soda.linbit>
Received: from m97138.mail.qiye.163.com (m97138.mail.qiye.163.com
	[220.181.97.138])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5A9FB420386
	for <drbd-dev@lists.linbit.com>; Tue,  3 Mar 2020 02:35:08 +0100 (CET)
To: Zhang Duan <duan.zhang@easystack.cn>, drbd-dev@lists.linbit.com,
	philipp.reisner@linbit.com
References: <76806ec7-77fd-56b9-96f5-954cfcb24eee@easystack.cn>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <19e10edf-803e-1ea4-4fe6-38e1f516993a@easystack.cn>
Date: Tue, 3 Mar 2020 09:29:49 +0800
MIME-Version: 1.0
In-Reply-To: <76806ec7-77fd-56b9-96f5-954cfcb24eee@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] [PATCH] drbd: Ignore negotiation result with the
 peer who is also negotiating
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

Hi Philipp,

      What's your opinion on this patch?

Thanx

Yang

在 3/2/2020 8:31 PM, Zhang Duan 写道:
>
>
> We have a test on 3 nodes cluster in which the primary is uptodate and 
> the other two secondary
> is diskless by doing drbdadm detach. Then after doing drbdadm attach 
> on the two secondary at
> the same time, one status hangs at NEGOTIATING while another hangs at 
> ATTACHING.
>
> That is because if a negotiating peer receives another's 
> wide-cluster-change from DISKLESS to
> NEGOTIATING, it will reject it due to more than one negotiation 
> throughout the cluster, but the
> new disk state of that node remains NEGOTIATING after a failed state 
> change. Then neither of
> two peers can get a negotiating result what they want.
>
> Signed-off-by: ZhangDuan
> ---
> drbd/drbd_state.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index c919d759..85910f1e 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -1835,8 +1835,10 @@ static void sanitize_state(struct drbd_resource 
> *resource)
> for_each_peer_device_rcu(peer_device, device) {
> enum drbd_repl_state nr = peer_device->negotiation_result;
> enum drbd_disk_state pdsk = peer_device->disk_state[NEW];
> + enum drbd_disk_state pdsk_old = peer_device->disk_state[OLD];
>
> - if (pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING)
> + if ((pdsk == D_UNKNOWN || pdsk < D_NEGOTIATING) ||
> + (pdsk_old < D_NEGOTIATING && pdsk == D_NEGOTIATING))
> continue;
>
> if (pdsk == D_UP_TO_DATE)
> -- 
> 2.24.0.windows.2
>
> -- 
> Sincerely Yours,
> Zhang Duan

