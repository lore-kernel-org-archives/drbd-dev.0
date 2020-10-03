Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0112.hostedemail.com
	[216.40.44.112])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 5238F420EF8
	for <drbd-dev@lists.linbit.com>; Sat,  3 Oct 2020 21:27:38 +0200 (CEST)
Message-ID: <c7fd58ebd81f8731fc03434b2bdd8aa4bf99335a.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Sat, 03 Oct 2020 12:27:03 -0700
In-Reply-To: <20201003191501.o56tqq63d2buq5ox@chatter.i7.local>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
	<160132172369.55460.9237357219623604216.b4-ty@kernel.org>
	<b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
	<20200929113745.GB4799@sirena.org.uk>
	<db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
	<20201001110150.GA6715@sirena.org.uk>
	<f44d19ad596f261c0287c9ab18c45161003efb43.camel@perches.com>
	<20201003191501.o56tqq63d2buq5ox@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Valdis,
	linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
	drbd-dev@lists.linbit.com, Neil Armstrong <narmstrong@baylibre.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-acpi@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>, David Lechner <david@lechnology.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	openipmi-developer@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-crypto@vger.kernel.org, tools@linux.kernel.org
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

On Sat, 2020-10-03 at 15:15 -0400, Konstantin Ryabitsev wrote:
> On Sat, Oct 03, 2020 at 11:40:48AM -0700, Joe Perches wrote:
> > (Adding tools and Konstantin Ryabitsev)
> > 
> > There seems to be some mismatch between b4's use of the
> > cover letter to a patch series and what maintainers that
> > apply a subset of the patches in the patch series.
> > 
> > The merge description shows the entire patch series as
> > applied, but the actual merge is only a subset of the
> > series.
> > 
> > Can this be improved in b4?
> 
> So, the following logic should be applied:
> 
> - if the entire series was applied, reply to 0/n
> - if a subset only is applied, reply to each n/n of the patch that was 
>   cherry-picked out of the series
> 
> Is that an accurate summary?

Exactly so, thanks.


