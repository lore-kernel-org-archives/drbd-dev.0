Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 49C561056446
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:47:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 3739B3F79D6
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:47:50 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2UpeyI5K3O6O for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:47:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 158A83F79D5
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:47:50 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8umvd2HblySn for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:47:49 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id CCFD53F79D3
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:47:49 +0200 (CEST)
Resent-Message-ID: <20160426124749.GM20950@soda.linbit>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A61C91056460
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:39:46 +0200 (CEST)
Received: by mail-wm0-f46.google.com with SMTP id u206so5123466wme.1
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 05:39:46 -0700 (PDT)
References: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
	<1461657978-13360-4-git-send-email-nicolas.dichtel@6wind.com>
	<20160426110848.GD27612@quack2.suse.cz>
To: Jan Kara <jack@suse.cz>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <571F5FBE.8050900@6wind.com>
Date: Tue, 26 Apr 2016 14:31:58 +0200
MIME-Version: 1.0
In-Reply-To: <20160426110848.GD27612@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Cc: dev@openvswitch.org, sd@queasysnail.net, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	jhs@mojatatu.com, pshelar@nicira.com, lars.ellenberg@linbit.com,
	jack@suse.com, johannes@sipsolutions.net,
	philipp.reisner@linbit.com, davem@davemloft.net,
	kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next 3/8] fs/quota: use
	nla_put_u64_64bit()
Reply-To: nicolas.dichtel@6wind.com
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

Le 26/04/2016 13:08, Jan Kara a =E9crit :
> On Tue 26-04-16 10:06:13, Nicolas Dichtel wrote:
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>=20
> OK, so I somewhat miss a description of what will this do to the netlin=
k
> message so that I can judge whether the change is fine for the userspac=
e
> counterpart parsing these messages. AFAIU this changes the message form=
at
> by adding a QUOTA_NL_A_PAD field before each 64-bit field which needs a=
n
> alignment, am I guessing right? Thus when the userspace counterpart use=
s
> genlmsg_parse() it should just silently ignore these attributes if I re=
ad
> the documentation right. Did I understand this correctly?
Yes, that's it.


Regards,
Nicolas
