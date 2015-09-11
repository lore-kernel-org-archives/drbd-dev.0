Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EF16C10518BD
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DCCA52BE86B
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Th542TOhpel0 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BDE352BE872
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JfM7AZszyxLt for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 9B4C42BE86B
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:44:33 +0200 (CEST)
Date: Fri, 11 Sep 2015 14:44:33 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150911124433.GM3436@soda.linbit>
References: <55F1BECF.1000409@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F1BECF.1000409@sandisk.com>
Subject: Re: [Drbd-dev] [PATCH] drbd-km.spec: Port to openSuSE
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

On Thu, Sep 10, 2015 at 10:33:03AM -0700, Bart Van Assche wrote:
> Currently building an RPM with the drbd-km.spec fails on openSuSE
> because of an incorrect build dependency (kernel-syms instead of
> kernel-default-devel). Fix the algorithm in the spec file for
> determining the kernel development RPM name. Note: if the kernel
> development headers have not been installed as an RPM the
> %{kernel_devel_rpm} variable will be empty.
> 
> This patch has been tested on openSuSE 13.2, CentOS 7.1 and SLES11 SP3.

You are not supposed to build a "drbd-km" from "drbd-km.spec",
you are supposed to build a kmod-drbd (resp. drbd-kmp) from "drbd-kernel.spec",
using the kernel module build "magic" of the respective ditribution.
(not "make km-rpm", but "make kmp-rpm")

But thanks ;-)

	Lars

