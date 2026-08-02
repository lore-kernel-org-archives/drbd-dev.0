Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1023EAB7;
	Sun,  2 Aug 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785668807; cv=fail; b=Q1lmdU2ybm/6c9JNkTrNPfp4Wz7yN1o/Pduu+Yhv8+Nq7glgQ+nj/FreZZvwG5yMYdh579jiXsIhXLRZf5TwHgHTRE2jApzZbDoYk2UG3nJT2FD5wc0pEq7MsMel/qBLtBKEvs0PuJSStZAMDUkRUJe+6ABXUi6wFuvkf60N9Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785668807; c=relaxed/simple;
	bh=NOqTBNcqULMAjA3zzHj+6ocIQeTisXM62xPRRgI6QUs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZnstWqHtOnvkZmlgE2rW/vj7/MynXHGz/YbDamEQA5YKV6TwGOTLIds0WcH/XN9NjxWUPP+j/PvNg1+PDK5Octnsy/CexEa3fYjgQpiAGVJ93i3tsd3w1+BOM2A2rtVdyy+7GVhHEPQMq4J+KKqzE7vWyHlZ9CvawQJwHglWNiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IwnSWj79; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IwnSWj79"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Aqseg3040007;
	Sun, 2 Aug 2026 11:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=IanyDKZiD
	rx71lChiswYn3ToKBZ7VxPIcSSGY84+ino=; b=IwnSWj79BmeMKFVaTO0OUvaRq
	8t6s2aMl7OeYrB7ydvVYpGXt0d6f6B3AaPOBgZBXMvX3JiOk/YsEoVK9vE5CZSaS
	x8gujDPd95eiNV24I5i49KQqp9ZXVCaG218yoSmXeJFtKsxTr6PsvEQyGx979RiO
	xUmCjCZRCqhKbAGHeo31klDrQLSLqgwg1UGcSPfFpWZzaK7E7EapxfBuYbA7f8/w
	VVmTJqgNVCqsBE4t5gS0h3eTDDrF/ofrRlUn+gPQpA14PVHhL/ahDJx2kfiW4u4y
	KNn17nk4Bih0vnpP3VjTL0+oEg6F4C0tpI1VXqSj6Ss14lRWyVBOlaRKU5Zsw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fs60x18m1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 11:06:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMWRU5eYXehW7p/XHtpwpDtOOm6WrZ+NTcxZsUf9Sjm0wQhBJSS3fUjJBIDZSPKLQ8QtCqOFHgeboiiJreiE9B/s40oalaK5GWgwz91K7rCKZRX2RIXMLu3a9hODbRVheUbw+B8E+U1f1LPC/VJpuNPpr3/UR52e+oli7IVxKH4xjC6yqZwHuu4AKzxvF5xoPFLhk9Td65vQb/1TbfkjeyBKE1mMCtus58kWxOxf/9n0CUC0vwBaJj6cNNfeJiCaI45TPHylYydLEp59fFI+hT8fpAz3Rpg5vKr6SI8EhZa3B5OpWjgWLU8xy0cbwoxdcdRznHsDxkaLydAid5BYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IanyDKZiDrx71lChiswYn3ToKBZ7VxPIcSSGY84+ino=;
 b=JrQZ4e9o6mSkOtCepdvDwrwURfXt4K+vnyioHAmMwupENVHy9/Jo7HBvgjZ4JjcDVUEMQnyk9EoaH4hZUVYu0cKavNGgndcGfmaSbE1hf/KN8ubyDRucO8Nl7Ac7FlDsK5odXpSyfZL9E9H7F/6aHDrusxCHBjTAaXbmRbll4SfB863K7LqsU1BrQozjzfS64daRe3hqpGJoV8WElgCEl9uxIDm8Au/amNuD8H4xgoY9XapvlgG2ovRCBc2I6xgRHno6RwDPXhkhsucjs2YhFjwDhvkMcFwRmPbNpw8R71JkYsSNtTumVP5sVxB4WOD98myVpDph0B1Hc7TDPaT8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:06:16 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:06:16 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>,
        Ionut Nechita <ionut.nechita@windriver.com>, drbd-dev@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drbd: fix netlink string policy lengths, raise cpu-mask limit
