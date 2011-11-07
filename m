Return-Path: <florian@hastexo.com>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CE97110556CA
	for <drbd-dev@lists.linbit.com>; Mon,  7 Nov 2011 10:58:35 +0100 (CET)
Received: by faar19 with SMTP id r19so9419535faa.27
	for <drbd-dev@lists.linbit.com>; Mon, 07 Nov 2011 01:58:35 -0800 (PST)
Message-ID: <4EB7ABC9.2050109@hastexo.com>
Date: Mon, 07 Nov 2011 10:58:33 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1320595796-5181-1-git-send-email-florian@hastexo.com>	<20111107093240.GD15431@barkeeper1-xen.linbit>	<4EB7A65F.4080501@hastexo.com>
	<20111107094828.GF15431@barkeeper1-xen.linbit>
In-Reply-To: <20111107094828.GF15431@barkeeper1-xen.linbit>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] fix missing directory creation in "make install"
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-11-07 10:48, Lars Ellenberg wrote:
> On Mon, Nov 07, 2011 at 10:35:27AM +0100, Florian Haas wrote:
>>> As /var/run/ is a tmpfs on many distros now, subdirs and other things in
>>> it need to be recreated anyways as needed, which drbdsetup is actually
>>> supposed to be doing.
>>
>> Then you might want to look into drbdsetup,
>> because at least on 8.4.0 it does not do so.
> 
> There is some mkdir() in there.
> 
> It obviously only mkdir */run/drbd, not */run/ itself
> (which, I think, it should not).
>
> So an other reason not to use the braindead autofoo "defaults".
> 
> Should we paint it pink?

Grumpy Developer Day today? Please do as you wish.

Florian
