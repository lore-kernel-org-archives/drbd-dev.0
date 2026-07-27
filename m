Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8404156D0
	for <drbd-dev@lists.linux.dev>; Mon, 27 Jul 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164299; cv=none; b=M8qGjrSCwuB6074e7d1Rcvjn0zcyJlY4tglSIVARruvpgHeo1VtSmNA/zbe0555wAAD3uQ1UdIuOw3zhkf1Kd6/XFDggYkjHHx6jzt1kWS0FUodrpvnKs8mk+1ECNeJOkUs7z+0vWl6ftilG9kWDS7F6m+OBE1Jh46Ib4SQ3pmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164299; c=relaxed/simple;
	bh=/pHEhqhHim6zbvXlXGSytIteuWLfY5Kr9gwBWC8fFio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9FJoI+/J7bcW5Fk+fB0vFSYhaTUK721cjjAwBowt00TopjdNpZ2yhQduKSssPWwsT0i3hSTvOFNbDg84nlt7xYaGHHdKZcX5T9+twdaWkUcfu8EJWEot7xjdG5Pj3nCX/qtLuk/KgbRMGYXtj5ee1O0+gXvOhPkPJ9+/3Jydd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJkkvjTN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJkkvjTN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1590081f8f.3
        for <drbd-dev@lists.linux.dev>; Mon, 27 Jul 2026 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785164294; x=1785769094; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=JJkkvjTNlmmNWCi3VjyVxrmmKxSfSSQ+hGVXuXBj6m/uM7MPmM+mh9oRv71rxvGCq9
         XV2nxG+CK1s77x0MR+kA3GNQGjxTjWc8XSU56sFLciS0kbH/4Z74IJKQWWRlfmlJR8ns
         YxmZBCSnzQU0BQgUUhqJBbpad/k5FmhjqmRB9M3YUa1HJBMJk71sxOmcCiyVO5jTOKg9
         Cy47tXZXEOpAMPe41qNTL+eSLHdepDxFAKBRcMJjCa1musD73YkZF9g+/95IdK9rG9qp
         ECb/5QYdrW9z1bRxSHFWk0Mt0jyHUxWCk5tse9Ct1wba0V7khXKI+CIjHzBh5si4dEtk
         TrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164294; x=1785769094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=R2fwYxXWA+ql1BtKEEU0TVlKFDT8NUKx2Wfm9w7vz31oEKkdd7vIJToJICAI03OpzJ
         5D4mkjqB/9F9shSlpInzzzXSs/nHVTaelN/CiVBY2tbsRpLt4VUyTz9T7B1m9BnUbHF2
         yAq7oHEtTKA4obOinfPH8gBaiOuLklrDrRYw8YB4YsU4XEPnMo4cCe8twmcJ0fEWz+lp
         3/MrCkdbCAlieMtzQUR0Kc7wiP0roazalao7sqa3r6uyzuhmLzuKrTwwcTq3vtDJCFrz
         WY+w7ZRK1LjENaQspxGw7nqRoJKcPlXwlXyBnIEfMXW6OHTM+V+CmuLy7FNqfTOfM6ur
         sANQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6/dPv8ywt3tUcr4Vyt/Zlr8uhZS10MK7JBHVPZwN2C3r7NAVxmRUmxeU+BHyrxcdYoAYZLOwgFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrhlE9m2CfHwOIxlQCdcdsVfEwMSV65uls+IuJqsL3IUOzdGai
	UU7XNAnuy6zVIIv4SXXjEDA7GYDYFGXd4FSYpGGd/TkOq0pPzKapQNU+IlKuD3SXOkM=
X-Gm-Gg: AR+sD11c/mbTyPb4fa/Rw6orTrS6w2XWSDdXKpwVlNuloxZJVDOqW2G+HdOZNRSobZL
	i442RI71QJbgPxj3kGb+snfJiCMg9xUeipnZgFIyEKc6ctAMaZD7IchVlJqMns3+BiFR+p2FJBx
	H6MnBVWTc8WSb2Fr8mvdPTrLrP2PdIyXbmJIAENSZ3fp/2YJ1u3VbOk5Csq8k5isXFdCyRYrw7r
	/FzdHylf4rV/2xrBv8g5IokZUkAk+bE8lY+5ZiXXxQEZ4dJ0WhpEOA4tPs93MRHfip1V2pxFZmy
	dxokmMnZqmqbaaEWusrFdg2gKPUdFVl+wqDfK4f1uXdn+/SUsTU5Ku+TDzobn/q+oyj2hIDHuG3
	qZSPO1Q0AwcAjIp5SOdanqWJg5mSz6nD4mExTXcQJGndUlEoGng+L8nfrNrnmqfouILYegN942Q
	YIEpIKJOBiRsLBS/BXK+5KpE0lYsycUXFFjfSBCE8=
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr114339235e9.39.1785164294020;
        Mon, 27 Jul 2026 07:58:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm231594995e9.4.2026.07.27.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:58:13 -0700 (PDT)
Message-ID: <ead73f81-26ef-4a46-9ad8-fcd2915563e1@suse.com>
Date: Mon, 27 Jul 2026 16:58:11 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
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
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com> <874ihmke0k.ffs@fw13>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <874ihmke0k.ffs@fw13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:31 PM, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:
> 
>> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
> 
> jiffies.c uses ...
> 
>> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
>> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
>> currently relies on this header being included indirectly through
>> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
>> removing the linux/sysctl.h include from linux/kmod.h.
> 
> Can you please split that spaghetti sentence into paragraphs?
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog

I will update it to:

    jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
    proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
    which are declared in linux/sysctl.h. It currently gets that header
    indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
    needs to include linux/sysctl.h.

    Include linux/sysctl.h directly in jiffies.c ahead of removing the
    unnecessary include from linux/kmod.h.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

-- 
Thanks,
Petr
