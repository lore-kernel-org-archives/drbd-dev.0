Return-Path: <axboe@kernel.dk>
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
	[209.85.166.181])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BD0F1420202
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 16:43:30 +0100 (CET)
Received: by mail-il1-f181.google.com with SMTP id o13so10933054ilc.7
	for <drbd-dev@lists.linbit.com>; Fri, 13 Jan 2023 07:43:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
References: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
Message-Id: <167362460873.11790.14664102108857579461.b4-ty@kernel.dk>
Date: Fri, 13 Jan 2023 08:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-block@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RESEND PATCH 0/3] DRBD file structure reorganization
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


On Fri, 13 Jan 2023 13:35:03 +0100, Christoph Böhmwalder wrote:
> To make our lives easier when sending future, more complex patches,
> we want to align the file structure as best as possible with what we
> have in the out-of-tree module.
> 
> Christoph Böhmwalder (3):
>   drbd: split off drbd_buildtag into separate file
>   drbd: drop API_VERSION define
>   drbd: split off drbd_config into separate file
> 
> [...]

Applied, thanks!

[1/3] drbd: split off drbd_buildtag into separate file
      commit: c058c9c9dcb137f395e1946b0f3595538479b3fd
[2/3] drbd: drop API_VERSION define
      commit: a68176e0f7cf1b68a84c3b7c08271af0d3d2e796
[3/3] drbd: split off drbd_config into separate file
      commit: 26547cb41a9f459535300275a319681a70cf69fe

Best regards,
-- 
Jens Axboe



