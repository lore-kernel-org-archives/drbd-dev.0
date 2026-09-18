Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F94AA030
	for <drbd-dev@lists.linux.dev>; Fri, 18 Sep 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741121; cv=fail; b=HkPWBwGGYToAKQsHH+wHaGEQoEQiGxm0E5xRtOW8FtnC7A0pPzS+OzlGgcNHtyovNiB2RBuF/tYWuxR/fZKYI3wtnyq24mv7VSBbeoaFqsG9YuCZi4hW5Dmkfak1gB2TyBeVz8INy9JRFaXp8KKzCs7DHz1XlOVaZu7gIkEVgT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741121; c=relaxed/simple;
	bh=14PMA+rdeb7H/ptKNQ2ggXX8ZxU+eMj3QdCeaSLx8Og=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PdXrTw1uZNRDDoxaGhQXJef/DhZHGOnkC0zQZYhq8KO5D9UThxXOYMGyM5cik2RltKOqLUiRRHpipxC5kD/xxY1b9PD7lP8DDm550fwT0kBRho9jO8OZ1habw8Vhz5jmYCo8Nv4SRlZ6oJL2ly36r+5GiU98qWI1Z4J4ZVqUnzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iip/7DYD; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iip/7DYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUnLp42mbbHcBcNoTfIvokzWWY0n8sYSGvnCv3b0LYrGBGmEIVBvgbTgfyVi1/dpXIlCAUV/6URdkQJhG3bVU/VaPRsM123KQuKlkAoHp/n2yrCqVj2Ism/Q8tF+1hhVCZbV8blN+hXB680BUhavZ5vqcws+KfIIUhbtjdARM8/OyDVSja0XR6vRklUVqpIpE+SEr43CSqF+jOkP8qjY1PSzklLg375GRZwCc+fkqgkBco7Tj8c02agcQkaeqxdZCm8Ys97Nb0uK5ZwEA2KoIQpQwdVodI46iNBi0oNBKHv7FJNJOvk8SBWE2SfJUQnVedGjCaTC9U7Nc+py4BMyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omu3cSDVEe3cPu0jpTj8/D0kl3wygES0hsgK9tje/RQ=;
 b=udO6D8mqyrBx1NR0OY9MsOKm3jkSDRPpxHF/rZgK5sbMQU26wxaGJ7OBTn6GEBMD+F6oMLcBzazUhtaQb1GGmRfHSSsRjQOTNDlYKnYpKXUGl8qFvgtZU0CmsFKhAlRygLkJ4lP8/uQlHEbtBEM/AUFWsLkXUpzDSshjGG7OUB2zHO3yRB1L4wqUuGSzd1gI0Bdg9VjmBtVBAIWkAMw0hiSRibyOv/HvtpynTVGwnAgeRZ0hgtPh5ORLNc4pHMF7MNC/MO16dSiPsfzYQemG63betLKvjHA1L7VyBqO0cZPl3AAAt1LGPY8Q6byTRsLSFwSP1i/SBzoxmyyoR4p45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omu3cSDVEe3cPu0jpTj8/D0kl3wygES0hsgK9tje/RQ=;
 b=Iip/7DYD3esqDBsRQ7Ox1yXL+z4PGVSn4Z4DyBUCq1gLX6OioEl6agrxpZx2O2VppKijDDIMWhI1SO4wJWNt47WUBfT/B/oBqK3naJA0M+faC4LzDnB2dLbUN6R7RhHCEbWmZbvuUfGIk9jneRgdFShoMA9mYG710U2ObSY7yvsVZO4MTj4GnsmzR7gLp/M+YUqTNzsBKmuZteL3CYPcUszL+UgkWrRGXBTCE6GfEOsf9Ln6Ef1xpu55FteOYmAZ++OWTWjMQPII1bxfg41aM9IoOTa8LeM7KXPUxPFhj42VAPqtejKtnVge7tajDGC3M1baV59oii0I6WvFp9WbKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MMZPR04MB960486.eurprd04.prod.outlook.com (2603:10a6:190:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:18:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:18:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Denis Efremov <efremov@linux.com>,
	Yuho Choi <dbgh9129@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hongyan Xu <getshell@seu.edu.cn>,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH] block: use assign_bit() where applicable
