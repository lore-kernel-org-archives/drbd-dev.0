Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D33AC0D3;
	Sun,  2 Aug 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785668814; cv=fail; b=ppzvH8xgZ+cvolvXSA9HkX+HWq2M5FEF6PSDeMkOk/mI8Y7/2+ocNkbdjT0dKQWSMvfaR3/6Yvdw03pvEj6UOhBkQ/aMSi8v1RzXtO6PjzzIlYYBsxJKcO2HydOlK//duicZg2nOWujN0A15Dw9cABFoymLKYsrCfSVe8MqL2Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785668814; c=relaxed/simple;
	bh=RI5d2SYAiaG93Rm/b3VbPktCt2yoT88PVi4DElfVtU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSqQBrYqfSi4gLhpglw27YLMhP744g3JAqyEvuH1BUfK41iZdFAlFt4dz6Nswez/td2QcQU0NuSKHYSaEGsgwpbuHTBVUSUDH/+/zAPyGmE+7WdvHdBrF7AcenyTU6iVFgJ1ii/9/XlOxRTEJpTGiT3RtV+X8inua6oM5o+na6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pEgOSq/5; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pEgOSq/5"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Awf9n2853383;
	Sun, 2 Aug 2026 04:06:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QdzXo41W9/i2heGgI8NLZscx5d+vrU8Pmq4hVFFH0o0=; b=
	pEgOSq/5vjpVY7Zhzx2HsbtszSCNTWdjKXi/FYZXTpAF9uLwVHS/cjJKoXrfBf7D
	W/fGarvDHjMJLtX43uH1KpQlubXATlnpCWA2Sp6CFX98XVfIleaxCGAZwqijKEvb
	i6DNB8fn3L6/stcbMVKAjUA0DAHHQ+dobZQl//WAfDBcoBpySCcE8imp0mMGe6ho
	cXxv8l12CzOpAhXKa0zWbS34KraczxN2jiYSUQFgTC9tcHGuqcWdtGvpfR83gm7G
	XV8FVdScpMtV++wunuzZh3eYpiUpqjkatPdnXSFuuG9BmBb5y6gi+9FvzTnG7Aea
	vyh7RgPxXHnEDix2TpTyDg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fsc31h2db-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 04:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpWxmgku+6X8uM/kuFMm5SWSdCfs0gPFlcxZ3fIlDC4ngB5OgEQJodIBR32IczGtryeffaIECIBm/06Ov3xcP9RertsLKOhuAO4gsn0eby+wuiRX77DMsPkrS3Y2r6NeCi+Z+8FUGqtw5fChBSe1kUZTOak+DjKEklRakF/Xm1B9zh1hCPSLYPX/rjP9dnHnymxE/7sRq7SxVmEAdoj/b4HVJZAXW+dn+zYzeRSVlzVIf2LQABLOkA8+Go9oy0tbG9BYx1ToIYJmF2ClcXiS0w3tsvtO8bG7r3mmBDWVEEi4+CpuLvFbkbwWz3VBA4D8kASejpaCQw5GrWyoRNIGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdzXo41W9/i2heGgI8NLZscx5d+vrU8Pmq4hVFFH0o0=;
 b=NLyW5AQ2gXLweF4o5vtV6pda+0AQpTPWRWt56UeKP3pc9mJNLLcP9pgliMjq2zOj/3UcpFdOUmbAmQOExZp3fgqiD8um70Y1YzBfm0/Nx5z81diSar5W2QyI8gUCj7WxS8PWj7LCUAw0rMIvCLi5pSoqciDp+mYdSE8G+Z5vtat7GZwoXIW+NyZUndsUFyepwzsEfs7fngsXu1knbGclxYWBhHcyTdC83EAaQn6wb6i59WLQ6K1vKfAIQkObdwRhMTGNPYJf1cJI3WMkZt1hAsqHPDX7tLDhFaJtFlJXNvb0tklXTdm5DwK0OtyKa4YvbPKLiE0ZAqKE0vkUZFctCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:06:25 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:06:25 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>,
        Ionut Nechita <ionut.nechita@windriver.com>, drbd-dev@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drbd: fix off-by-one in netlink NUL-string policy lengths
