Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F03911C7;
	Sun,  2 Aug 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785668812; cv=fail; b=KJi3mvWRzZBJDb/IhkFtQci2EA7fHENproIryzf9NAyWNm4s+gM+cmb4eCmpYoFe0BDzAqkegf30gQ9wlVujVuHJ3TuD5KwurEYK8OVtF+sesripc5Ol0YQqaql4pp50VRPmHd4jiFLeica5GfoqP4tJkAo0IJxsI42uRpZ7cqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785668812; c=relaxed/simple;
	bh=QnRdRBa8uilb4asbjYzOKY6suMWOH7mwc4oa/qKY3C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlHRQot3d1bHslffJQjc47mOzwt21IA5ivsQmOv56olYk7/Uzna4DLCRppB5J+zB6RpOGRz+wfwtUbSqjmJqaHs8i3Q4SsSUCVXzlRJkrcR3zudseWyQE/xn+zLpXBBQI2foa3llHCVNpMSzxoGCcQsl9/RiCu5NaiqXIUrGHYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=aokskjpR; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="aokskjpR"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672At2YB2652631;
	Sun, 2 Aug 2026 11:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ogTxLvzZqiWadPE6V05pp8vIZQes2hszgJ8GhUV8pgo=; b=
	aokskjpRAYxh+SvUcXumHd8/lAAaIainvvzzSsZVc/yTuBMcUjKcldMay1tik92d
	Krwm1QeEgCBRYF98/f/FYU4gW58Zq/iCHHUWS//lDEI/vAW7W/Lk/+u+v33cygcz
	KZN+bowy45BdoQmC/cpgD24M69+Nt+hB7sThQryMfNbjDA6ZITMWFNus/wPmddd7
	9jOrpJqXCBCKqaupB+A4uPeETjuiHjO/SukxKGQHbi2hKXjaGic/LbqFwh8iHFOG
	qPiU/HAct7tW7H7gS0wxkaIomc5Of7Dh5/rZe1Toef2IXnIub1QuJQx1p+ZG22ph
	E1SxibGrHHLcs1xvfiNOGg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fs7s895v1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 11:06:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqLl4g28T+rp4ddJzrtYYZ+f1J/mroTptVcjmixmGxRhm47vcaFot6L5ODJjdpPqCz2S2xgsPpW7Aoey0SVqpVf45B2TGv6fzWm5YBRAoiXx4AX3OTiLbZJd4LKJnkuV8DwTRQdwACViQpvcrVA09dI2nkXaSo10ZPbSkLeZ2ArpuXIQP8cAYHqpQJmTeAy4phh/rDj8H39U6ZL1IVhU7Dv06dTHrntTTtRtuUiRch6/5LxM+JvZj120b7QnzdX4DFRAS0DNNBRWcFl1BnlGuvaBn+ZI/M8I9GzAmk6E3G1eGBL8krLsY6v6qJtrFs8rhhMJTmFy+00aKsdXINntBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogTxLvzZqiWadPE6V05pp8vIZQes2hszgJ8GhUV8pgo=;
 b=uh52NaSz2l3CKN5CJke4gVjz3RUdBTKEfeBZkuiZnqamt3lhXIY3E9q/97U1mjn9zZYM52cPKkuITSjR6TfFGhk8yiPHbimQB/Hdu+Y1sBOjn/jj5dNriIV8pSKNs1SLWL+B2cB9R7sAa8jk1XgGT077D8eN7NajZCj4rugcEBkavf+b3pczM9PpXmMenjlw8eCRjzKt92b3hf0qtKpinotBs5u9iOWxQ4g/yJhf33aNT0LxJSiwpzWBPzbyllUPBRPqsDAu76kivRIxcEc7HDle8N35jJh8SbLAOniD1nbKVD3+rVnNuKHB4zVn1kIgOhoGMn2YVY/5HEEDqvvaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:06:33 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:06:32 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>,
        Ionut Nechita <ionut.nechita@windriver.com>, drbd-dev@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drbd: increase maximum CPU mask size
