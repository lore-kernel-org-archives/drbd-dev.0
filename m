Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E54A138B
	for <drbd-dev@lists.linux.dev>; Wed,  8 Jul 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534416; cv=none; b=t6SbF/tCk2kY+LUvwpht0vH2Hkk9FViUWs6Y+8OjiKMW45WOZvEnMN223mHLWqjR9DYzghQf0e0qcMOmDX+DKAEXW4gzz6mpS0aXbS9i9POwFeNTkM093TM8DMpYyYgUbNogQB05x+Tl7lBIWLtJjlhIuV/Su5Ydagaw7ZdeBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534416; c=relaxed/simple;
	bh=mKB64eFzBwevlbfHP4GHbGCdzZzNbk41FGpjUYsfux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+dW05rETSFEMOBB6raBySSynD9SkoVxOFeQqtz1zjg4d4UjJbxFbC/xG5xk1kCQPavbqi3loONtUrePVr1CAWfjJnzeJINUVyKK4eF+KWWQbdgbKPA1e/cByvu3P4xTtvudCYh3KV6cL0PUijUNhOdWrbaAo/xilU/0rC1F7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W0RGk0B3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W0RGk0B3"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47db714766aso84560f8f.0
        for <drbd-dev@lists.linux.dev>; Wed, 08 Jul 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783534407; x=1784139207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=W0RGk0B3P+wqm4AgZ/vsB1z8Yw32zZNsMPsLdsSgrQ4ja6BX7OqqjG0GHaEG7jM2kR
         0MLCkfHo22RaGnDpPiix0O6gVcZgeRBee6fxPVw3Gc2f4B+Cp2wZK/o1sVxtz8QDxfMh
         +sssDK7iL8L0VWIPQl8/Tu/cYKt1Vw1pDVt9z38vxqHUBJrPeCZ/5fY9vVAM1XZjzyqu
         +NvI0kuqgDbuKjPZl5/jF4/eUHH+m0QKCQ0BgDqrRbHza7ncE5mEjyHHazbQBJ7ICBY0
         yl6qprqBLuV/vgXXxukaxViq53nJMTtUF395uQof4qCJ65/KfakHKr3PHCAnzAoPuR3I
         NJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534407; x=1784139207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=X6OPMm3wDSCWX6nofLk1akfMH2ZD730P+yaaoCMj1sHJm9EhUwHWZ9LXo7bEZRi8WH
         2GfTbs2zdK7C29ovh/FRVyNFIXqwDvimyOs8Hks6nIPPu8tg7MX435gii3Ao6zMtjrx4
         gGnQ4C9i7PRFDeObU1S9rg7/8qrWoMghpkFM80FKB/BVMBZ/yD4ZPPVYz9sBqEwOxvqs
         wLjskW2pM8i+la9Z28mF8RZASNTF0b0sUarwPcfpoNPhJmXPTRVRBcwlRzEcIDIBJdEC
         2MqYPT1VxAVJ4w7mqZC/K6hMeJCD8qZqxH9/CxbD9z7s5crr0SzDewwBuHWQ+4GGGhzk
         oNBA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4vzEuDSvFUa1hpPlSfWTKG/zsB5RV5av5p9fiTCYgHLZufKVEEMca6yNL3fx6yIBpAyAehTL4/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYx+XoHDT0OA+/dEfr+PNNPycFf7CVPyeEYjv9smWwgknxpwKP
	WBNaZBpdmLPy5yC1xxlDpZsAxAVn7u5oC6d+XQVbcIgpmdXExwMGxtA8guwqNXDJyGw=
X-Gm-Gg: AfdE7cnMEh3qPkRq+WZcWl9mkPJG+Reb6uy02lB0AF8W+fJu4MqRIHc9r/sNDe4kht1
	2aHFqSuJblLogm1e6Xqj2ygxr1x4xpj5ZUqo6GIzpCdOGVVOJXo+cY/+Sz+ss+S5CpizzY+N8XW
	QkOFSp92FdRyyTYJ6ldRVuzWO+63c+sbcpMsnVoe4bWnM62P90C0tdEqmoTacK+XOmmxXYWyeW2
	asnJ/Q73fHpTcyr+0XVApZkpdJPeUkI72YzBzY32LgS0ANlJ6Rw65Gq2HjrMD0bBBX5TzHwDSKB
	+3/NJ4wAuF6bVycW70UvSGIUpFYP7kSl6DBo1HN3p2EurqWIidndZcnCkBmW6xwqqIuEk8qj0FU
	/dkQy0xpIz0sZg/yk776RjRN9asMTDQCJKhr8GyPCRlEHAXZYW4MQ42rPmi6XmKSLxPajda2kmO
	BwA+5HYppxrE+jKUQcV+bwHsunVpBuEYB9Sc8V5g==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837;
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, 
	Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--