Date: Fri, 18 Sep 2026 22:16:04 +0800
Message-ID: <20260918141609.3022848-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0086.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MMZPR04MB960486:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d8bd99-2c89-40c7-f2a1-08df158fbaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	RrczN+o0siR/7RjGPu68BNRy0vQhet3FlyNrMZx9iEFqWzeL+Ar6qc9AInMaKteWq2IsClFJTRfgqiyXafAvrk9IxMkG5APffQXPekFHGWsHqH2EkAeXDxcQgHX2Q+UtRoq2nEBl5duJNxHHc8XDb9mRERR6YDyjRtCu9/xwPAr+OzfwMGNI39WCfjEpadSSTdAeZdDyPiy2QG8eTHlS5XqyQfYEbkSMopDhXdwh2/crjjtkGtOrDX35gc6cTpfPsOq+GZahG7QEze3Ys9bdRKY8DYHA0PftJkUQUhD19E6IJ1SLyeGRrpr4x2qIzxWVD0dsa9UMgT1YILedhLklsCIN6IIM2juFTgU9CtHDlJgDNLiOLDCXwMdmGU1EcZ39ke0IIk/+9NwtstImydmymAYwncoUXN4vKfOrvKgtV4J2aByrjOcxY3/91zwr4uDiVJ6SspQfjAe8B6LTi+UGibrDVH3MSr53jPhez3hr3KjYNzgwvx5R5/bRs/h18OLHpYXrtBOJpcmduOIlUjIkIbgOu5nAa+vTHFDp2apvbBsdlS4soXrvi2Vxi9dkn3Ln2Vhyl3ySa508XVOnotahJ8TKK13RrcONIolsH1dvtEZbnhEEjxiUS7jIdW7B5IpsrrfOL+mHa3Hp/hClaBRGLfbixEPO4GrJ7d59Gew8cpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRXcXXPTLPEWA2pvOISyqFI0tIIv0UUky+h/nx385ne51TqvhbZOvkQ40rWe?=
 =?us-ascii?Q?uEmFcJxaZD3H/Lfx2RowtFCviwVy/MVi0fzUSIjVvV4B0T8Oq2HkvkdtnMsv?=
 =?us-ascii?Q?aH0UbJsW3rXfNih5ctRQlR+n3iUXfzkaNY0L1t2hwrte1JE/aNxM1vRSl9l2?=
 =?us-ascii?Q?mvGb5JnQ3V4qz4AXv9BtEJ1G/jGCSoulbSs5Tm0yeWyKaz7pSNJiFaNmRZvr?=
 =?us-ascii?Q?QjaH1+/PZQ+wo0LtWGgbgWXrI7r1KNWwTg2MA6appL1YUXYdeyvNv5sL6zke?=
 =?us-ascii?Q?Gx2befkD53Hfvh5lZfl5F6FJfTvpG2B0cNZ2LHMQcAYFrlzK90khOYlubDnH?=
 =?us-ascii?Q?qdDcmUc2nFTeuJJYcHdxPxkjfVVgYGoCHlfyhaYB8MvRmkATx0YJ74FsHdjV?=
 =?us-ascii?Q?Mlgx0bULjpHf2hVhl+Z2H+LB59qqFsbj/uWyJec6w+6NYxkdVWWKgou3oHc/?=
 =?us-ascii?Q?UbtbVPNMpMGO6AnSmLtHWLnAiaCOjdz83G/z/DrWNBr8/8/e01WbpzatWfD5?=
 =?us-ascii?Q?tsQV/Ou/W46cX80wd6aFKBfEwJKX5tLD+Lk6rnvmXf3eio4qQHfj2VbNPH9m?=
 =?us-ascii?Q?Zaj/YMBsq3tbqh/K32Suh+bATbNOtlv8q2XZu4CSvHulQRChMF5yCd3RAwHo?=
 =?us-ascii?Q?WQKizrrSV5vLXZh65dHcu054/gSeX836QGUAi0L0wfR+SHwnQP9paUsNpApX?=
 =?us-ascii?Q?PExXkoDjx7zx3/Xsd3Lx+EmGo8nyLd68pPJmad1ThsdQGev1GIxVlv+4Gb9z?=
 =?us-ascii?Q?HKwcmHPIh2xQMOGnjtlTNtEuqcz6JIge6PpTe1KNoHJotQYumTLutgC7Rn8N?=
 =?us-ascii?Q?lj7XMcKvKcsSuzxOmeKKUr2u5bxU6ihWrbghOD3B+Zm4vPPkP/pOznP8i+oI?=
 =?us-ascii?Q?3Z1QWNCRG3KRbz6N19zBwcpHRtpSmLoUclKnwv6oLc2Ik4JUEe8jsKq/JdR0?=
 =?us-ascii?Q?fdUiSV5JPoJgrXSeUdk6RUdNKcrUXna5cAfxLxqT5oECnypNmN6z/Lur0U/V?=
 =?us-ascii?Q?lpK80gQOY7bO1SgDwGR9TgLSKFRoUcNmz0diiUJnCg91aAJEAWPtSCsqlOET?=
 =?us-ascii?Q?D7J7FFmZIb8FmDw45xtw6tY53j9hQFSvdFOSVxjkVu2eIUCb4h0q6ukspjBb?=
 =?us-ascii?Q?JHqA6u94V5rcUcIz2RQSSuit63wR+P3rBuOqKsrrGtPA+Iyn1gcxOyKkUdpi?=
 =?us-ascii?Q?gnw5h2gN4oj/a2YhfxSdvfx17rA5G+wAixGarxrA/PwzE/hT6jArZM3LwcIq?=
 =?us-ascii?Q?PsHhoN899zB34cuPLTP6z8BRPVgea7h7Fh+mhiVN2L2S1OeUFbyxvKkpkiLt?=
 =?us-ascii?Q?SSOO5eau/+Actm997sEEyegHBv4kgIug1aBin3WMmp2oh7K+010d2LvqnWrh?=
 =?us-ascii?Q?XQ52iSyn4sjEqKCG3VPbvjiCqnjC9ZlMNEl+dTfbOniV8cditIYp2fUbfmmr?=
 =?us-ascii?Q?HfI46BmE4BKUiV99SLWBDzWJAJh0U6ghBqP88APDvt584ILowrarfSyjcbSk?=
 =?us-ascii?Q?EUgV/4usVIA/9RbR7vuh/UqgwANnxyigDihJ0jL503+fwuUSsdV3S5Dp9fKe?=
 =?us-ascii?Q?b2J9XT4TWIzYAHpPUJk06ib5c4cCLpNf8Ky/IkEmQ9ZKzeOL44yszypchgFX?=
 =?us-ascii?Q?8zjaD/qih5NvfBD3faUqUOHZCfRFEWFLdSSLGfbOn4WbzkLCbvnM/Zcl2kr1?=
 =?us-ascii?Q?jNC1j0j6bjz+XQYNdk+jGijSV6KAFVeSEsenH1BTfy3bdwNTgJxDGIBjvYV3?=
 =?us-ascii?Q?ox5dw9369NHD0kGKTq0eIlhT+Ihqx3ML4KT7Knl4VCxDNvdqt8wn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d8bd99-2c89-40c7-f2a1-08df158fbaad
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:18:36.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yNMHhRrDb7qt5rosRY4RiWDim5RqEr9r9nxZVlvaocia/5FhOfgFiAsB7jl0AVfOUOksq0GhgUUGAcVG4vWffEYER6WXiBI/GAj/jCUArLu/vPdaTpHHjftxUofX9jk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB960486

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    // clear_bit -> set_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

    // __set_bit -> __clear_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __set_bit(bit, addr);
    -else
    -        __clear_bit(bit, addr);
    +__assign_bit(bit, addr, cond);

    // __clear_bit -> __set_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __clear_bit(bit, addr);
    -else
    -        __set_bit(bit, addr);
    +__assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/block/drbd/drbd_nl.c       | 16 ++++------------
 drivers/block/drbd/drbd_receiver.c |  5 +----
 drivers/block/floppy.c             |  8 ++------
 drivers/block/mtip32xx/mtip32xx.c  |  6 ++----
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b77f901fc3ef..b24fb2cc2f70 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1665,10 +1665,7 @@ int drbd_nl_chg_disk_opts_doit(struct sk_buff *skb, struct genl_info *info)
 	else
 		device->ldev->md.flags |= MDF_AL_DISABLED;
 
