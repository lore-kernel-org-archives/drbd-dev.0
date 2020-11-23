Return-Path: <broonie@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CB8664205F6
	for <drbd-dev@lists.linbit.com>; Mon, 23 Nov 2020 21:39:10 +0100 (CET)
Date: Mon, 23 Nov 2020 20:38:46 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-Id: <160616392671.21180.16517492185091399884.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
	usb-storage@lists.one-eyed-alien.net,
	Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org,
	wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org,
	linux1394-devel@lists.sourceforge.net,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
	rds-devel@oss.oracle.com, l@domain.invalid,
	linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org,
	ceph-devel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	cluster-devel@redhat.com, oss-drivers@netronome.com,
	linux-mmc@vger.kernel.org, coreteam@netfilter.org,
	intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, xen-devel@lists.xenproject.org,
	linux-ext4@vger.kernel.org, linux-media@vger.kernel.org,
	GR-Linux-NIC-Dev@marvell.com, Kees Cook <keescook@chromium.org>,
	selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, reiserfs-devel@vger.kernel.org,
	linux-geode@lists.infradead.org, linux-block@vger.kernel.org,
	linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	linux-mediatek@lists.infradead.org,
	samba-technical@lists.samba.org, linux-fbdev@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org,
	Nathan Chancellor <natechancellor@gmail.com>,
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-nfs@vger.kernel.org, inux-ide@vger.kernel.org,
	netfilter-devel@vger.ke, linux-decnet-user@lists.sourceforge.net,
	patches@opensource.cirrus.com, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, dm-devel@redhat.com,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-crypto@vger.kernel.org, rnel.org@domain.invalid,
	Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
	netdev@vger.kernel.org, GR-everest-linux-l2@marvell.com
Subject: Re: [Drbd-dev] [PATCH 000/141] Fix fall-through warnings for Clang
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

On Fri, 20 Nov 2020 12:21:39 -0600, Gustavo A. R. Silva wrote:
> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: as3722: Fix fall-through warnings for Clang
      commit: b52b417ccac4fae5b1f2ec4f1d46eb91e4493dc5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
