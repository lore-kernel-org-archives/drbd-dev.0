Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
	[209.85.218.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 4C82E421779
	for <drbd-dev@lists.linbit.com>; Fri, 18 Feb 2022 13:32:56 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id bg10so14725732ejb.4
	for <drbd-dev@lists.linbit.com>; Fri, 18 Feb 2022 04:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220218083713.3645497-1-rui.xu@easystack.cn>
In-Reply-To: <20220218083713.3645497-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 18 Feb 2022 13:32:45 +0100
Message-ID: <CAGNP_+Wmwm7spGK+ba99mVo6us6bu32KHmr1h8sup+LPCQTw9w@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, dongsheng.yang@easystack.cn,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd:don't increase unacked_cnt when resync
 write error
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

Looks good to me for drbd-9.0. We would have to take care with the
merge up to the actively maintained branches in order to avoid losing
the drbd_handle_io_error() call. I suggest we just add the condition
to the !__test_and_set_bit(__EE_SEND_WRITE_ACK,...) check. The extra
drbd_set_out_of_sync() call is harmless and it keeps the branches
similar.

Best regards,
Joel
