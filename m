Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DEC8710556AF
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:44:27 +0100 (CET)
Resent-Message-ID: <20111107094427.GE15431@barkeeper1-xen.linbit>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8F52310556D2
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:35:31 +0100 (CET)
Received: by faar19 with SMTP id r19so9387422faa.27
	for <drbd-dev@lists.linbit.com>; Mon, 07 Nov 2011 01:35:29 -0800 (PST)
Message-ID: <4EB7A65F.4080501@hastexo.com>
Date: Mon, 07 Nov 2011 10:35:27 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1320595796-5181-1-git-send-email-florian@hastexo.com>
	<20111107093240.GD15431@barkeeper1-xen.linbit>
In-Reply-To: <20111107093240.GD15431@barkeeper1-xen.linbit>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] fix missing directory creation in "make install"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-11-07 10:32, Lars Ellenberg wrote:
> On Sun, Nov 06, 2011 at 05:09:55PM +0100, Florian Haas wrote:
>> Lars/Phil,
>>
>> please consider the following patch, which ensures that "make install"
>> creates DRBD_RUN_DIR. Issue highlighted by Eric Robinson, see:
>>
>> http://lists.linux-ha.org/pipermail/linux-ha/2011-November/044198.html
> 
> Can we just drop the configure nonsense again instead?

You're not asking _me_ in earnest, are you?

> As /var/run/ is a tmpfs on many distros now, subdirs and other things in
> it need to be recreated anyways as needed, which drbdsetup is actually
> supposed to be doing.

Then you might want to look into drbdsetup, because at least on 8.4.0 it
does not do so.

Florian

