Return-Path: <joel.colledge@linbit.com>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 02B1F4202D3
	for <drbd-dev@lists.linbit.com>; Tue,  3 May 2022 10:37:39 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id g23so19048602edy.13
	for <drbd-dev@lists.linbit.com>; Tue, 03 May 2022 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210823023359.567225-1-rui.xu@easystack.cn>
In-Reply-To: <20210823023359.567225-1-rui.xu@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Tue, 3 May 2022 09:37:28 +0100
Message-ID: <CAGNP_+Up_UN9eCVShQ=Rg5yHpkFjEUiNcBpRJTMAgYiy=uwp2A@mail.gmail.com>
To: Rui Xu <rui.xu@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: Philipp Reisner <philipp.reisner@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: change the variable ov_left to atomic
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

Hi Xu,

Your analysis of the problem seems correct to me. Some details of the
fix could be improved.

In verify_progress() there are now 3 separate atomic operations. It
would be better to use atomic64_dec_return() and then use the returned
value instead of calling atomic64_read() separately. This could have
minor effects on the behavior.

Similarly, in receive_DataRequest() there is no need to read ov_left
again after setting it. This should have no effect on the behavior,
but leads to cleaner code.

Also the repeated reads in finish_state_change() could be avoided for
cleaner code. Take care of the read after set_ov_position(), since
that changes the value of ov_left. You could use peer_device->rs_total
instead of peer_device->ov_left there, since that is what it is set to
in set_ov_position().

Best regards,
Joel
