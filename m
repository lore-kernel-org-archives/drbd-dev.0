Return-Path: <jack@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8B213105645C
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:37:14 +0200 (CEST)
Date: Tue, 26 Apr 2016 14:37:07 +0200
From: Jan Kara <jack@suse.cz>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <20160426123707.GE27612@quack2.suse.cz>
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
	<1461657978-13360-4-git-send-email-nicolas.dichtel@6wind.com>
	<20160426110848.GD27612@quack2.suse.cz>
	<571F5FBE.8050900@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <571F5FBE.8050900@6wind.com>
Cc: dev@openvswitch.org, Jan Kara <jack@suse.cz>, sd@queasysnail.net,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next 3/8] fs/quota: use
	nla_put_u64_64bit()
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

On Tue 26-04-16 14:31:58, Nicolas Dichtel wrote:
> Le 26/04/2016 13:08, Jan Kara a écrit :
> > On Tue 26-04-16 10:06:13, Nicolas Dichtel wrote:
> >> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> > 
> > OK, so I somewhat miss a description of what will this do to the netlink
> > message so that I can judge whether the change is fine for the userspace
> > counterpart parsing these messages. AFAIU this changes the message format
> > by adding a QUOTA_NL_A_PAD field before each 64-bit field which needs an
> > alignment, am I guessing right? Thus when the userspace counterpart uses
> > genlmsg_parse() it should just silently ignore these attributes if I read
> > the documentation right. Did I understand this correctly?
> Yes, that's it.

OK, then feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

to the quota patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