Date: Sun,  2 Aug 2026 14:05:50 +0300
Message-ID: <20260802110552.50757-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-Office365-Filtering-Correlation-Id: 0d8a0c5b-7095-4e55-5593-08def0861266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|23010399003|1800799024|366016|6133799003|18002099003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	/CDJe899B/DYsVkmlCqYCuKf5bOuZLLDfpWYVI1rSu2BmlXJtUYOLFGIuDENHSSwJWXsXhC1aTwMzM9bwb7odGZemh7zbU1JTRvaN+LjRQkhOTo09vVPLaylo2UAnoILt+MSTvsw4J8kdgvpcT7LaQihda3a88YhxXZazmVoUAdA/QGk99nnEsEiWbtemeTPvhvhVFPaAtdhZa9OjeTIKtRo2pYNyfDE7f9iP/JvUOiEY2jZhKl81ySqAJwIBePd8/0EaXdQV1KJTeTTrMfrIuKjQEVw2pLnxSWeVMOh2jWDq8XaRvm5adFh9YsHhJHqQl9fOAt+iNOroBKdU3TvJXNP+MYVa9chtG862zDf0JVsxl7EeJoDx81RZcQMPMivCdGkd7Z9JTTqhjGp1PU1T1wSz/LiCdFHQHeKe0FI7b2lkwXzXa69MyhmNJxnAh5KuLqh30MA7MnvOxEJwVISLU2mo+VcIuAG1aZDphq5/2Cx+5oXSfb7LJ51qPemUmR20OTNcFuhuxyBFf52HBxZ5CS7ikyAYyK++h5GV9YZKwEna0WCU9Tz3gtO4JIo4AGFqjhpdbp4Qm1pA8aqHAE0Z6amrw8okcYaNq88Bxeeiob6Nxl2ywpV8b5FkA19eG32SThB7SaXAavykUPUolsga+hJ2kC4r4PwTzpzzOOPl1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzNIYB8g46nzCHi/Fz2l3JQe53lVYerSMhYkicBmJjbtfaE1DooPth+fQnnV?=
 =?us-ascii?Q?+eFfokOwVGcltnktTqx2DUQ6xyGFihMkn9Uw3BNfil76j7vkHHEah512Q/t3?=
 =?us-ascii?Q?GabY/RpujISUPgzc4kx7454ADpXGtKoW738hjHCcLMs9Cr20sfeUwT/m/D66?=
 =?us-ascii?Q?08Uct55KQ/+jn0fjnK0PrvwK1oFc3xOM5QOM1hpCubJtpjY6CWp9/1/0xZOQ?=
 =?us-ascii?Q?QWAzG0EtPVVcpEEN0ElzhVi8BQqm0WVSCZMF2sfBa5hMr4yFB2q5baWo0enp?=
 =?us-ascii?Q?t+lgLoVLI1IRqZru4Xb9dya5KiyOf1fry5bwOnk/NIcUQGWeHASp6BIUH8xj?=
 =?us-ascii?Q?NqKx6XY4+H23gq2OibVE4U5NyC7PltiqhFJ09jxLO1Ug8SOR1oT1LodiO8j2?=
 =?us-ascii?Q?e0oKqTHy+Ga6AvRh4aIjkmqe79NRpZZvIDedBeOG3HNMs8YL/aZHbR3fdAGS?=
 =?us-ascii?Q?QVFKSqYd5pJlWGy2B26vcNGhW9hqYchlMPCmTHYfjvP9WJHXW1KNqkbp847r?=
 =?us-ascii?Q?Q65AJJfHvfT8yoWDwaK6IR5Ik5RjZylyOIWVQDEKnFAuUrdWyWhC89VSsHyL?=
 =?us-ascii?Q?t6ZHQ94X+k2sV0egUvpgOW8MJB8z8psym1TEEi1auQYzGbYxnuLQ2DlYa6SG?=
 =?us-ascii?Q?EiQbRx4V00CV+M5ICpejksTOe1mxctN1EFmCRAT4G55PRpbPoxkSoFcnSwOm?=
 =?us-ascii?Q?/01MGnejWuj39yc7MEuCXb4aXqK3KntWfGU744KB7za4rpmtDbJ4iIAhWfeR?=
 =?us-ascii?Q?g4GmjQItp1lL+DSsgak1kjCHOjZcfCAJGSQk7fufU4yIiEcZNMNdsSkkdyt8?=
 =?us-ascii?Q?6TuwJvnj6J/nPQ9VIzwiSEPwdmaKTgUEqjcyKVYpPzIIDJ931YvbqVMkNio8?=
 =?us-ascii?Q?7tzzypbUV1EJcrXtaDMQGkHT/9UZdgz9jmQ3+byjdUAiQjzYSPLmh3TPp2Wh?=
 =?us-ascii?Q?9XwcO9qibEDeAJ+9CmglDG+WeJuZki9h2gqxALAvrp/UzgJ1eHsKwwXEbkW1?=
 =?us-ascii?Q?zvC298ZotpWMrq+pRtfSMBQaVz/XQPAvCFMSxwLjx/H5mt9u0/7Vzu+I7Wzl?=
 =?us-ascii?Q?M7bQx+wCzD7B9UMuyS0Rb7hn2Oj/KIML4d7brZwLP2HFSKRcis4UIDHH9paY?=
 =?us-ascii?Q?AsL16cm2bVnOd+orFkKa+H/rV/3mvDZEgXTqb6H5MIzAIytorheUMfx9e72d?=
 =?us-ascii?Q?pLW1XBDAMfEFT6m4Vjj1qwSWO8uCTU4Z7+s5jnyjNct/WsGEtt03mp/JbSnm?=
 =?us-ascii?Q?sMr/5qQ4aIA4660dX0g6AwqS9Z2OMpzJVcx3YChAjHEc6AfvmOiGCj9JWpLk?=
 =?us-ascii?Q?iyGNO2ZspxK9ggfYDBWLSSLx4l4OhJbyMF6w49gOgzMxVNQeewct7bvv0LiZ?=
 =?us-ascii?Q?xHPKq+QLUTT2k/WwPSpt+ldROCtumx+mQjG2w8UZcomMiWpBzlcHHub8IMSm?=
 =?us-ascii?Q?KakHjB1ipVRgmouuabOUCLGBgiVyBVIuePpfd56hU0MGcjITQPeuno/czQbz?=
 =?us-ascii?Q?TytkIRr+LobNqRZzDeAl4XZ8hlh9k0QktH/kN+yARPEfTgPEU196F+vhQZrs?=
 =?us-ascii?Q?bf+tDYawTgTUuTetvtOuUaZGS/H+pEgki1xw3ZHUK0EGrajeHs+XSDbD2MMl?=
 =?us-ascii?Q?kOB0KbhOI4FnZ/6C7ftcfNOoV6Qs3voAnVkyp3mgQgJXZ+JsjMzyF7ToUJYB?=
 =?us-ascii?Q?Z9t7FISL0sHgKalbnP0diO/4muQR31XlYa+29CfPKKXHsZr2Cf5T8clh5CVI?=
 =?us-ascii?Q?RFBzkJidaZSGH0yB5kuj5E2IhfXonFYeDNnDPqNhAc7TPOBoEDuv/xYFzVeo?=
