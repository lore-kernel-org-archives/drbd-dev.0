Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3D2DD10556A0
	for <drbd-dev@lists.linbit.com>; Fri, 19 Feb 2016 15:31:41 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 19 Feb 2016 15:30:41 +0100
Message-ID: <5134316.5M0vLC0dAI@fat-tyre>
In-Reply-To: <CALLFrTR2QacF=XRzYhDhzLpTXENNR_q=qMHjQQRRVayTc-k7Nw@mail.gmail.com>
References: <CALLFrTR2QacF=XRzYhDhzLpTXENNR_q=qMHjQQRRVayTc-k7Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Windows DRBD <wdrbd@mantech.co.kr>,
	=?utf-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Subject: Re: [Drbd-dev] "data-integrity-alg" can't be worked in 9.0.x
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

Hi,

thanks for the report. Please find the fix here:

http://git.drbd.org/drbd-9.0.git/commitdiff/3d38916489fac62b036d8e79d3fcd81d318ca4cb?hp=0d8c43a244b3f907024e958d9ce65b3859a3f698

best regards,
 Phil
