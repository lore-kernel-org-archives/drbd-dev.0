Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 3A3454201C4
	for <drbd-dev@lists.linbit.com>; Thu,  6 Oct 2022 15:09:01 +0200 (CEST)
Date: Thu, 6 Oct 2022 16:01:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <Yz7Rl7BXamKQhRzH@smile.fi.intel.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
	<20221005214844.2699-4-Jason@zx2c4.com>
	<20221006084331.4bdktc2zlvbaszym@quack3>
	<Yz7LCyIAHC6l5mG9@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7LCyIAHC6l5mG9@zx2c4.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Darrick J . Wong" <djwong@kernel.org>,
	linux-block@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	dri-devel@lists.freedesktop.org, Andrii Nakryiko <andrii@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-sctp@vger.kernel.org,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Andy Gospodarek <andy@greyhouse.net>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Rohit Maheshwari <rohitm@chelsio.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nilesh Javali <njavali@marvell.com>, Jean-Paul Roubelat <jpr@f6fbb.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
	Arend van Spriel <aspriel@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Andy Lutomirski <luto@kernel.org>, linux-hams@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	linux-kernel@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Sharvari Harisangam <sharvari.harisangam@nxp.com>,
	linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-wireless@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
	target-devel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Stanislav Fomichev <sdf@google.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	drbd-dev@lists.linbit.com, dev@openvswitch.org,
	Leon Romanovsky <leon@kernel.org>, Helge Deller <deller@gmx.de>,
	Hugh Dickins <hughd@google.com>, James Smart <james.smart@broadcom.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Pravin B Shelar <pshelar@ovn.org>, Julian Anastasov <ja@ssi.bg>,
	coreteam@netfilter.org, Veaceslav Falico <vfalico@gmail.com>,
	Yonghong Song <yhs@fb.com>, Namjae Jeon <linkinjeon@kernel.org>,
	linux-media@vger.kernel.org, Ganapathi Bhat <ganapathi017@gmail.com>,
	linux-actions@lists.infradead.org, Simon Horman <horms@verge.net.au>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Hao Luo <haoluo@google.com>, Theodore Ts'o <tytso@mit.edu>,
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Florian Westphal <fw@strlen.de>, "David S . Miller" <davem@davemloft.net>,
	Jon Maloy <jmaloy@redhat.com>, Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-nvme@lists.infradead.org, Michal Januszewski <spock@gentoo.org>,
	linux-mtd@lists.infradead.org, kasan-dev@googlegroups.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>,
	Ajay Singh <ajay.kathat@microchip.com>, Sagi Grimberg <sagi@grimberg.me>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, lvs-devel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Marco Elver <elver@google.com>,
	Kees Cook <keescook@chromium.org>, Yury Norov <yury.norov@gmail.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Borislav Petkov <bp@alien8.de>, Keith Busch <kbusch@kernel.org>,
	ceph-devel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Franky Lin <franky.lin@broadcom.com>, linux-nfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Wenpeng Liang <liangwenpeng@huawei.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Xinming Hu <huxinming820@gmail.com>, linux-mmc@vger.kernel.org,
	SHA-cyfmac-dev-list@infineon.com, linux-xfs@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Jan Kara <jack@suse.cz>, linux-stm32@st-md-mailman.stormreply.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ayush Sawal <ayush.sawal@chelsio.com>, KP Singh <kpsingh@kernel.org>,
	Amitkumar Karwar <amitkarwar@gmail.com>, linux-mm@kvack.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Akinobu Mita <akinobu.mita@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-f2fs-devel@lists.sourceforge.net, Jack Wang <jinpu.wang@ionos.com>,
	Steffen Klassert <steffen.klassert@secunet.com>, rds-devel@oss.oracle.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-scsi@vger.kernel.org, dccp@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michael Jamet <michael.jamet@intel.com>, Kalle Valo <kvalo@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, linux-raid@vger.kernel.org,
	Thomas Graf <tgraf@suug.ch>, Hannes Reinecke <hare@suse.de>,
	Xiubo Li <xiubli@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
	Jens Axboe <axboe@kernel.dk>, cake@lists.bufferbloat.net,
	brcm80211-dev-list.pdl@broadcom.com, Yishai Hadas <yishaih@nvidia.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vinod Koul <vkoul@kernel.org>,
	tipc-discussion@lists.sourceforge.net, dmaengine@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sungjong Seo <sj1557.seo@samsung.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Drbd-dev] [f2fs-dev] [PATCH v1 3/5] treewide: use
 get_random_u32() when possible
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

On Thu, Oct 06, 2022 at 06:33:15AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 06, 2022 at 10:43:31AM +0200, Jan Kara wrote:

...

> > The code here is effectively doing the
> > 
> > 	parent_group = prandom_u32_max(ngroups);
> > 
> > Similarly here we can use prandom_u32_max(ngroups) like:
> > 
> > 		if (qstr) {
> > 			...
> > 			parent_group = hinfo.hash % ngroups;
> > 		} else
> > 			parent_group = prandom_u32_max(ngroups);
> 
> Nice catch. I'll move these to patch #1.

I believe coccinelle is able to handle this kind of code as well, so Kees'
proposal to use it seems more plausible since it's less error prone and more
flexible / powerful.

-- 
With Best Regards,
Andy Shevchenko


