Return-Path: <srinivas.kandagatla@linaro.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 154DD16096A
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2024 18:27:38 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
	ffacd0b85a97d-3862b364538so1264378f8f.1
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2024 09:27:38 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: nvdimm@lists.linux.dev, alsa-devel@alsa-project.org,
	Jan Kara <jack@suse.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	dccp@vger.kernel.org, Dai Ngo <Dai.Ngo@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	iommu@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	Robin Murphy <robin.murphy@arm.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	linux-arm-msm@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
	linux-sound@vger.kernel.org, maple-tree@lists.infradead.org,
	Tom Talpey <tom@talpey.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-omap@vger.kernel.org,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	audit@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
Date: Fri, 20 Dec 2024 17:27:39 -0000


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

