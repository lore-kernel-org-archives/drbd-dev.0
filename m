Return-Path: <philipp.reisner@linbit.com>
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 0363E160913
	for <drbd-dev@lists.linbit.com>; Thu, 31 Jul 2025 14:35:29 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id
	4fb4d7f45d1cf-615622ed677so1249804a12.1
	for <drbd-dev@lists.linbit.com>; Thu, 31 Jul 2025 05:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250709025553.694792-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20250709025553.694792-1-zhengbing.huang@easystack.cn>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 31 Jul 2025 14:35:17 +0200
Message-ID: <CADGDV=XQCgj644Hw3tnMEtnGh3WFH6YRZwekxJ9ySqMdbKwqKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rdma: Fix kernel crash in dtr_create_rx_desc()
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
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

Thanks for the analysis and the patch. I took the freedom and slightly
modified it before applying it. Instead of changing the behaviour of
the dtr_path_get_cm() function I introduce a new one:
dtr_path_get_cm_connected().

Please see
https://github.com/LINBIT/drbd/commit/ae1b0bdfa2e4ea59d15199b55a6f0c571844f576

Also ...

[...]
> -       for (i = DATA_STREAM; i <= CONTROL_STREAM ; i++)
> -               dtr_create_rx_desc(&path->flow[i], GFP_NOIO);
> -

I dropped this part. It came without explanation in the commit
message. I believe that some RDMA transports require at least one
rx-descriptor to enable them to establish a connection.


Best regards,
 Philipp
