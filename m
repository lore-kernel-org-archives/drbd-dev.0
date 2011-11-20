Return-Path: <florian@hastexo.com>
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com
	[209.85.214.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 94A8E10556BC
	for <drbd-dev@lists.linbit.com>; Sun, 20 Nov 2011 21:49:14 +0100 (CET)
Received: by bkbzs8 with SMTP id zs8so9892786bkb.27
	for <drbd-dev@lists.linbit.com>; Sun, 20 Nov 2011 12:49:14 -0800 (PST)
Message-ID: <4EC967C5.8070400@hastexo.com>
Date: Sun, 20 Nov 2011 21:49:09 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1321465105-13769-1-git-send-email-florian@hastexo.com>
	<1321465105-13769-2-git-send-email-florian@hastexo.com>
	<CAO+b5-qvbt-UZddZtO018j9v2euLOv2ph-oR1uuz__Fbc9+uHA@mail.gmail.com>
In-Reply-To: <CAO+b5-qvbt-UZddZtO018j9v2euLOv2ph-oR1uuz__Fbc9+uHA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH 1/3] User's Guide: add section on DRBD over
 InfiniBand
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Bart,

On 11/19/11 14:21, Bart Van Assche wrote:
> On Wed, Nov 16, 2011 at 6:38 PM, Florian Haas <florian@hastexo.com> wrote:
>> +To enable IPoIB, you need to enable the +ib_ipoib+ driver, typically
>> +available on any system stock kernel as a loadable module. Make sure
>> +that you configure the IPoIB driver to run in the Reliable Connected
>> +(RC) transport mode.
> 
> Maybe it's a good idea to mention here the impact of the IPoIB MTU on
> IPoIB bandwidth ?
> 
> On a typical setup these options can be configured as follows in
> /etc/infiniband/openib.conf:
> SET_IPOIB_CM=yes
> IPOIB_MTU=65520
> 
> By the way, that last setting is the default with recent versions of
> /etc/init.d/openibd.

Thanks for the suggestion; I've worked that in. I try not to go into too
much detail regarding configuration paths and init scripts as those may
very wildly by distro and release, but I've mentioned the relevant sysfs
files now. Diff is below.

Cheers,
Florian


diff --git a/users-guide/hp-transports.txt b/users-guide/hp-transports.txt
index 35fa5bd..dbd0186 100644
--- a/users-guide/hp-transports.txt
+++ b/users-guide/hp-transports.txt
@@ -23,14 +23,25 @@ resource configuration. DRBD then replicates using
TCP over IP --
 albeit not based on Ethernet as it normally would, but on InfiniBand.

 To enable IPoIB, you need to enable the +ib_ipoib+ driver, typically
-available on any system stock kernel as a loadable module. Make sure
-that you configure the IPoIB driver to run in the Reliable Connected
-(RC) transport mode.
+available on any system stock kernel as a loadable module.
+
+Make sure that you configure the IPoIB driver to run in the Reliable
+Connected (RC) transport mode. The transport mode is accessible via
+the +/sys/class/net/<interface>/mode+ virtual file. An example for
+setting the transport mode for the +ib0+ interface would be the
+following command:
+
+  echo connected > /sys/class/net/ib0/mode
+
+Distributions may, however, offer more convenient methods for setting
+the transport mode permanently.

 NOTE: The configuration of an IP address on an IPoIB is beyond the
 scope of this guide, and may vary between distributions. However, it
 is usually equivalent to the configuration of an Ethernet interface --
 simply replace +ethX+ with +ibX+ in the interface configuration.
+This also applies for the interface MTU, which you may set to as high
+as 65,520 bytes for IPoIB in connected mode.

 In the example below, +192.168.144.111+ and +192.168.144.112+ would be
 bound to an IPoIB interface -- for example, +ib0+.
