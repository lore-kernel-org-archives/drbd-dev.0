Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 577EC101E048
	for <drbd-dev@lists.linbit.com>; Mon, 29 Sep 2014 20:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 417E23829C2
	for <drbd-dev@lists.linbit.com>; Mon, 29 Sep 2014 20:31:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id J_TQ1ybkDeJx for <drbd-dev@lists.linbit.com>;
	Mon, 29 Sep 2014 20:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 23D08386986
	for <drbd-dev@lists.linbit.com>; Mon, 29 Sep 2014 20:31:45 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WNUfE94BTjPv for <drbd-dev@lists.linbit.com>;
	Mon, 29 Sep 2014 20:31:45 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id C1B9A3829C2
	for <drbd-dev@lists.linbit.com>; Mon, 29 Sep 2014 20:31:44 +0200 (CEST)
Resent-Message-ID: <20140929183144.GD14672@soda.linbit>
Received: from r00tworld.com (r00tworld.com [212.85.137.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DC3AA101E067
	for <drbd-dev@lists.linbit.com>; Sat, 27 Sep 2014 02:46:11 +0200 (CEST)
From: "PaX Team" <pageexec@freemail.hu>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Date: Sat, 27 Sep 2014 02:45:47 +0200
MIME-Version: 1.0
Message-ID: <542608BB.1155.7B400B3@pageexec.freemail.hu>
In-reply-to: <20140925000748.GB20814@soda.linbit>
References: <20140919094909.GA21578@schiffbauer.net>,
	<542352D0.5354.4E270879@pageexec.freemail.hu>,
	<20140925000748.GB20814@soda.linbit>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Cc: spender@grsecurity.net, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd 8.4.3: refcounter overflow on re-sync
Reply-To: pageexec@freemail.hu
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

On 25 Sep 2014 at 2:07, Lars Ellenberg wrote:

> In this overflow case, I still don't see why it is supposed to help to
> shoot the process that happens to be "current" when the overflow occurs,
> respectively why it would be a valid assumption that this process would
> be "the exploit", provoking the overflow on purpose...

for an exploit to be useful it has to be both successful (be able to exploit
the bug(s)) and also reliable (do so 100% of the time, or at least without
any ill side-effects in case of both success and failure).

for refcount overflow based exploits it means precise control over the refcount.
since the exploit is a userland process, in practice only those refcount bugs
are relevant that execute in syscalls. therefore 'current' is actually the
exploit process in practice and more strategically, it runs under the uid that
must have been owned a priori. so killing the triggering process does not only
clean up an otherwise cpu-hungry process (taking 4G refcounts takes time) but
also generates an event about a potential breach of security with actionable
details (at least grsec has such capabilities).

> Though I dislike it even more that it (implementing protection
> techniques) is even necessary, if you have to assume they are out to get
> you.  Which is more a fact than an assumption, in more scenarios than
> I'd like it to be.  So you keep preventing existing bugs elsewhere from
> becoming exploitable, and I'll shut up :)

our protection mechanisms (will continue to) cover all kernel code, including
drbd ;). speaking of that, you could do some hardening yourself in fact, e.g.,
constify data_cmd and asender_cmd. we do this automatically with a gcc plugin
but it'd be a trivial source patch.

cheers,
  PaX Team

