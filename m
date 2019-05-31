Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DE08F1028A64
	for <drbd-dev@lists.linbit.com>; Mon,  3 Jun 2019 11:06:57 +0200 (CEST)
Received: by mail-wr1-f68.google.com with SMTP id w13so11129639wru.11
	for <drbd-dev@lists.linbit.com>; Mon, 03 Jun 2019 02:06:57 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	e13sm15107777wra.16.2019.06.03.02.06.56
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Jun 2019 02:06:56 -0700 (PDT)
Resent-Message-ID: <20190603090654.GG5803@soda.linbit>
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
	[209.85.166.43])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0D23A1011B9A
	for <drbd-dev@lists.linbit.com>; Fri, 31 May 2019 21:08:28 +0200 (CEST)
Received: by mail-io1-f43.google.com with SMTP id k8so9139953iot.1
	for <drbd-dev@lists.linbit.com>; Fri, 31 May 2019 12:08:28 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191]) by smtp.gmail.com with ESMTPSA id
	o192sm2828981itb.0.2019.05.31.12.01.25
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 12:01:26 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
Date: Fri, 31 May 2019 13:01:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] drbd_nl.c:drbd_adm_prepare() indexes drbd_genl_ops[] by
	cmd number
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

(Is this the right place to send comments on the source code such as this one?)

In drbd_nl.c:

  static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
  	struct sk_buff *skb, struct genl_info *info, unsigned flags)
  {
  	struct drbd_genlmsghdr *d_in = info->userhdr;
  	const u8 cmd = info->genlhdr->cmd;
  	int err;
  
  	memset(adm_ctx, 0, sizeof(*adm_ctx));
  
+ 	//XXX I do not think you can find the ops for a command number by indexing this array.
+ 	//XXX The array is unordered and packed.  I think it must search like genl_get_cmd().
  	/*
  	 * genl_rcv_msg() only checks if commands with the GENL_ADMIN_PERM flag
  	 * set have CAP_NET_ADMIN; we also require CAP_SYS_ADMIN for
  	 * administrative commands.
  	 */
  	if ((drbd_genl_ops[cmd].flags & GENL_ADMIN_PERM) &&
  	    drbd_security_netlink_recv(skb, CAP_SYS_ADMIN))
  		return -EPERM;
  
  	adm_ctx->reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
  	if (!adm_ctx->reply_skb) {
  		err = -ENOMEM;
  		goto fail;
  	}
