Return-Path: <andersson@kernel.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id D9ED84202BA
	for <drbd-dev@lists.linbit.com>;
	Sun,  6 Oct 2024 04:07:37 +0200 (CEST)
From: Bjorn Andersson <andersson@kernel.org>
To: linux-gpio@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Date: Sat,  5 Oct 2024 20:55:35 -0500
Message-ID: <172817973322.398361.12931602917664759173.b4-ty@kernel.org>
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

[24/35] soc: qcom: qmi: Reorganize kerneldoc parameter names
        commit: eea73fa08e69fec9cdc915592022bec6a9ac8ad7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
