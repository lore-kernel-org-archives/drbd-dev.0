Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CFB751013804
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id BDA461B4361
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:01 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0sL1-4zNB0dV for <drbd-dev@lists.linbit.com>;
	Thu, 16 Aug 2012 20:17:01 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id A148E1B435E
	for <drbd-dev@lists.linbit.com>; Thu, 16 Aug 2012 20:17:01 +0200 (CEST)
Resent-Message-ID: <20120816181701.GB8189@soda.linbit>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C5CCE103B4AB
	for <drbd-dev@lists.linbit.com>; Sat, 11 Aug 2012 07:24:47 +0200 (CEST)
Received: by obbun3 with SMTP id un3so6105291obb.27
	for <drbd-dev@lists.linbit.com>; Fri, 10 Aug 2012 22:24:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120808235731.GA7262@moria.home.lan>
References: <1344290921-25154-1-git-send-email-koverstreet@google.com>
	<1344290921-25154-3-git-send-email-koverstreet@google.com>
	<20120808220612.GA6983@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120808235731.GA7262@moria.home.lan>
Date: Sat, 11 Aug 2012 15:24:45 +1000
Message-ID: <CAOzFzEhPW5-edb6mnL2gNbb4956u2MbWqQovv01010PyBCbc+g@mail.gmail.com>
From: Joseph Glanville <joseph.glanville@orionvm.com.au>
To: Kent Overstreet <koverstreet@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: axboe@kernel.dk, snitzer@redhat.com, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
	mpatocka@redhat.com, vgoyal@redhat.com, yehuda@hq.newdream.net,
	Tejun Heo <tj@kernel.org>, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v5 02/12] dm: Use bioset's front_pad for
	dm_rq_clone_bio_info
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Kent, Tejun

On 9 August 2012 09:57, Kent Overstreet <koverstreet@google.com> wrote:
>> Also, how was this tested?
>
> Well, AFAICT the only request based dm target is multipath, and from the
> documentation I've seen it doesn't appear to work without multipath
> hardware, or at least I haven't seen it documented how. So, unless
> there's another user I missed it's not been tested.

Multipath can be tested quite easily with a loopback scsi target, you
don't require specialized hardware.
The easiest way to do this would probably be the built in LIO target +
open_iscsi initiator.

I haven't attempted running this current version of the patch series
but I haven't run into issues with bcache+multipath in the past.

>
>>
>> Thanks.
>>
>> --
>> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