Date: Sun,  2 Aug 2026 14:05:52 +0300
Message-ID: <20260802110552.50757-3-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47f8d7b6-ba41-42e9-ae2c-08def0861c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	10V1jwaIwHhA/3qLOy6mdxZngNI7PxPOPqGY2gbDrvElvNaTAV3pA7SsIsr7GWBD5JQ/rA1c2fIMxm7meeyvGX+v/NmoAQZGw3fEIhj1Zq3FG6cppZ0rHz9MEbdq4GQlbMAElwONVrHStjVi4FIwvsri6vOFBOpCXojDjdpzcRXXxic0hcvNXd4KOZxF67RnABhz6c9soCg6TybvxoL+0XX3pFpXw53eSgmIP4iGmABCr6H3RBCGRCAv172uVzEyhCeXy6cdZx9eHamwwOnYfINkpD0Q/MgSahWoMLTZXXqE/Igip7+gSjfV+ZQu74bJaLuNDFdlEDp6uCCyimhXtCO+SneIrJozwQVUTkEEh+rTDH29o4lgxnZ7tqpLu4gxvfEV3A35KjSoMS7tLfsiyWXgSElaJ6T4W/mH+jqKVwyXMN7VdteuwLih5ToNjuz/CxZR0Sm0+T51tu+WY7L4ERXen3Mj+D0NTvYQOTfXDMBprKOg3OVaj4NxcQFIfP2s0AFFxBT3KZSmmYa/ax1WCUebI/VZ5H3ouGZdL3OQyHYE2Ko5bNV/P9iZ+H7jKCvDIQK3K4GXu2r3lPWFdFZNWyd6DbbQvIUBYxEGDsmxuZXx8B6h044nzZrUdwQ6xnfzs3mdHuhEKSJGsvoomIu7y327lQ7YwUelUtCSMib8GM0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6FNAzIr3OKCIQcA3RNdlni8utMRqQP8K0/bF/autTwhxYLNrWQc/y+UdVcAl?=
 =?us-ascii?Q?SgDWu2pNxySkheBgxChDvsGJX0296aMkz9tD2ZY+gFTYdpyNkTw8/kDr8as5?=
 =?us-ascii?Q?3gSkTNNXx9k9H5ZsNx//iPJsT96pY5jsxjIvkg0iYICmSg4ZqJg86ZIIvdmN?=
 =?us-ascii?Q?pBN5fUsSHfLxlWIslRJQ6VInDJzKvOXatC2rw94X90Ci1tLp4L/nSbmmxOgd?=
 =?us-ascii?Q?JPbl8K/V+VG37dDnS6b/f9Aj6H52KZZiJYwTnI17VEBkrbgPvCifn1pEmJpQ?=
 =?us-ascii?Q?nQUFCVGfcnhGDj52kl2r3QUSB5Yc4C6fhKGtuHBrQMdbnVYc2h1IHzd+cIMy?=
 =?us-ascii?Q?JuIcE3AKxCpEuU75flMsh/kdyTFhetkTr4AqqpqtwCqJUifdFB642ICGnKTB?=
 =?us-ascii?Q?kqdBVXNfLYLxZ2cXkEwMj1uoJQo9nYxE98OmlbdtEF0/zOlu+LufICu9FeTI?=
 =?us-ascii?Q?Bqw0gZ/nRMpO4ooZ4cazHjHhvfD4DRBpkU8SIkuTysfybaE71MLIungdCpQK?=
 =?us-ascii?Q?2uCJU1rFbWjN/VSxddsgLR+6LvMX3JEfOzgRzNAFnbFWpQEnFpxtZfLqgtQU?=
 =?us-ascii?Q?jAWpTqgQzyDeokBiaS6z+bWmqHHHHFmKTIK4mLsGaB2yN5Mpih6OMlIJPZgP?=
 =?us-ascii?Q?u8lrf9Tf2JU66JiiRfIui8xeNuuZEKSnDo7iZdCQKaQ8hW6mbKpYwHXvFk94?=
 =?us-ascii?Q?LL/jezpzhAKPCfNG9Q5MCTJ1va9Jw2KXN22ympKeLoC2Y+Rw8AsMP22uqVnX?=
 =?us-ascii?Q?Viaq526OZS4caMkDbnVoUll/Mf8yFkGcVHSqLLMu2bh8i//iaQAhP5nQR0CV?=
 =?us-ascii?Q?167RYXcBsHz96LADKEdQQvn6GAe960Ofa1uTVuW0WnrGugGigyy8iZfB7QOm?=
 =?us-ascii?Q?sWS/8E9HwglxOMownl+53xVSwE0WifoaUR1giG1lFXrPwUO6I82fDu3wTGQD?=
 =?us-ascii?Q?Ym6WVMIo7QGNRWtrZkUjxaf1MgoGoBg/pSunEj2ilYW4AodUBFJPLre0FwpW?=
 =?us-ascii?Q?0xBOJWzFd9u3DCp/FOnhgRr/Saiqgh2DTTY6ltmpYurQdGvm94wD54pvmFuj?=
 =?us-ascii?Q?mtEOZx0kOVXL5Z0NkJbaF4nz9UwFWP+8spxRQMTZhC1MOyMS5Z/w1QRjG324?=
 =?us-ascii?Q?/Gaf75jcouxd0waCv/fcebAtsEelb7ym78i935veV7uqP6PMoXtPxJ+K/mDa?=
 =?us-ascii?Q?8EeNnNZKmh18hmIfx4hRIlXhnVPC6O/4F/YlXQ0WGvgT9vtf862OOipYOsbV?=
 =?us-ascii?Q?Cf72LB9Xb3SmAV7hhnTMxZH4Qs+FvmtbKbBfFyJlXIP8SqbFQhiQuXeB7/a2?=
 =?us-ascii?Q?1PcDUlf++x6JBgLdS4qyQ7qjIVHywwPQVKYuvS7qLBLZ3+A0gITgQQypT4XE?=
 =?us-ascii?Q?BLvU8m9xboZ2FoTO/yK9RViKJUN/As5J71orLMApHLJ7PnUC2HeOY/cPwL/x?=
 =?us-ascii?Q?1y6zNfswlz3SFx/xWF/w6uooGrEWP1zDof4jhS1OTZhph8TPubNvA+TDq0Dw?=
 =?us-ascii?Q?iKzLZLoufMqTWKu80uvZtcBADF63POX9JvxKlwbGLUDwjStWS+bvtUzc75WY?=
 =?us-ascii?Q?6QeXn4Obo3KkSACAPuX78LmOto3XP3k0evZ7HMgtF+X3vqQMG346drwyYlgJ?=
 =?us-ascii?Q?QqB0tC0HvOwa0hn3jrjE+lFpWfvmUYLk/nvOUGyHsh/xeSEu35YnZyjaReIM?=
 =?us-ascii?Q?OF4o59HXwjG7fE2/STtJSevSO/UvVjLfIZdaqyVpesoIMISKMRjeBI0FGwqo?=
 =?us-ascii?Q?OADcGYs8s910Ij9JoXzzGLKs6D7MEKcE3O73VgJCVJ7n8lV5nav3bPcOHvwz?=
