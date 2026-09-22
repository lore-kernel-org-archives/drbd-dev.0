Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F654DD3D8
	for <drbd-dev@lists.linux.dev>; Tue, 22 Sep 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071107; cv=none; b=u9bYlSwVddXEgZGJznS4imi4JVR/T55elRNMICqgMnK6NpjB17uY9wYNxTEzpcVQA+sagzHT9xwluK3uek8jr+7/H+FYfiZLaw9oK6QdK74UOdw3DuKpzPHJVq3x2b+MVNAJK8JxSfRijqVpP3kTeXrUWIPp3z8u/GUWWlsYbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071107; c=relaxed/simple;
	bh=zYbfbPSv4oN0DQRZXu+ig0WpHZAE1jueUN/5aUe+dpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS6SHX30+GKn3WVUKo40rQpJ35tgorV9tBFp8sXIVBNcsXwW6rN9wEaXlNrG1Uhihj2XcZX5jZSH/bAms6+sHF7ursf6Gpe+wLRVXZKDZ0ku6LfZzvM5wRYCJ/JZHdSVEbwhcsGUUg9BWd615vqaE15HxfqfZyjJ9q4daw2qme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3QLVBky; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3QLVBky"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so29475545e9.0
        for <drbd-dev@lists.linux.dev>; Tue, 22 Sep 2026 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790071102; x=1790675902; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
        b=c3QLVBky+a+r/8iQ6N+F6FYbzYyzrNfBkBbfLdxuBsLj6tl4eG8iktcOD+TEIACUNB
         OOaIWxim/rlD5q17fJpvFmd/UtCfoORL6AyCp/heMcVpAZe0P/x28mQNXpH2YqKHCAbA
         fqVFyHI6+Vf/g+b+mUxLdO6gGxNy9hYUokRNU6HeK9r3HIx04UCoSz9fXkCXfK+pNufL
         AuHAFtKuEqURtf6YId4Rfoo48uegRR5JRpAaHJem91Ag/gP6l0POBq+FLCc0RstMtLYi
         r+xAsElcWWnjXlmQI6QxsUQH62A8nhLMx4ai3ZvA3XXTP5ghS6HrmzZ0td32ADUqjKqt
         f8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790071102; x=1790675902;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
        b=0GL1ttlp6tKkCpIHC/DTI+y5tqIj3QkUWoRT2womROX3Ma0nrlBXjqoszLULTmSWL4
         GUtDBnE+Z871nlbQVHzm+zMHIRoTRS1x+6jbPagQ1fEV7iSvNa1T4QVWDEs5d4FdVX7o
         25BLmUD8o5j3rvLbW5XFo31//POwwGklgv9GVnfxd1B6mvrFEzdF12kBJL/YRW/liTxe
         NvOLCmyzM/FSSIE4xwe6y+OERHuQLDcyOvi8OX2k5OWD8BT/zkmJkFhf5LGiwQMKlaQP
         Jc/WfrBSVPwNZFjW++4a6azMxuKAjCpAcoxzQkCfXnnkbp9LhBZ2dekszs8E9hgx5lER
         DBmQ==
X-Forwarded-Encrypted: i=1; AKwUvByf/kkg58m+HP7CV4v5QnA/yBhcYD2+yz6/1X1SvG7GeQ72c0jVW92G8n6TUpyJc5TDj0GntoTQjg==@lists.linux.dev
X-Gm-Message-State: AFuF++mY7lMhOA4zeDFujjWkox1PIrJKRWP2S3OSMCBgTLpf6Bf9f/ez
	aizsZhDlHxzIipuh7N3imKrjk/JSGrvhfpWvTcJKVj7Ul1h1dQdWygw6w+01UVd3bbw=
X-Gm-Gg: AYBFou0s5glAqcAs+QJj2e7VdfuxmOeQusdyPnhUduZHboA9qQLFH8cu/VZcoGJ85Zx
	XIh9T1uRzdQRq/Ivpr4RKFKNyZOkXvo4/BfZivu9e0nU4D05sFotk0dlsKpdhrAo5UNvvV/vgkN
	u7MVj9Vwu6kK0ITk0rw7SD230hc3u2M/9vGYBqQATSPjAZs4lkuVq5UD70hzcglzu/WBFCcmYVl
	aR2mRYMVtgq6bLQBl7GbdABJes8q4Ez6jFeZ44P+K46tVR8DFczf8J9qEddJN80sNYqvQjNwude
	ScKGPq/JCeVZl6BNUfmk6xEQ79SVfJhu/ZabMHKm3mrU9qD2zTOyQFoKaKrvEkGdM/KXro9GAvG
	Ypj84J9/i/gBdvOnkJ65cLkDLtZEnOzC8edxpJwO7AUo3j10m5lEqVefzCdb/q/CGjqzo7QKPU8
	UGLn4DXO/7bfiq1PFSgcVEv2ZSPC2kpHRljD5kxG8Sp7nfw/oGtJtSeyKwQ+QYLuHSHVPgF2BLw
	K03ZDBLjZ+TQYXe33DbOFFynvIf8wBaDjFjRscDLpWDe29G0ep21F9xR/QA8RS8zaMnScukuVGM
	xJXeZpC8VOuvjMulT0gq4bF53LrQ/jqh8uKsWZg9
X-Received: by 2002:a05:600c:a0a:b0:49e:84bf:6110 with SMTP id 5b1f17b1804b1-49fc56dbb49mr199597855e9.6.1790071101618;
        Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab0c240sm27108755e9.4.2026.09.22.02.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Message-ID: <2bf82e0b-a032-4ee7-8d93-c5604222723d@suse.com>
Date: Tue, 22 Sep 2026 11:58:18 +0200
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
To: petr.pavlu@suse.com
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
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 4:46 PM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
> files that use usermode helpers and remove linux/kmod.h where it is no
> longer needed.
> 
> Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
> 
> Finally, clean up linux/kmod.h so that it includes only the headers that it
> actually requires, importantly removing the compat linux/umh.h include.
> 
> This cleanup is motivated by trying to reduce the preprocessed size of
> linux/module.h, which includes linux/kmod.h. linux/module.h appears in
> roughly 15k #include directives across the kernel. This makes it a "hot"
> header, so it should avoid pulling in unnecessary definitions. Note that
> this series doesn't immediately improve the situation, since most of the
> files included by linux/kmod.h are, for now, also included by
> linux/module.h through other paths.
> 
> Apologies for the wide distribution. Acked-bys are appreciated.

I've queued the series on modules-next for 7.4-rc1.

-- 
Thanks,
Petr
