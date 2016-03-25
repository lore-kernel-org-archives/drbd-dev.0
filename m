Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id BA45A1051881
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id A9B9C3EBFF0
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0_mD3dFVwQxE for <drbd-dev@lists.linbit.com>;
	Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 892293EC1E3
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZV3eaXNNjEu4 for <drbd-dev@lists.linbit.com>;
	Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 5B5033EBFF0
	for <drbd-dev@lists.linbit.com>; Fri, 25 Mar 2016 12:02:32 +0100 (CET)
Date: Fri, 25 Mar 2016 12:02:31 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160325110231.GA15462@rck.sh>
References: <CAF6H8oGVdkia=A4eHTnHtR3FeBkQbhWL8C7j3_4a=w42Ghvifg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6H8oGVdkia=A4eHTnHtR3FeBkQbhWL8C7j3_4a=w42Ghvifg@mail.gmail.com>
Subject: Re: [Drbd-dev] [CASE-35] Please check double auto-increment on
 history_uuids[i++].
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

On Fri, Mar 25, 2016 at 07:30:29PM +0900, Jaeheon Kim wrote:
> Hi,
> 
> According to the following code, local i variable be incremented by twice
> in one loop.
> Is this auto-increment operation no problem?
> 
> 
> receive_uuids110()
> {
>     ...
>     for (i = 0; i < history_uuids; i++)
>          peer_device->history_uuids[i++] =
> be64_to_cpu(p->other_uuids[pos++]);
>     ...
> }
> 

Thanks for reporting,

yes, the double increment seems wrong to me.

Regards, rck
