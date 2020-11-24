Return-Path: <kuba@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1C76F4207BB
	for <drbd-dev@lists.linbit.com>; Tue, 24 Nov 2020 02:46:54 +0100 (CET)
Date: Mon, 23 Nov 2020 17:46:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20201123174648.6a22575b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
	<20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<202011201129.B13FDB3C@keescook>
	<20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<202011220816.8B6591A@keescook>
	<CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	dm-devel@redhat.com, keyrings@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
	32-BIT AND 64-BIT <" <x86@kernel.org>,
	xen-devel@lists.xenproject.org, linux-hardening@vger.kernel.org,
	Nathan  Chancellor <natechancellor@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Joe  Perches <joe@perches.com>"@domain.invalid>,
	bridge@lists.linux-foundation.org,
	amd-gfx list <amd-gfx@lists.freedesktop.org>,
	cluster-devel@redhat.com, linux-acpi@vger.kernel.org,
	coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
	"maintainer:X86"@domain.invalid, ARCHITECTURE@domain.invalid,
	GR-Linux-NIC-Dev@marvell.com, Kees Cook <keescook@chromium.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	intel-gfx@lists.freedesktop.org, linux-can@vger.kernel.org,
	linux-block@vger.kernel.org, GR-everest-linux-l2@marvell.com,
	ceph-devel@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
	<linux-crypto@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-geode@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-hams@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i3c@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Linux Memory Management List  <linux-mm@kvack.org>,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Linux-Renesas  <linux-renesas-soc@vger.kernel.org>,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-wireless  <linux-wireless@vger.kernel.org>,
	Network Development  <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
	op-tee@lists.trustedfirmware.org, oss-drivers@netronome.com,
	patches@opensource.cirrus.com, rds-devel@oss.oracle.com,
	reiserfs-devel@vger.kernel.org, samba-technical@lists.samba.org,
	selinux@vger.kernel.org, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux-foundation.org,
	wcn36xx@lists.infradead.org, "@domain.invalid
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

On Mon, 23 Nov 2020 17:32:51 -0800 Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote: =20
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=3D2 kind of a warning. =
=20
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO=
8gxSp=3DKr_CQ@mail.gmail.com/ =20
>=20
> So looks like the bulk of these are:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     break;
> }
>=20
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895

=F0=9F=98=8D
