Return-Path: <ciprich@linuxbox.cz>
Received: from develbox.linuxbox.cz (gw3.lbox.cz [62.245.111.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB65310674DA
	for <drbd-dev@lists.linbit.com>; Wed, 25 Nov 2009 11:51:17 +0100 (CET)
Date: Wed, 25 Nov 2009 07:50:50 +0100
From: Nikola Ciprich <extmaillist@linuxbox.cz>
To: drbd devel list <drbd-dev@lists.linbit.com>
Message-ID: <20091125065050.GA1553@develbox.linuxbox.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: nikola.ciprich@linuxbox.cz
Subject: [Drbd-dev] 2.6.32 + latest drbd from linux-2.6-drbd.git - still
	getting	split-brains
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
I'm testing 2.6.32-rc8 with drbd patches taken from linux-2.6-drbd.git but I'm still
having problems with split-brains:
[  386.046744] block drbd0: uuid_compare()=100 by rule 90
[  386.046831] block drbd0: Split-Brain detected, dropping connection!
According to git logs similar problem has been already fixed, but I have the patch applied
and still am getting those errors.
Here's the list of git commits applied to get drbd to my kernel:

b411b3637fa71fce9cf2acf0639009500f5892fe
ab8fafc2e1ecc0090f2c78902d3b992eec8b11f8
6a0afdf58d40200abd0c717261d1bc4c49195c2f
25d2d4edfa509b69fe4832094b8a07e634363ba3
9f5180e5c331d7b3ccc35e1a78072235d38f9f34
132cc538cd90f60a0b5df6a512dfd4bc5fe2039a
a870a3a485ddf7c0dec549269ed71d169556d61c
ad19bf6e544f4d1abc22d2be130c7d5e4163146f
1352994b363195ce932749d3518d4dc9a5479fea
0a4921662513ae60dc638c8e13fbe3439d84db64
e656ec8ae2c0319b6d52834695f9635217d62de5
83c38830b04d4e369b9a41acbc562c0422f2f2f2
6c6c7951be7652f86109f2193651b78d90907c0d
0b33a9164aca6332bf4a117af5528dea9675d782
d8c2a36b774defd4e230353d91f0f609c128bd78
ed814525f2e45188964c270fc3a5a0b644f7e4a9
ad85dfe67bbf13d5fa20764e4ce801a1e6e526d8
I'm using 8.3.6 userspace. Is there anything else I should check?
Thanks a lot in advance!
with best regards
nik


-- 
-------------------------------------
Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