X-MS-Exchange-AntiSpam-MessageData-1: sNwqYDigTAWTxsGZHVStgK9/JDksWoxP9CE=
X-Exchange-RoutingPolicyChecked:
	T8p+VSP7sa4EUEotwH/imiTqKoct6lwiZRAxgOoEO+iYJAWTBNVUfAR/WfafySkWsTnSoUkQJH+NHQZIrIAQrNTpsyZrNzyc/LMKWrkStIc4iPsh/7zAJI4s/srB/J4py92UULsCndulmyN+rW7IreryjUWGMHK739+lYSFNWC/xZWIF5LVoZ3O0jUKluGsRhk4l0HkvGzb8cAmu1JyIcxXvEpM1DNzoPfiaxAMUWYX89P07HYwk+Aw9UApO5HyS7Jr67CGitbpuNxrXad45Sj+i/OerFVqua+bvsNYO0niV/F852UY1EdZ+dFU9FI2XMdZJoonJhZHR7qQ5+pcycA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f8d7b6-ba41-42e9-ae2c-08def0861c6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:06:32.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mStqiNuzOEELXmoM+BphegPvz83srYMepLBQNyLT9nCorc9JiMMeY2kwet+mKa03nkMux9dPy60yAVL9xfTME2hTAY4fYB3v4OPTNyg7mBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX+DdUw0YGhEtu
 alVU4f6JoEBH+KTwL/jGuzTMSl4e2DmfIq/7Qh0k+JLS9I50py0VlB8BNy4bJdwFrhqd7bTOBw8
 uw3Gwr3dPBQ72gnOKKxVfg5qy1RCMAKKPH/SbFw4xkcZ83e0F3HL
