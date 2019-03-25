Return-Path: <rjwysocki@gmail.com>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DACF31011BF1
	for <drbd-dev@lists.linbit.com>; Mon, 25 Mar 2019 10:35:16 +0100 (CET)
Received: by mail-ot1-f67.google.com with SMTP id o74so7396653ota.3
	for <drbd-dev@lists.linbit.com>; Mon, 25 Mar 2019 02:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190322132108.25501-1-sakari.ailus@linux.intel.com>
	<20190322132108.25501-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20190322132108.25501-3-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Mar 2019 10:30:01 +0100
Message-ID: <CAJZ5v0i8JiQGk25yZKQqTzCCY+nrfoKXOH8nM6eNPhkN-i+y9w@mail.gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Petr Mladek <pmladek@suse.com>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	linux-um@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, linux-btrfs@vger.kernel.org,
	Linux PCI <linux-pci@vger.kernel.org>,
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
	ceph-devel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] vsprintf: Remove support for %pF and %pf
 in favour of %pS and %ps
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

On Fri, Mar 22, 2019 at 2:21 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> %pS and %ps are now the preferred conversion specifiers to print function
> %names. The functionality is equivalent; remove the old, deprecated %pF
> %and %pf support.

Are %pF and %pf really not used any more in the kernel?

If that is not the case, you need to convert the remaining users of
them to using %ps or %pS before making support for them go away
completely.

That said, checkpatch can be made treat %pf/F as invalid format right away IMO.