X-MS-Exchange-AntiSpam-MessageData-1: pb9xzKpOM3p/hcRQpZAKa41oaTtoT/gvo4Y=
X-Exchange-RoutingPolicyChecked:
	d6YSh4BGbL+Y/U6Gy5fgwNan5/nlZJtV5Iy8ly0BS5fgCftnN176whZI4oGpWOe0eQQzpRMgVDadvEvXYpsTvuzpc1E5gMWbtTQfM75LImce77/w0HxZHAbPZFf8/M2TxE70LWPXOM2VHLlJT5m4F6WcgjJXJkdADmwL4eSoacHtdmYGRTQ3CUOkCScqmX1xuMdG0WbvAt2DERKNkzHO0NzeDKBHtSsavnJS/6Nbnsw5RJUWvXRUdmhBbf3+DYcFBeTHa7FSGQhJW8Vgk8Erw8mrsN6O/iPaUzm6qoGxLo8SkoaTGaZUhd1zNADcJQMIMezsNvZTfRoCHHSxM1TDaA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8a0c5b-7095-4e55-5593-08def0861266
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:06:16.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4X1DN4JWivWx+hpHqv8isI6N5wu9j25eGTx8dTfurneGVW49E3L3mvhW2ShJLXveVCxa4S5z8o2UrjberNArkzfCBTydY/YOErJshZA1w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-Proofpoint-ORIG-GUID: nXHTcQgzTyCjfWiEz64BwQz05sHD19Ak
X-Authority-Analysis: v=2.4 cv=eL8jSnp1 c=1 sm=1 tr=0 ts=6a6f24ac cx=c_pps
 a=s4741YMcG+xsu4HPw1GdWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=TJmfaNxTaZ_9RodHR9IA:9
