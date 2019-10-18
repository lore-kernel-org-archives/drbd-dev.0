Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0149.hostedemail.com
	[216.40.44.149])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8036F42033D
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2019 17:43:43 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
	[10.5.19.251])
	by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 3B1B518113653
	for <drbd-dev@lists.linbit.com>; Fri, 18 Oct 2019 15:36:57 +0000 (UTC)
Message-ID: <86695bdf8e8e7425b680dcbcb23acec5e58853da.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>, Petr Mladek <pmladek@suse.com>, Stephen
	Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20191018152226.GA32150@lst.de>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
	<20191018142626.vmbgclelw23h5pdn@pathway.suse.cz>
	<20191018152226.GA32150@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Lars, Mark Rutland <mark.rutland@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ingo,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Herrenschmidt <benh@kernel.crashing.org>,
	Palmer Dabbelt <palmer@sifive.com>, Corentin,
	Jaroslav Kysela <perex@perex.cz>,
	David Howells <dhowells@redhat.com>, Felker <dalias@libc.org>,
	Andy, Rich, "H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
	Benjamin, Stephen Rothwell <sfr@canb.auug.org.au>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Molnar <mingo@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Darren Hart <dvhart@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	Song Liu <songliubraving@fb.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Robert Richter <rric@kernel.org>, Will Deacon <will@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Ellenberg <lars.ellenberg@linbit.com>, linux-fbdev@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Whitcroft <apw@canonical.com>, Takashi Iwai <tiwai@suse.com>,
	bpf@vger.kernel.org, Axboe <axboe@kernel.dk>,
	Karsten Keil <isdn@linux-pingi.de>, Tony Luck <tony.luck@intel.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sangbeom Kim <sbkim73@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Jens,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	James Morse <james.morse@arm.com>, Chary <corentin.chary@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter,
	linuxppc-dev@lists.ozlabs.org, "David S.
	Miller" <davem@davemloft.net>, Andy Shevchenko <andy@infradead.org>
Subject: Re: [Drbd-dev] [PATCH v2 00/33] Kill pr_warning in the whole linux
	code
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
Date: Fri, 18 Oct 2019 15:43:43 -0000

(Adding Stephen Rothwell)

On Fri, 2019-10-18 at 17:22 +0200, Christoph Hellwig wrote:
> As I said before: please just send Linus a scripted conversion after
> the next -rc1.  There is no point in creating all this churn.	

I again ask for a scripted mechanism to be added to
-next to allow these types of scriptable patches to get
compilation coverage testing.


