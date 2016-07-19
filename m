Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 145B31028A59
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2016 15:43:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 027B242C194
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2016 15:43:16 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MVVL8bD3F0E4 for <drbd-dev@lists.linbit.com>;
	Tue, 19 Jul 2016 15:43:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id D718B42C193
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2016 15:43:15 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2JM1Y9Uyg3fI for <drbd-dev@lists.linbit.com>;
	Tue, 19 Jul 2016 15:43:15 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id A98E542C192
	for <drbd-dev@lists.linbit.com>; Tue, 19 Jul 2016 15:43:15 +0200 (CEST)
Date: Tue, 19 Jul 2016 15:43:15 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20160719134314.GS51653@rck.sh>
References: <OF37515991.295CA5F9-ON80257FF3.004587D1-80257FF3.0046342D@notes.na.collabserv.com>
	<20160719080608.GN51653@rck.sh>
	<OF2611A83C.1682D95B-ON80257FF5.003062EF-80257FF5.003263CF@notes.na.collabserv.com>
	<20160719115816.GP51653@rck.sh>
	<OFCB153B85.CEBDDD88-ON80257FF5.00497DB6-80257FF5.0049A628@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFCB153B85.CEBDDD88-ON80257FF5.00497DB6-80257FF5.0049A628@notes.na.collabserv.com>
Subject: Re: [Drbd-dev] [DRBD-user] Dependency on "docker" in
	drbdmanage-docker-volume
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

On Tue, Jul 19, 2016 at 02:24:27PM +0100, John Colgrave wrote:
> That package installed on one of my systems that has docker-engine 
> installed.

Thanks, updated rpm is now in our customer rpm repos as version 0.7-2.

and in the git:
http://git.drbd.org/drbdmanage-docker-volume.git/commit/9a55c0c24103930193ce0e3f67a4ff6a97c129d8

Regards, rck
