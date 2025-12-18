Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
	[209.85.218.41])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8628E162759
	for <drbd-dev@lists.linbit.com>; Thu, 18 Dec 2025 17:48:10 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
	a640c23a62f3a-b802d5e9f06so79732466b.1
	for <drbd-dev@lists.linbit.com>; Thu, 18 Dec 2025 08:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20251218130117.907395-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20251218130117.907395-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 18 Dec 2025 17:47:58 +0100
Message-ID: <CAGNP_+XBX=rmF_y25arQstkEFfqZnQRFWwXim79YibV+E0Xjpg@mail.gmail.com>
Subject: Re: [PATCH v2] drbd: only send P_PEERS_IN_SYNC for up to 4 MiB in
	resync progress
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: multipart/alternative; boundary="000000000000d22c6906463cb918"
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

--000000000000d22c6906463cb918
Content-Type: text/plain; charset="UTF-8"

Hi Zhengbing Huang,

Thanks for the contribution! I also considered this case but did not work
on any code to improve the behavior yet. I will look at your patch and
write again.

Thanks also for your recent RDMA patches. Philipp Reisner is aware of them
and will review them in due course.

Best regards,
Joel

--000000000000d22c6906463cb918
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Zhengbing Huang,</div><div><br></div><div>Thanks f=
or the contribution! I also considered this case but did not work on any co=
de to improve the behavior yet. I will look at your patch and write again.<=
/div><div><br></div><div>Thanks also for your recent RDMA patches.=C2=A0Phi=
lipp Reisner=C2=A0is aware of them and will review them in due course.</div=
><div><br></div><div>Best regards,</div><div>Joel</div><div><br></div></div=
>

--000000000000d22c6906463cb918--
