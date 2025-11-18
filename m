Return-Path: <hsukrut3@gmail.com>
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
	[209.85.167.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E9B521608F4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 10:09:39 +0100 (CET)
Received: by mail-lf1-f52.google.com with SMTP id
	2adb3069b0e04-591c9934e0cso7065387e87.0
	for <drbd-dev@lists.linbit.com>; Tue, 18 Nov 2025 01:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20251117172557.355797-1-hsukrut3@gmail.com>
	<aRwNfiIWUVl5G0eX@infradead.org>
In-Reply-To: <aRwNfiIWUVl5G0eX@infradead.org>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Tue, 18 Nov 2025 14:39:26 +0530
Message-ID: <CAHCkknrzdT1NkD1EGMPBGkamrg8fJY7Xu1GX6WjjPhquCyGQrg@mail.gmail.com>
Subject: Re: [PATCH] drbd: add missing kernel-doc for peer_device parameter
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, david.hunter.linux@gmail.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, shuah@kernel.org,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
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

On Tue, Nov 18, 2025 at 11:39=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Nov 17, 2025 at 10:55:56PM +0530, Sukrut Heroorkar wrote:
> > W=3D1 build warns that peer_device is undocumented in the bitmap I/O
> > handlers. This parameter was introduced in commit 8164dd6c8ae1
> > ("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
> > the kernel-doc was not updated.
> >
> > Add the missing @peer_device entry.
>
> Or just make it a non-kerneldoc comment as it doesn't document an
> external API to start with.
>
Thank you. I have sent another patch adhering to this suggestion.
