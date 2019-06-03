Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C6EFB1028A64
	for <drbd-dev@lists.linbit.com>; Mon,  3 Jun 2019 11:21:21 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id h1so11216938wro.4
	for <drbd-dev@lists.linbit.com>; Mon, 03 Jun 2019 02:21:21 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	t14sm15817646wrr.33.2019.06.03.02.21.19
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Jun 2019 02:21:20 -0700 (PDT)
Date: Mon, 3 Jun 2019 11:21:18 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190603092118.GH5803@soda.linbit>
References: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5c1cf53-0eb7-35ab-7fbb-cb64e5f16305@gmail.com>
Subject: Re: [Drbd-dev] drbd_nl.c:drbd_adm_prepare() indexes drbd_genl_ops[]
 by cmd number
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

On Fri, May 31, 2019 at 01:01:24PM -0600, David Butterfield wrote:
> (Is this the right place to send comments on the source code such as this one?)
> 
> In drbd_nl.c:
> 
>   static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
>   	struct sk_buff *skb, struct genl_info *info, unsigned flags)
>   {
>   	struct drbd_genlmsghdr *d_in = info->userhdr;
>   	const u8 cmd = info->genlhdr->cmd;
>   	int err;
>   
>   	memset(adm_ctx, 0, sizeof(*adm_ctx));
>   
> + 	//XXX I do not think you can find the ops for a command number by indexing this array.
> + 	//XXX The array is unordered and packed.  I think it must search like genl_get_cmd().


drbd_genl_ops is a static struct genl_ops [], indexed by cmd.

family->ops is a struct genl_ops*, pointing to an array
indexed by "i" [0 .. (family->n_ops - 1)]

Any specific reason you are spending time with this code in particular?

>   	/*
>   	 * genl_rcv_msg() only checks if commands with the GENL_ADMIN_PERM flag
>   	 * set have CAP_NET_ADMIN; we also require CAP_SYS_ADMIN for
>   	 * administrative commands.
>   	 */
>   	if ((drbd_genl_ops[cmd].flags & GENL_ADMIN_PERM) &&
>   	    drbd_security_netlink_recv(skb, CAP_SYS_ADMIN))
>   		return -EPERM;
>   
>   	adm_ctx->reply_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>   	if (!adm_ctx->reply_skb) {
>   		err = -ENOMEM;
>   		goto fail;
>   	}

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
