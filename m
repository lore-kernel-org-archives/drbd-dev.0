Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 53D101056444
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 15:13:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 45F2A2A7CBA
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 15:13:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id HlyLtAFExSsW for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jun 2016 15:13:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 242252A81E2
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 15:13:19 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id euclM6MUltlD for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jun 2016 15:13:19 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id E87552A7CBA
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jun 2016 15:13:18 +0200 (CEST)
Date: Tue, 14 Jun 2016 15:13:18 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160614131318.GG1338@rck.sh>
References: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9e454d-566a-11a9-4f72-865737f23713@sandisk.com>
Subject: Re: [Drbd-dev] [PATCH for drbd-utils 0/6]
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

On Tue, Jun 14, 2016 at 01:53:49PM +0200, Bart Van Assche wrote:
> Hello Roland,
> 
> This series contains six patches - three for the drbd.ocf script and three
> for the crm-fence-peer.sh script. It would be appreciated if you could
> review these patches.

Hi Bart,

looks good to me. While most of them are "silence some warnings"
patches, it is a good thing to have these scripts statically analyzable.
And 4/6 IMO actually fixes a bug.

Squashed and applied.

Thanks, rck
