Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0097.hostedemail.com
	[216.40.44.97])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 2DD74420AE0
	for <drbd-dev@lists.linbit.com>; Tue, 29 Sep 2020 02:46:30 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 1D2F218005A6F
	for <drbd-dev@lists.linbit.com>; Tue, 29 Sep 2020 00:46:00 +0000 (UTC)
Message-ID: <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, Julia Lawall
	<Julia.Lawall@inria.fr>
Date: Mon, 28 Sep 2020 17:45:24 -0700
In-Reply-To: <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
	<160132172369.55460.9237357219623604216.b4-ty@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
	=?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	David Lechner <david@lechnology.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-wireless@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valdis, linux-block@vger.kernel.org, linux-acpi@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	openipmi-developer@lists.sourceforge.net, drbd-dev@lists.linbit.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [Drbd-dev] [PATCH 00/18] use semicolons rather than commas to
 separate statements
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

On Mon, 2020-09-28 at 20:35 +0100, Mark Brown wrote:
> On Sun, 27 Sep 2020 21:12:10 +0200, Julia Lawall wrote:
> > These patches replace commas by semicolons.  This was done using the
> > Coccinelle semantic patch (http://coccinelle.lip6.fr/) shown below.
> > 
> > This semantic patch ensures that commas inside for loop headers will not be
> > transformed.  It also doesn't touch macro definitions.
> > 
> > Coccinelle ensures that braces are added as needed when a single-statement
> > branch turns into a multi-statement one.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> 
> Thanks!
> 
> [1/1] regmap: debugfs: use semicolons rather than commas to separate statements
>       commit: 7f4a122d0b50b40c64d24a5cf7aafe26dd9487ee

Hi Mark.

Rather than replying to the 0/n cover letter to a patch
series, can you reply to each of the specific patches in
the patch series you are applying?

Otherwise, it's a bit difficult to figure out which patches
you are applying.

thanks

