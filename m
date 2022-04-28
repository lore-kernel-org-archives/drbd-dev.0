Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 15BDE4201DC
	for <drbd-dev@lists.linbit.com>; Thu, 28 Apr 2022 11:49:21 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id a1so4875048edt.3
	for <drbd-dev@lists.linbit.com>; Thu, 28 Apr 2022 02:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220218083713.3645497-1-rui.xu@easystack.cn>
	<CAGNP_+Wmwm7spGK+ba99mVo6us6bu32KHmr1h8sup+LPCQTw9w@mail.gmail.com>
In-Reply-To: <CAGNP_+Wmwm7spGK+ba99mVo6us6bu32KHmr1h8sup+LPCQTw9w@mail.gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Thu, 28 Apr 2022 10:49:10 +0100
Message-ID: <CAGNP_+VV3JWfvuReg40ogzUxL3nF0O7=73JMbo4gSMePmxj5NQ@mail.gmail.com>
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

Applied as
https://github.com/LINBIT/drbd/commit/ecd0bd0c884ae7171b62c38b8f2c56a333898bc5

Thanks!
Joel

On Fri, 18 Feb 2022 at 12:32, Joel Colledge <joel.colledge@linbit.com> wrote:
>
> Looks good to me for drbd-9.0. We would have to take care with the
> merge up to the actively maintained branches in order to avoid losing
> the drbd_handle_io_error() call. I suggest we just add the condition
> to the !__test_and_set_bit(__EE_SEND_WRITE_ACK,...) check. The extra
> drbd_set_out_of_sync() call is harmless and it keeps the branches
> similar.
>
> Best regards,
> Joel