-	if (new_disk_conf->md_flushes)
-		clear_bit(MD_NO_FUA, &device->flags);
-	else
-		set_bit(MD_NO_FUA, &device->flags);
+	assign_bit(MD_NO_FUA, &device->flags, !new_disk_conf->md_flushes);
 
 	if (write_ordering_changed(old_disk_conf, new_disk_conf))
 		drbd_bump_write_ordering(device->resource, NULL, WO_BDEV_FLUSH);
@@ -2031,10 +2028,7 @@ int drbd_nl_attach_doit(struct sk_buff *skb, struct genl_info *info)
 
 	/* Reset the "barriers don't work" bits here, then force meta data to
 	 * be written, to ensure we determine if barriers are supported. */
-	if (new_disk_conf->md_flushes)
-		clear_bit(MD_NO_FUA, &device->flags);
-	else
-		set_bit(MD_NO_FUA, &device->flags);
+	assign_bit(MD_NO_FUA, &device->flags, !new_disk_conf->md_flushes);
 
 	/* Point of no return reached.
 	 * Devices and memory are no longer released by error cleanup below.
@@ -2053,10 +2047,8 @@ int drbd_nl_attach_doit(struct sk_buff *skb, struct genl_info *info)
 	drbd_bump_write_ordering(device->resource, device->ldev, WO_BDEV_FLUSH);
 	unlock_all_resources();
 
-	if (drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY))
-		set_bit(CRASHED_PRIMARY, &device->flags);
-	else
-		clear_bit(CRASHED_PRIMARY, &device->flags);
+	assign_bit(CRASHED_PRIMARY, &device->flags,
+		   drbd_md_test_flag(device->ldev, MDF_CRASHED_PRIMARY));
 
 	if (drbd_md_test_flag(device->ldev, MDF_PRIMARY_IND) &&
 	    !(device->state.role == R_PRIMARY && device->resource->susp_nod))
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..4dd651568411 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -920,10 +920,7 @@ static int conn_connect(struct drbd_connection *connection)
 		kref_get(&device->kref);
 		rcu_read_unlock();
 
-		if (discard_my_data)
-			set_bit(DISCARD_MY_DATA, &device->flags);
-		else
-			clear_bit(DISCARD_MY_DATA, &device->flags);
+		assign_bit(DISCARD_MY_DATA, &device->flags, discard_my_data);
 
 		drbd_connected(peer_device);
 		kref_put(&device->kref, drbd_destroy_device);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..2ca99a57b401 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1580,12 +1580,8 @@ static void check_wp(int fdc, int drive)
 			  "checking whether disk is write protected\n");
 		debug_dcl(drive_params[drive].flags, "wp=%x\n",
 			  reply_buffer[ST3] & 0x40);
-		if (!(reply_buffer[ST3] & 0x40))
-			set_bit(FD_DISK_WRITABLE_BIT,
-				&drive_state[drive].flags);
-		else
-			clear_bit(FD_DISK_WRITABLE_BIT,
-				  &drive_state[drive].flags);
+		assign_bit(FD_DISK_WRITABLE_BIT, &drive_state[drive].flags,
+			   !(reply_buffer[ST3] & 0x40));
 	}
 }
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 113bdb868c46..ff39ea9928e5 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1166,10 +1166,8 @@ static int mtip_get_identify(struct mtip_port *port, void __user *user_buffer)
 #endif
 
 	/* Check security locked state */
-	if (port->identify[128] & 0x4)
-		set_bit(MTIP_DDF_SEC_LOCK_BIT, &port->dd->dd_flag);
-	else
-		clear_bit(MTIP_DDF_SEC_LOCK_BIT, &port->dd->dd_flag);
+	assign_bit(MTIP_DDF_SEC_LOCK_BIT, &port->dd->dd_flag,
+		   port->identify[128] & 0x4);
 
 	/* Set the identify buffer as valid. */
 	port->identify_valid = 1;
-- 
2.51.0