Date: Sun,  2 Aug 2026 14:05:51 +0300
Message-ID: <20260802110552.50757-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802110552.50757-1-ionut.nechita@windriver.com>
References: <20260802110552.50757-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: de22c2c2-7da0-4020-7fb5-08def08617f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	A1FBljSUb46rVn2cuoYz+V0CfjnwEVdVG/YbvFgogX+6Q37+nl3+iIPiZwCAWukgxdkbCru8fWyLOI7V9B0vUq7bYkG1GuO4hG76n3L0+w+N8Uj+iQvcjkUI0DuPLBBnf96hYLivtDzctfrFKacsPT0IaV8r14hQZw0G0DrawUyDaqyvbII/QGT6z/OadI/rOpM82EeeVsJaTOrPZwGXphhmIlM7PsgBKn8PEMuwadZkquzkqrfJBMTtqmiJuuICKNU+glv8/sUS4WY/dpmC7ppIBS98v+60DFv/biuu4MzIfdIoTuziREantXksoRBRH9xzwTaeMLC4QHE16gTmOcGkyv/REdaknOefTmiynhGOFb3nF1GbvRLjS9i0m4PfS66WNOBnJfXqrE8r6HVC+CoLCyg9vggRQ36dakuMG3aUynXyMCRRO78Ux5vFaTYeq5uTvA8NR8GShYn+RQG5mLFPQAeig7uC3D/3XjjAlEETpaiEeKwoCpZOaE9MH/I9mPWEjBura86zlJgZAf3NhIxbqXyF1zIddCcAQQVgknw5XZgzEIed7TkrPlAayqzj9j+0lbTZR83mjheEwgN2deCUhfdKVpGF/BupuLZCEUDS4aDcT855trGQG/yRZI9+o/oiDLUv7stKR1XzPnlU+2aFzggDIeW00gWN+KshVHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j0As9+r2R/wNwjUJZySZ2jbv1qd/8DnTg168Ic45hgHs7JrAdbD//fFdqcCC?=
 =?us-ascii?Q?3kPjc5NQq3RFHpozytVhmFu+ktiIWYq1SiCCofd/x3FFPx8vU2ZGTr5NBD5x?=
 =?us-ascii?Q?irsyST/ORlkJQpXBXUDMTkzWziMoJKYE0m+8cOa7IGMWeXrBnRQmEtKHuIl4?=
 =?us-ascii?Q?yb50rvOG071HJN05WmBJFOsczD1Z/2Yn96bT+6jhJIi8P9cBpAMn0cgWvw5c?=
 =?us-ascii?Q?1Yfz5vY+iCLnztB8cw9WZuQ8jWEVsNGpO9yqlmTJH/95uuBpzG/tacuSst6O?=
 =?us-ascii?Q?/JeBIJKT6zEiJIYtDhyLHLY5QZeQRl+txf/lOMra6tp1pF59mr3I3xSAi+g7?=
 =?us-ascii?Q?NB6e2WvUIrAGxD5KSCVV/W322qGxx7ftp3LWcCQR4dpiL9sy8ahyb+kgum2V?=
 =?us-ascii?Q?dAUHvUQ04RFVkr2MVy0B9wk4/4sxw/qrg63VEkdcikcJbNwjQSgQUG7e3K5L?=
 =?us-ascii?Q?2fGCyPqV1jBaYM/jJosSJZGAynqpCACxRDabbUyAhcQc0EJCzry3IpQiJJBw?=
 =?us-ascii?Q?tWGLKf4v2n0XCheEyueqZoNayRPynTdwHhPMG89b6JEP14vhOGA+TwHZylXf?=
 =?us-ascii?Q?Cdsi5f/V/0b53mlJq42QnfOPWooA8tjvkT88CkqneODe/jpW+0PkzwGE6BVE?=
 =?us-ascii?Q?ahXcrzjzOT4pHmX2mQDvuKSSBAoXtSIyrJ1Ufs0tc/uKhJVRSQjhYlYIYRrN?=
 =?us-ascii?Q?uHjhzuKugsFUYD3KS9TNvcRs2aUdL8Or+AcB1pmwV4uVkU+btE5f/xn23TeX?=
 =?us-ascii?Q?XBVUp6UDW4tpqKSCpWqOquBHD3YdgI4QStUPHwdPwNrtOfDc/aQszBxaOtqt?=
 =?us-ascii?Q?49GpIX/9NeVEzfWtqggsIWnBcUyzzBumy6U06N26jYEyXrdF1Xd6tZoOpRDV?=
 =?us-ascii?Q?wYR8Y6TShJ/1gH8GUVAom7VsGPb3LFY4SAHdeilHA3Fm41ASYkgfetXBR0lO?=
 =?us-ascii?Q?vdD9tHvT4yYJpXUAGgn5W1PkAG/uqjCbsuHPBVuH3g2Fn6aLlNGHnBZPW9Ck?=
 =?us-ascii?Q?MS51MLdOkMWbC09cGg0cypIKX/v5VQRyrgTgvwRQYnTm0NMizUKA0lgMDGUN?=
 =?us-ascii?Q?GpQ+cY23Eva1Lq3MRo3+t7K8VV9tFppQPECUczXXMyxCXN3oV+elJuGWrfN7?=
 =?us-ascii?Q?iElm+plXvvPICVLLC5TMP3qmwqJLolPGziBV8hlDZo0zKJiAsLk+rZE8g0Xq?=
 =?us-ascii?Q?5hkyKa21Oa6hjiUn8glvXNJdNf5ZtCD19aEzavOg+jJzqisWZFCVPoGPyc6N?=
 =?us-ascii?Q?kuWzUK4elkcxCqXChpwHgf3SXS2JiRmHedXnDiXAbN+/K0OBofJrjImj14Iv?=
 =?us-ascii?Q?N9tYT2NPQ+uMr/NtlCyQsPPMSGodB4D/SIM33IrhQtkPkn1FKE/VC+YZ4N6l?=
 =?us-ascii?Q?XfWR8ihtg2+eWxhdJw1WuRfWJ1K36XhqOiexVVGmAfM9VLeqAldJPHWQBQj6?=
 =?us-ascii?Q?M1K/lYCVWJcfSCe90cAguMCbiuLcNbhfPSER/SGwHH040OLSbMIv/jpLKx7E?=
 =?us-ascii?Q?+vFZt/AwJZCWrDWcPYh+g2jXYr5yYQgHGf+EhV+ldcR/h/qUwhdLVaAsM0oK?=
 =?us-ascii?Q?+6MqraYINooaxw6gif2B1y0mJ4PWurXd9OLZcTaCK+y07LtXwxiKcPtDwHg7?=
 =?us-ascii?Q?AO0buQ6cxbvHNg3NEusBF97PyXLhogoCjYuqU+/U/2gmNjcyatcG6cxnIZtj?=
 =?us-ascii?Q?tqPWgSi9UtzNA4wgCG64pWfazmB3RyUFqM8zDXzEBa99+2jwyeqwGJV84BRN?=
 =?us-ascii?Q?syfTkA/xshJPi/cBqn7gCUei4oYd80E6meSSPTunq2x6KVPSxPKebHM0agbJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 5Npyq9z7a1zIKZgllgjGY0KssWZTJULn7oM=
