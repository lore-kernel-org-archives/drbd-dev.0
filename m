Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E0262DF6256
	for <drbd-dev@lists.linbit.com>; Tue, 26 Feb 2008 13:49:20 +0100 (CET)
Date: Tue, 26 Feb 2008 13:49:20 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] I/O can hang on primary synctarget after an io error.
Message-ID: <20080226124920.GA5727@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C454F47ACE@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F47ACE@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Feb 25, 2008 at 04:53:35PM -0500, Montrose, Ernest wrote:
> Lars,
> We appear to have a009fc907a14f69026b32fbb48a4db6f1cdd5ecd.  Reading
> your response what I get is that we are guaranteed that if we return
> early in drbd_end_write_sec() then someone else would have done the
> dec_local near the end or an inc_local was never done?  

this "return early" does not happen.
because almost no driver actually implemented partial completion
notification in the first place, and if some driver should indeed
implement it, it is guaranteed to eventually call us with the the bio
comlpetely done.
finally, you trigger the "io-error" by fault insertion,
which directly calls the endio handler with bi_size == 0.

> Hmmm... our testing was not done with the latest git stuff.
> I will do some things with the latest.

keep us posted.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
