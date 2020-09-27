Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0099.hostedemail.com
	[216.40.44.99])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E7D02420385
	for <drbd-dev@lists.linbit.com>; Sun, 27 Sep 2020 22:08:30 +0200 (CEST)
Message-ID: <9f6ebf51253bf420c8f6f8974a82283ae3e9e446.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, linux-iio@vger.kernel.org
Date: Sun, 27 Sep 2020 13:08:25 -0700
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Neil Armstrong <narmstrong@baylibre.com>, kernel-janitors@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	drbd-dev@lists.linbit.com, "Rafael J.
	Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
	Lechner <david@lechnology.com>,
	Blumenstingl <martin.blumenstingl@googlemail.com>, David,
	linux-block@vger.kernel.org, Martin,
	linux-amlogic@lists.infradead.org, Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, Thomas,
	Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, openipmi-developer@lists.sourceforge.net
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

On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> These patches replace commas by semicolons.  This was done using the
> Coccinelle semantic patch (http://coccinelle.lip6.fr/) shown below.
> 
> This semantic patch ensures that commas inside for loop headers will not be
> transformed.  It also doesn't touch macro definitions.

Thanks.

All of these appear to be correct and without effect
except for __LINE__ number changes where braces are added.



