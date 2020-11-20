Return-Path: <gustavo@embeddedor.com>
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
	[192.185.145.4])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id CFD9D420605
	for <drbd-dev@lists.linbit.com>; Fri, 20 Nov 2020 20:30:05 +0100 (CET)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
	by gateway33.websitewelcome.com (Postfix) with ESMTP id 63ED95C838C
	for <drbd-dev@lists.linbit.com>;
	Fri, 20 Nov 2020 13:04:52 -0600 (CST)
To: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
	<20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4609d49b-4dd3-c017-b76e-a8a536871c05@embeddedor.com>
Date: Fri, 20 Nov 2020 13:04:55 -0600
MIME-Version: 1.0
In-Reply-To: <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
	reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
	Nathan Chancellor <natechancellor@gmail.com>,
	linux-ide@vger.kernel.org, dm-devel@redhat.com,
	keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-hardening@vger.kernel.org, wcn36xx@lists.infradead.org,
	samba-technical@lists.samba.org, linux-i3c@lists.infradead.org,
	linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org,
	usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com,
	devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
	rds-devel@oss.oracle.com, Nick Desaulniers <ndesaulniers@google.com>,
	linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
	oss-drivers@netronome.com, bridge@lists.linux-foundation.org,
	linux-security-module@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	cluster-devel@redhat.com, linux-acpi@vger.kernel.org,
	coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
	linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-media@vger.kernel.org,
	GR-Linux-NIC-Dev@marvell.com, linux-watchdog@vger.kernel.org,
	selinux@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org,
	linux-can@vger.kernel.org, linux-block@vger.kernel.org,
	linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	linux-mediatek@lists.infradead.org,
	GR-everest-linux-l2@marvell.com, xen-devel@lists.xenproject.org,
	nouveau@lists.freedesktop.org, linux-hams@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, x86@kernel.org,
	linux-nfs@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-decnet-user@lists.sourceforge.net,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org, patches@opensource.cirrus.com,
	Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
	target-devel@vger.kernel.org
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


Hi,

On 11/20/20 12:53, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:
>> This series aims to fix almost all remaining fall-through warnings in
>> order to enable -Wimplicit-fallthrough for Clang.
>>
>> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
>> add multiple break/goto/return/fallthrough statements instead of just
>> letting the code fall through to the next case.
>>
>> Notice that in order to enable -Wimplicit-fallthrough for Clang, this
>> change[1] is meant to be reverted at some point. So, this patch helps
>> to move in that direction.
>>
>> Something important to mention is that there is currently a discrepancy
>> between GCC and Clang when dealing with switch fall-through to empty case
>> statements or to cases that only contain a break/continue/return
>> statement[2][3][4].
> 
> Are we sure we want to make this change? Was it discussed before?
> 
> Are there any bugs Clangs puritanical definition of fallthrough helped
> find?
> 
> IMVHO compiler warnings are supposed to warn about issues that could
> be bugs. Falling through to default: break; can hardly be a bug?!

The justification for this is explained in this same changelog text:

Now that the -Wimplicit-fallthrough option has been globally enabled[5],
any compiler should really warn on missing either a fallthrough annotation
or any of the other case-terminating statements (break/continue/return/
goto) when falling through to the next case statement. Making exceptions
to this introduces variation in case handling which may continue to lead
to bugs, misunderstandings, and a general lack of robustness. The point
of enabling options like -Wimplicit-fallthrough is to prevent human error
and aid developers in spotting bugs before their code is even built/
submitted/committed, therefore eliminating classes of bugs. So, in order
to really accomplish this, we should, and can, move in the direction of
addressing any error-prone scenarios and get rid of the unintentional
fallthrough bug-class in the kernel, entirely, even if there is some minor
redundancy. Better to have explicit case-ending statements than continue to
have exceptions where one must guess as to the right result. The compiler
will eliminate any actual redundancy.

Note that there is already a patch in mainline that addresses almost
40,000 of these issues[6].

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for clang for now")
[2] ClangBuiltLinux#636
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432
[4] https://godbolt.org/z/xgkvIh
[5] commit a035d552a93b ("Makefile: Globally enable fall-through warning")
[6] commit 4169e889e588 ("include: jhash/signal: Fix fall-through warnings for Clang")

Thanks
--
Gustavo