X-Exchange-RoutingPolicyChecked:
	mYWA0n7qTP/rkXK3uf+t7FzL0zPXL39kucxCyLSygI2imlVAHLWxAOhsUJLhtcjG74V5JXxLK2s40hePZ1XWH6+46mE7RWq1k8TfWmCAqYBCpMWCLozPb5E72aSjqG2K1YF3aPQ/n0793NSXwK9ETv/CUWqYHUONNZdggxW+hn8mf/IacQ2dv71huJfGM+Uac5iSQqC5VDyx/+Fx0LKXwUMq4RTIa1p7jjS6BOAFl59XpswGuQQmY9pmOoxzalwqxz3/EM57KpwHNOGHlmhYOimyit1Ml8/ZzM8navUPZrzRnqU12TmiQU8JLphEhI9/0RQBLmGOI4aUsqmtwnkgEQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de22c2c2-7da0-4020-7fb5-08def08617f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:06:25.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNyaYHTKra6i00wvxKToSIfzttcoEq94qIsbJT2aiE1cXwUNrywBNMWeGfkd/5qM9usmisVShQF3iNqgVm3tSwojPXzjNI03iTktnLPdspY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-Proofpoint-GUID: Iwrm0J-NATpN5XU9PKA4N-pGrQiHHMSJ