X-Proofpoint-GUID: nXHTcQgzTyCjfWiEz64BwQz05sHD19Ak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX+Fg6QIb4Q3CJ
 rXQlzJ75k9z66mFrTU0b0neFRfE0tGTDdqQyKlH2hcFH3HCQeZ3GpmiABVZGKVrL8/1o91WkZOs
 Dc/o/KvzyBTygY85/13ic72HlkGau8QSSdBNpXVJ8wN7AYUViAqcAFbSMzBrqwAh81MIN2se/nn
 at++E3yfwu2XmX9imoa9sG8W2x5CIMnjwmPFMBD3ro3rtmJCCbwfw0Vd7qPkuY3pazH9a0s2A1p
 RAWiaRAFr3Cbrba5Qq5oaLvo0mQ5iYgehdjXFHi396sV7BNLPoi2IUWV4SQD1eLm02/4zhEQ3a2
 N3NxawwFngdCbU0WHaATPagiwKUtu/x04gZpDOBpYoudY/bO720SA7T+GHhSC849flQVxrrbDj5
 PEQ63f+is0QEEdBstT5Do74ZDDBNZadM0M1vhwZfYZhJZm2+WYqaeIQT2so4Oh4/u421Tve5A34
 I9XlJ3C5TVldfDoUExw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX4dhX4jcba1FP
 d8jO18em/jFZRTKIsE8cFBr3isbkBzMVyR/0f7cdG1RBr3/z0KOrUwZwRFpT/KqdReUDummED1s
 r4HGjCRqK3IEiMFLqVFYj7BKhUdWS6nd3JBeDTCs6gIdz2QplcNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020095

Patch 1 fixes a regression from the conversion of the DRBD netlink code
away from genl_magic. All NLA_NUL_STRING policies now use the size of
the destination buffer as nla_policy.len, but for NUL strings that field
is the maximum string length excluding the terminating NUL. Every
affected attribute accepts one byte more than fits; nla_strscpy() then
truncates and returns -E2BIG into an unsigned length member, and that
value comes back out as a negative payload length passed to nla_put().
The details are in the patch.

The most realistic way to reach it is a shared secret of exactly
SHARED_SECRET_MAX characters, which is what "openssl rand -hex 32"
produces. Setting one is accepted, and the corruption then happens on
the next privileged status dump rather than at configuration time, so
cause and effect are not obviously related.

Patch 2 raises DRBD_CPU_MASK_SIZE from 32 to 256 so that a cpu-mask
covering more than 112 CPUs can be expressed at all. Userspace already
assumes the larger value.

The order matters: patch 2 on its own would keep the off-by-one and
merely move it from 32 to 256 characters.

For patch 1 I kept the change minimal and restored exactly the bound the
generated code used to emit. Tying each policy to its destination buffer
instead, e.g.

	.len = sizeof_field(struct res_opts, cpu_mask) - 1,

would make the invariant harder to break again, but that is more churn
than a fix during the -rc cycle should carry. I am happy to send it as a
follow-up if you would rather have it that way.

The commit patch 1 fixes first appeared in v7.2-rc1, so there is nothing
to back port to stable.

I found the problem by inspection while looking at the cpu-mask length
limit. There is no user report behind it, and I have not reproduced it
on a live system - I have no DRBD setup here. What I did verify:

  - the boundaries claimed for bitmap_parse(), by extracting the parser
    from lib/bitmap-str.c into a userspace harness: 31 characters
    describe at most 112 CPUs, 255 characters describe 908;
  - that the driver builds on next-20260731, x86_64 defconfig with
    CONFIG_BLK_DEV_DRBD=m, after each patch individually.

One note on patch 2: drbd-utils has carried DRBD_CPU_MASK_SIZE at 256 in
its own copy of these headers since 2023, so this only aligns the kernel
with what userspace already sends. Longer term the ambiguity between the
hex and the list format means a bitmap_parselist() based cpu-mask would
have to be a separate attribute; that is out of scope here.

Based on next-20260731.

Ionut Nechita (2):
  drbd: fix off-by-one in netlink NUL-string policy lengths
  drbd: increase maximum CPU mask size

 drivers/block/drbd/drbd_nl_gen.c | 18 +++++++++---------
 include/uapi/linux/drbd.h        |  7 ++++++-
 2 files changed, 15 insertions(+), 10 deletions(-)

--
2.55.0

