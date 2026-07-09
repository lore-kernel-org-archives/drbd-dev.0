Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0C3FBB69
	for <drbd-dev@lists.linux.dev>; Thu,  9 Jul 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590597; cv=none; b=TgFz4kW5rT14YDiRg3IRf6+3pOhH44085fA26cO9WUAJiluDWU4nij2NwJ5GQ4UA1TsbuzyVGYnNRk2s3rX9k0ZcyNTRYZfyvNTWHsLqozqtWYlD67W2mdWaelXRDVcK1FNu+5PtECr78Hkd1OlLNGxL3MzTiTj4CgwcbiMm6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590597; c=relaxed/simple;
	bh=jTFvyUggpn9b7ir5dJXF/0vV6aESSqllkJsE1EJX8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b88w0ArCqXd3sNuDt+uQsGp94fyhZLObMA3ysFVmnwn4nNUojv/JCW66H47k9Weyl972sKcVCAP4/BRi3fYVQxPrxRNmfzQlhzmMGlwC37Y4be/p18aiJyGCKErmeQM34xrt98+2xjmk76IdTAaHKOspNQEQdK9p8eI/2ikgKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dTc1iAnX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dTc1iAnX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b77b150aso13078415e9.2
        for <drbd-dev@lists.linux.dev>; Thu, 09 Jul 2026 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783590589; x=1784195389; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=dTc1iAnXumS0eNcGGlimMKO2m7K9g1JFHC1iml+S0JqltjW0qdQ/Y3yEUFwdg2h/Y/
         SM0WRe5dY+82t3F5TqpBqaZrGy/GmYTpKPo2o4wguM478KY128lsyKJHhTWBXuvxsiYf
         ieHwqJuYyMVm7qSSUiIozNBvCZ9sFhkMvdjmPClUd+INpNjIAYtWxrxjmSI8fdXD90xY
         CKmFeGoqUuqxnHsvy2es+garUf0TFNNidPgfgTGIUHWsOPyVOwabFjnQj8NuVDu+wBj+
         xLuB4LVDvcWQ9n69+upXARGTRgqqIwKr8Xt4sCGOLSnAvEmd7XRj+YpoBp1xhPZASvXm
         SlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590589; x=1784195389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=NUcXCQ27TXRQb33SNFjygvmu7amyAUvfgElKUA+iD8fpWUfm4fVhZpnbCXa13/+WrM
         SJE79X+cf84CZTDrGmg4rqsuQANofgqRTxLCsGR/XZo1FgCUsXot1QEtn2MEcDtsMV3h
         EXjj1bz93Invnw0kLMshcX8jyl3x47Ec3PI38p0OLZw6eo8WvNXf8xqhbroweYaECCFG
         HT9Daad30AWabkEWnVwz2dLQ7wfsH4Y7lNjAVQLwOUHDrlAkgHAx2M09+WP38SRyouKM
         rG1l2fK2RdJZo+sFXCtb9a3F4a6oNlaQnA65aRCx4413vEgNI86gDIQ+p7tpZbVMT0F0
         FBGg==
X-Forwarded-Encrypted: i=1; AHgh+RrkV4luLvOMJEmAUgLIZW3wR7YqZlcG3MFsJLs60lLr38itwAGUU5j+cAivMQgPhHbjsMI/uC3o6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+OzPuJ20OluhHEEjQ/kRiMu2RRiwEs/NtKCtM+OqKJFOsvkO7
	Pct0tlKq93gWiGEbNH8XQCS50542ZUVUt4J0TfQp/w6I+Yetlqvbawnv/LOEm+Y/jjE=
X-Gm-Gg: AfdE7ckGXjXjIxSsH6W7a44XRALZ/haZdCyKlTf/+hGmCkM4yc5U9aQbUdp8wS0ypqw
	3sCAaaA3Q1rDDSo3sbhCAUJARCHyU3i7enufLHk9cjVX+kAD0l+zgDREDJSuWZnph+LxsLs8jUG
	Y1LdfmQM/Qko9O7ZjhvqZmvJUBbNXZntWtjsYA1rw/HuDETkAOtFjUEagFZhc2M0D9Mj4WpblNV
	+b9TpGKjuZtQfBb6JjKVjPHRaAzrnRc4/1Rh2kai5peSELm0sRcruaV6U7g2fWebiBcqpGQpUW/
	c+xKaB4Ek7UOohBIpgtTeCk7EI2otUEn0yFD7qS4AFoOTHSXFuD5SPOKUi3CD31rR6NjNN64tO8
	3Lcd7n1izXSDsPuCDB6hKxjee4Jz8xp3AJr5UtNcFpqktqgQq7E3kr422urx4Zw36gCu+IE4xU1
	Ay5ZVV+ArZmsyEW16QCNdUMMHg1l1Dm7mZDQ==
X-Received: by 2002:a05:600c:c1d7:20b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493e68c3535mr47652155e9.25.1783590588957;
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm47837275e9.6.2026.07.09.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Message-ID: <3e2ae6e8-41ad-45f0-a885-131a5711c276@suse.com>
Date: Thu, 9 Jul 2026 11:49:45 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
 <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 8:13 PM, Michal Koutný wrote:
> Hi Petr.
> 
> On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index a4337c9b5287..60eb994c32ae 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/pid_namespace.h>
>>  #include <linux/cgroupstats.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/umh.h>
>>  
>>  #include <trace/events/cgroup.h>
> 
> There is kmod.h in here too but it's unnecessary, no module lazy loading
> in this code.

You're right. I'll remove the kmod.h include from
kernel/cgroup/cgroup-v1.c. I went through all the files again and it
seems this was the only place I missed.

-- 
Thanks,
Petr
