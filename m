Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432167;
	b=TvOT+LvslfD98sxTDl1bFowaLtxwOQ3vnKb7fYGJMfFtFqEX+A21DsTDTTCEo0Ozu4gh
	 9o9G7gspYFR7vZVReMav//CIgie8K+LFM5yKiREWjA2prMUQAOdrNeGgk2I0YWOmNwAcN
	 VBDfxxntCvahkqYbCC2RThesS//p9Yj5FGRYIWnynlg2frgT6XLQVE9+Vi1MCVJY0Idh3
	 KJkk94WiUu5Ntvxv3lbAJtAh/C1aN5s/GRNWWFirogAjRNwF6k6xNaDWwFcIlRURsuZ7S
	 IhdOUNBEzXenjIJdZZdSaS0U2kHAh6kc++usc1VHdtG/0pSf/i2TiSUjq8sEF9XnV0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qNxKPiQeUFdgj5mk31q87Xj7ea3z7WwoZY5qvyPJ8+A=;
	b=AH7S6p625WkAmc06SBsI+EyQPsJ2OX79hHCbdCYIlc9R2A5NgFJPXgrvhZLxep998a+h
	 O/9/2oXjpIdyoJKVuvc4YbHYa9+BPqNolp/Fc0jNYSo1jad49ac+yD6Au/dkcYV0XdFi2
	 mNVsPgNvWqiR/tjO3p4441Jovd5j/ELVjEbaxVjUbDph75ooRHwZVyKnY2kEZbMixxDnY
	 sOHMMJMQ0H4fcfUdusCOldwepwK7y+/hioYxQ1XPXmLEEYHgQGFO79zd0RBW0EpmXudWq
	 ahEGl6hyXKkzikEj7Bck8UjCSdHGLvHyVu+lWEDk5VatBJaSCJIFQE1t6B93GA0ndyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQgVMMUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73939606A321;
	Wed, 11 Nov 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQgVMMUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EF01F00A05;
	Wed, 11 Nov 2026 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794432167;
	bh=qNxKPiQeUFdgj5mk31q87Xj7ea3z7WwoZY5qvyPJ8+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQgVMMUmlD0SpJ0KID7Y8HWh8olv7I/ZO4L0+By/wkgx92QG/AE4pRs0m+gyTlYqW
	 eZGfzDQjaxSi8r2othzX0qSzrYm0SluOsWeu0BlJOEnpL7umc8LHSepnthDsmlLq+O
	 KuJZdeuFU9tlgTd5vjU1ywseP51tFuKXK87tNyF3eWIqGRu+Zjl+AAgjK3heZlkhBP
	 ZvAPkWWzMs2WXFxCPz6+WWPP6VuFtihLrB1JsJ5zOtpCxxze1UbdPibLUkC0iGItcM
	 9OAbVr+KeYhSzelIsbsv/mCWVyLGe+gBRA3D/quBx8uwyXEfiNEewrD1yiFzXf+25t
	 fb2OY6ifqFDoQ==
Date: Wed, 11 Nov 2026 13:22:45 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] drbd: select CRYPTO and CRYPTO_HASH
Message-ID: <20261111212245.GB41158@quark>
References: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Post: <mailto:drbd-dev@lists.linux.dev>
List-Help: <mailto:drbd-dev+help@lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:drbd-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111083505.3998706-1-christoph.boehmwalder@linbit.com>

On Wed, Nov 11, 2026 at 09:35:05AM +0100, Christoph Böhmwalder wrote:
> DRBD uses the shash API for the data integrity, online verify and
> checksum-based resync algorithms and for peer authentication, but
> BLK_DEV_DRBD does not select the crypto core. With CRYPTO=n, a kernel
> with DRBD built in does not link:
> 
>   ld: drbd_sender.c:(.text+0x137f): undefined reference to `crypto_shash_finup'
>   ld: drbd_receiver.c:(.text+0x58f): undefined reference to `crypto_alloc_shash'
> 
> Select CRYPTO and CRYPTO_HASH.
> 
> Fixes: b411b3637fa7 ("The DRBD driver")
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Looks fine for now, but you should consider what algorithms DRBD
actually needs and consider switching to the library APIs for those
instead of crypto_shash.  Presumably not more than a handful are
actually used in practice with DRBD, and you don't really need to keep
"supporting" MD4, Whirlpool, RIPEMD, CMAC-SM4, etc.?

The "pass arbitrary string from userspace to crypto_alloc_*()" strategy
has been problematic for other kernel features using it.  For one, it
gives access to algorithms that are obsolete, insecure, redundant or
make no sense for the use case.  And it makes it more difficult to
remove unused algorithms from the crypto API, since it makes it harder
to prove that they are in fact unused.

Note that the crypto_shash API is also somewhat inefficient and
difficult to use correctly, even though it's better than crypto_ahash.
(And the DRBD driver got it wrong, so just FYI, you should expect fixes
if you keep using it...).

- Eric
