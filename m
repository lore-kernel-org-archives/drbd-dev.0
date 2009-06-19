Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A1DBD10735BD
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:08:04 +0200 (CEST)
Resent-Message-ID: <20090619160804.GI9526@soda.linbit>
Received: from master.grad.hr (master.grad.hr [161.53.50.3])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D2B77101380C
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:04:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by master.grad.hr (Postfix) with ESMTP id BC7F8494474
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:04:11 +0200 (CEST)
Received: from master.grad.hr ([127.0.0.1])
	by localhost (master.grad.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fpvwaXBCjtXk for <drbd-dev@lists.linbit.com>;
	Fri, 19 Jun 2009 18:04:11 +0200 (CEST)
Received: from [192.168.78.136] (iskon217-215.duo.CARNet.hr [161.53.215.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by master.grad.hr (Postfix) with ESMTPSA id 8DD01494470
	for <drbd-dev@lists.linbit.com>; Fri, 19 Jun 2009 18:04:11 +0200 (CEST)
Message-ID: <4A3BB6FA.20402@grad.hr>
Date: Fri, 19 Jun 2009 18:04:10 +0200
From: =?UTF-8?B?QW50ZSBLYXJhbWF0acSH?= <ivoks@grad.hr>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <4A3BA30F.70406@grad.hr> <20090619160106.GG9526@soda.linbit>
In-Reply-To: <20090619160106.GG9526@soda.linbit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] Compatibility with 2.6.30 and current git
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Lars Ellenberg wrote:

> there is now a module parameter cn_idx,
> which shows up in /sys/modules/drbd/parameters/cn_idx,
> so the userland finds it.
> you can set it to whatever you want.

Ah, sorry, I wasn't aware of that. Thanks for clarification.