X-Proofpoint-ORIG-GUID: SbUisLYYX8jvxiMqf1t9h4aTxIIMAUfe
X-Authority-Analysis: v=2.4 cv=Q77iJY2a c=1 sm=1 tr=0 ts=6a6f24bb cx=c_pps
 a=FAljFvH9XqR9mTH/oaGbyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=uND2q5vx9XEJjlcHgAIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX5aRFGx/VTxv8
 GfsSoSff+VPRvCZ/O9u9iARIbcWRMM7Y3+lhWurdD7P3tAB455m2ECcYcRVl95Ei0+Q8r/0DZNH
 OofUTcGAgeqjwa/i5q/iMSfW9IGL5de1xGsfaD/3T5bYrWnLxG7xHFMbeAjrjQQYOWzB28FmaQz
 lIa1XRhXJ1DWOUpZEppCTlnrh8z3DmfcaAaCokomyjr8HmXX/4kCPAbq2hwPCbQtSNVlQDxIzI+
 EYhe15LbZyadpLlAAMXkD5ZGgNAC33U0O+DoqfEH2KbB7uiGS1mZX3yh084CN+QCBMHecTzOxTx
 /0WtYGFcStb0dKnpibkMzhTp/PFLW+JwD1NkSZWyaINXvNPWd8ghQ8izmflATu2PnrVdFMxGZLj
 4iNfNWhE4q0dkXUqvgN47u4iHVvI6Lztrnx2mv2uHBPSMMC0oylYVyVHwWGrazhrVyzw9tN6EY9
 wfjQU2mPdw9lafLaKWg==
X-Proofpoint-GUID: SbUisLYYX8jvxiMqf1t9h4aTxIIMAUfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020095

The cpu-mask resource option is limited to DRBD_CPU_MASK_SIZE - 1, i.e.
31 characters. bitmap_parse() reads the string as comma separated chunks
of up to eight hex digits, each describing 32 bits, so 31 characters
describe at most 112 CPUs. A full mask cannot be expressed on anything
larger, which by now includes most two-socket machines.

Sparse masks can still reach higher CPU numbers by padding with zero
chunks - "8,0,0,0" selects CPU 99 - but that only helps when few bits
are set.

Userspace has already moved on. drbd-utils carries its own copy of these
headers, where DRBD_CPU_MASK_SIZE has been 256 since 2023 ("drbd:
increase maximum CPU mask size" by Joel Colledge, in LINBIT's
drbd-headers repository). A drbdsetup built against those headers is
rejected with -ERANGE by validate_nla() as soon as the mask does not fit
in the 31 characters this driver accepts.

Raise the limit to match userspace. 255 characters allow a full mask for
908 CPUs: a leading chunk of three hex digits followed by 28 chunks of
eight.

The cpu_mask member of struct res_opts grows accordingly. Two instances
live on the stack, in drbd_adm_resource_opts() and in
drbd_adm_new_resource(), which is uncritical at this size.

This only relaxes an upper bound, so an old drbdsetup keeps working
against a kernel with this change, and a new drbdsetup keeps working
against a kernel without it as long as the mask string still fits in the
old limit.

The new size will likely be too small again eventually. Describing the
mask with bitmap_parselist() would avoid that, but the list and hex
formats are ambiguous for the same input - "8" means CPU 3 in one and
CPU 8 in the other - so it would have to be a separate attribute rather
than a reinterpretation of this one.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/uapi/linux/drbd.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/drbd.h b/include/uapi/linux/drbd.h
index cf1ec3eb872f..1327ce1006ac 100644
--- a/include/uapi/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -368,7 +368,12 @@ enum write_ordering_e {
 #define DRBD_MD_INDEX_FLEX_EXT -2
 #define DRBD_MD_INDEX_FLEX_INT -3
 
-#define DRBD_CPU_MASK_SIZE 32
+/*
+ * Maximum size of the cpu-mask string, including the terminating NUL.
+ * The netlink policy accepts DRBD_CPU_MASK_SIZE - 1 characters, which is
+ * enough for a full mask covering 908 CPUs.
+ */
+#define DRBD_CPU_MASK_SIZE 256
 
 /**
  * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
-- 
2.55.0