X-Proofpoint-ORIG-GUID: Iwrm0J-NATpN5XU9PKA4N-pGrQiHHMSJ
X-Authority-Analysis: v=2.4 cv=afFRWxot c=1 sm=1 tr=0 ts=6a6f24b3 cx=c_pps
 a=HGE+/hAEzspoXCOliImplg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=_DDItCzNFMEctcKwLBMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX8OrOcBiSgB2S
 PnJiUwTu1k/XqYfpQ5Bx9/32ilMUoZFw0W8VfttP4XOV3eXvbl5KdmPZJujfeI8ZnKIH15SN8G+
 w/Zz7nIb8SSBYvmvj0yQ3DpyNmaH0NtuQi0oU1AoS73Q75sJMNG/jDTdBDXzBnvywzUEXnKnT8y
 N3B8ZbhJGL0IP/jJWjTytFQcZEQTRb3acDe/w2n522WEOAQSO7P86SF0DW1a3ZVYkeZW6SD8Zyl
 ouPViQtL17WGfS3F9DB0wA8gOI2o/rw1rTtygXGeCpFUr5VzbUBL6i1DzCXplTxjy9BcagDKxxu
 XyIi7ZKFTlIiaRFgQSoB0KIxKWT0lcJ7p1vRNH9rhWZnAOPplTOj48sX14Hnj904Dj7FT/q30OS
 8dmL2bK3TqnH6cytPnJh7+OQ2f7sn/IA8g2YcYIGr1lPzH3cbOjjVyfPlXuVzDMZq9vaH3rsBhS
 tOwyPrUSLtXwGtkHQPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfXy1c5zQRMy6bk
 6/psvPOZtEJLZsT/w3VslxPDAlovCqTM59mx5Na76TMyx5Uhr7+szN3FrYZ+b8AQens+3WF1Qvk
 l8A+KXqfehfjCRrQnzEQY8ZWQS3YwbS4zXh5e0JZ4lhA24/e8j/5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020095

For NLA_NUL_STRING attributes, nla_policy.len is the maximum length of
the string excluding the terminating NUL, as documented in
include/net/netlink.h. The genl_magic infrastructure encoded that as

	.len = maxlen - (nla_type == NLA_NUL_STRING)

but the hand-written policies that replaced it set .len to the full size
of the destination buffer. Every NUL-string attribute therefore accepts
a string that is one byte too long for the buffer it is copied into.

For such a string validate_nla() succeeds and nla_strscpy() truncates it
and returns -E2BIG. The return value is stored without being checked in
the corresponding unsigned length member, e.g.

	s->cpu_mask_len = nla_strscpy(s->cpu_mask, nla, DRBD_CPU_MASK_SIZE);

set_resource_options() copies the whole struct into resource->res_opts,
so a later dump of the resource options reaches res_opts_to_skb() with
cpu_mask_len set to (__u32)-E2BIG. The payload length handed to
nla_put() is computed there as

	min_t(int, DRBD_CPU_MASK_SIZE,
	      s->cpu_mask_len + (s->cpu_mask_len < DRBD_CPU_MASK_SIZE))

which evaluates to a negative int. __nla_reserve() then stores
nla_attr_size() of that negative value in the u16 nla_len, and
__nla_put() calls memcpy() with an underflowed size argument.

The five net_conf algorithm names, both disk_conf device paths, the
configuration context resource name and the resource cpu-mask are all
affected. The shared secret is the one most likely to be hit in
practice: SHARED_SECRET_MAX is 64, a secret of exactly 64 characters is
what "openssl rand -hex 32" produces, and nla_put_status_info() feeds
the unsanitized net_conf to net_conf_to_skb() for any caller holding
CAP_SYS_ADMIN. The sanitized path clears both the secret and its length,
so an unprivileged status dump is not affected.

Restore the bound the generated code used to emit. With the policy
corrected nla_strscpy() can no longer truncate, so the unchecked return
values become harmless again.

