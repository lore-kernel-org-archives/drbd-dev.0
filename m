Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1186105644F
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B588340F00D
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RokFAdENm8Pk for <drbd-dev@lists.linbit.com>;
	Tue,  3 May 2016 12:50:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9379140F00F
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PoTe_LAksrcG for <drbd-dev@lists.linbit.com>;
	Tue,  3 May 2016 12:50:16 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 2FF3E40F00D
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 12:50:16 +0200 (CEST)
Resent-Message-ID: <20160503105015.GH16459@soda.linbit>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C96B21056444
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2016 11:28:44 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id e201so137896628wme.0
	for <drbd-dev@lists.linbit.com>; Tue, 03 May 2016 02:28:44 -0700 (PDT)
References: <20160426121850.GC20950@soda.linbit>
	<1462265435-15141-1-git-send-email-nicolas.dichtel@6wind.com>
To: lars.ellenberg@linbit.com
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <57286F49.8050107@6wind.com>
Date: Tue, 3 May 2016 11:28:41 +0200
MIME-Version: 1.0
In-Reply-To: <1462265435-15141-1-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: netdev@vger.kernel.org, drbd-dev@lists.linbit.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, philipp.reisner@linbit.com
Subject: Re: [Drbd-dev] [PATCH net-next] block/drbd: use nla_put_u64_64bit()
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

Le 03/05/2016 10:50, Nicolas Dichtel a =C3=A9crit :
> I had to define an intermediate function (nla_magic_put_flag()) because
> handlers in genl_magic_struct.h expect a function with three arguments.
>=20
> Note that this patch is only compile-tested.
>=20
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Please, drop it. I will send another version to handle all cases.
