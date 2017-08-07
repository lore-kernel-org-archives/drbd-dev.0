Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
	[209.85.128.175])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 599991057FF5
	for <drbd-dev@lists.linbit.com>; Mon,  7 Aug 2017 15:14:56 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id k71so1693678wrc.2
	for <drbd-dev@lists.linbit.com>; Mon, 07 Aug 2017 06:14:56 -0700 (PDT)
Date: Mon, 7 Aug 2017 15:14:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Message-ID: <20170807131452.GI25125@soda.linbit>
References: <51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57@MX205CL03.corp.emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51A32CC3BE64BC488E01AC3BDCB9F0A301CE8A57@MX205CL03.corp.emc.com>
Cc: Ranganatha.Venkatesh@Dell.com
Subject: Re: [Drbd-dev] Need info  on below ERROR messages
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 07, 2017 at 05:54:03AM +0000, Venkateshaiah, Ranganatha wrote:
> Hi,
> 
>      I'm using SLES11 SP1 Enterprise server edition. Below kernel
>      error messages are keep on logging in the log.  Could you please
>      let me know the reason and fix  for the below error message.
>      Could you please help me out on this.
> 
> 
>     =======================================================================================================================================
> 
>     [494837.186385] Modules linked in: af_packet bonding iscsi_ibft iscsi_boot_sysfs
> ip6t_REJECT xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw ipt_REJECT iptable_raw xt_CT iptable_filter ip6table_mangle nf_conntrack_ipv4
> nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tables ext4 crc16 mbcache jbd2 mgag200 i2c_algo_bit ttm drm_kms_helper
> drm syscopyarea sysfillrect sysimgblt ipmi_devintf joydev iTCO_wdt bnx2 iTCO_vendor_support i7core_edac gpio_ich edac_core ioatdma dca serio_raw shpchp
> lpc_ich mfd_core ipmi_si ipmi_msghandler button coretemp pcspkr kvm processor crc32c_intel dcdbas(X) btrfs xor raid6_pq sr_mod cdrom ata_generic hid_generic
> usbhid sd_mod ata_piix ahci libahci uhci_hcd ehci_pci ehci_hcd usbcore libata megaraid_sas usb_common sg scsi_mod autofs4
> 
> ==========================================================================================================================================


Well, that message tells you that (... list of names of modules ...)
have been loaded at the time that message was generated.

I don't see why you post this to the DRBD list?

Regardless, unless you give some more context on
your expectations and observations
what you did, what happened, what you think should have happened,
I suspect no-one will be able to help you.

There should be some lines before and after that line as well,
maybe posting those would be suficient to "guess" a more suitable
answer...

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
