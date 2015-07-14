Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 9012E105058C
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 64EA2467874
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wvA4Two7W8Bt for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 46FBE467953
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MqhSMH2XI8CI for <drbd-dev@lists.linbit.com>;
	Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Received: from localhost (chello213047144126.1.15.vie.surfer.at
	[213.47.144.126])
	by zimbra13.linbit.com (Postfix) with ESMTPSA id 1C03F467874
	for <drbd-dev@lists.linbit.com>; Tue, 14 Jul 2015 15:42:51 +0200 (CEST)
Date: Tue, 14 Jul 2015 15:42:50 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150714134249.GA22235@rck.sh>
References: <55A50445.70205@mhtx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55A50445.70205@mhtx.net>
Subject: Re: [Drbd-dev] drbdmanage and Python 3
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

On Tue, Jul 14, 2015 at 07:44:53AM -0500, Major Hayden wrote:
> Hello there,
> 
> This is my first email to this list, so please let me know if this
> email is off-topic or belongs elsewhere!  I've been a DRBD user for
> several years and I maintain the drbd packages for Fedora.
> 
> I heard about drbdmanage and DRBD9 at a conference recently and I'm
> working to package drbdmanage on Fedora.  However, it appears that
> drbdmanage isn't ready to be run with Python 3 quite yet.  I found
> some print's without parentheses fairly quickly but I haven't taken a
> deep dive yet.
> 
> Would Python 3 support and fixes be welcomed for drbdmanage?  If so,
> would it make sense to send lots of patches to this list or send them
> somewhere else?
> 

Hi and welcome to the list,

drbd-dev is for patch coordination and drbdmanage is also coordinated on
this list, so it is the right list.

You are right, drbdmanage is not yet ready for python3 and it is one of
the TODO items where help is highly appreciated! 

Sending patches to this list is fine. If you can host your own repo, a
clone of our public repo with your own "for-upstream-py3" branch would
also be okay. Actually, I would prefer that plus mails to drbd-dev
whenever you are ready and we should merge your patches. Choose whatever
work flow you are most comfortable.

Currently, development on drbdmanage is mainly done by Robert, the
chief, and myself, his sidekick. For me it is perfectly fine to contact
me off-list if there are questions not appropriate for a broader
audience.

Regards, rck