Reaching any of the affected attributes requires CAP_NET_ADMIN. Found by
inspection while looking at the cpu-mask length limit; no user report.

Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/block/drbd/drbd_nl_gen.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl_gen.c b/drivers/block/drbd/drbd_nl_gen.c
index fb44b948cec8..5b668e78051b 100644
--- a/drivers/block/drbd/drbd_nl_gen.c
+++ b/drivers/block/drbd/drbd_nl_gen.c
@@ -51,8 +51,8 @@ const struct nla_policy drbd_disconnect_parms_nl_policy[DRBD_A_DISCONNECT_PARMS_
 };
 
 const struct nla_policy drbd_disk_conf_nl_policy[DRBD_A_DISK_CONF_DISABLE_WRITE_SAME + 1] = {
-	[DRBD_A_DISK_CONF_BACKING_DEV] = { .type = NLA_NUL_STRING, .len = 128, },
-	[DRBD_A_DISK_CONF_META_DEV] = { .type = NLA_NUL_STRING, .len = 128, },
+	[DRBD_A_DISK_CONF_BACKING_DEV] = { .type = NLA_NUL_STRING, .len = 128 - 1, },
+	[DRBD_A_DISK_CONF_META_DEV] = { .type = NLA_NUL_STRING, .len = 128 - 1, },
 	[DRBD_A_DISK_CONF_META_DEV_IDX] = { .type = NLA_U32, },
 	[DRBD_A_DISK_CONF_DISK_SIZE] = { .type = NLA_U64, },
 	[DRBD_A_DISK_CONF_MAX_BIO_BVECS] = { .type = NLA_U32, },
@@ -80,17 +80,17 @@ const struct nla_policy drbd_disk_conf_nl_policy[DRBD_A_DISK_CONF_DISABLE_WRITE_
 
 const struct nla_policy drbd_drbd_cfg_context_nl_policy[DRBD_A_DRBD_CFG_CONTEXT_CTX_PEER_ADDR + 1] = {
 	[DRBD_A_DRBD_CFG_CONTEXT_CTX_VOLUME] = { .type = NLA_U32, },
-	[DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME] = { .type = NLA_NUL_STRING, .len = 128, },
+	[DRBD_A_DRBD_CFG_CONTEXT_CTX_RESOURCE_NAME] = { .type = NLA_NUL_STRING, .len = 128 - 1, },
 	[DRBD_A_DRBD_CFG_CONTEXT_CTX_MY_ADDR] = NLA_POLICY_MAX_LEN(128),
 	[DRBD_A_DRBD_CFG_CONTEXT_CTX_PEER_ADDR] = NLA_POLICY_MAX_LEN(128),
 };
 
 const struct nla_policy drbd_net_conf_nl_policy[DRBD_A_NET_CONF_SOCK_CHECK_TIMEO + 1] = {
-	[DRBD_A_NET_CONF_SHARED_SECRET] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX, },
-	[DRBD_A_NET_CONF_CRAM_HMAC_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX, },
-	[DRBD_A_NET_CONF_INTEGRITY_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX, },
-	[DRBD_A_NET_CONF_VERIFY_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX, },
-	[DRBD_A_NET_CONF_CSUMS_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX, },
+	[DRBD_A_NET_CONF_SHARED_SECRET] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX - 1, },
+	[DRBD_A_NET_CONF_CRAM_HMAC_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX - 1, },
+	[DRBD_A_NET_CONF_INTEGRITY_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX - 1, },
+	[DRBD_A_NET_CONF_VERIFY_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX - 1, },
+	[DRBD_A_NET_CONF_CSUMS_ALG] = { .type = NLA_NUL_STRING, .len = SHARED_SECRET_MAX - 1, },
 	[DRBD_A_NET_CONF_WIRE_PROTOCOL] = { .type = NLA_U32, },
 	[DRBD_A_NET_CONF_CONNECT_INT] = { .type = NLA_U32, },
 	[DRBD_A_NET_CONF_TIMEOUT] = { .type = NLA_U32, },
@@ -143,7 +143,7 @@ const struct nla_policy drbd_peer_device_statistics_nl_policy[DRBD_A_PEER_DEVICE
 };
 
 const struct nla_policy drbd_res_opts_nl_policy[DRBD_A_RES_OPTS_ON_NO_DATA + 1] = {
-	[DRBD_A_RES_OPTS_CPU_MASK] = { .type = NLA_NUL_STRING, .len = DRBD_CPU_MASK_SIZE, },
+	[DRBD_A_RES_OPTS_CPU_MASK] = { .type = NLA_NUL_STRING, .len = DRBD_CPU_MASK_SIZE - 1, },
 	[DRBD_A_RES_OPTS_ON_NO_DATA] = { .type = NLA_U32, },
 };
 
-- 
2.55.0

