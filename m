Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0CD7E1028A7B
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 17:06:23 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id p11so14288564wre.7
	for <drbd-dev@lists.linbit.com>; Mon, 24 Jun 2019 08:06:23 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	j7sm15598436wru.54.2019.06.24.08.06.22
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 24 Jun 2019 08:06:23 -0700 (PDT)
Resent-Message-ID: <20190624150621.GR30528@soda.linbit>
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 0E7AF1019AC6
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jun 2019 05:42:57 +0200 (CEST)
Date: Tue, 18 Jun 2019 11:42:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190618034240.m4cnyjsbe4txth72@gondor.apana.org.au>
References: <20190617132440.2721536-1-arnd@arndb.de>
	<20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
	<CAK8P3a2g4ZDcyxuSOkYzOmqV3Hc3YF3Anc3GQysvGo9bijYufQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2g4ZDcyxuSOkYzOmqV3Hc3YF3Anc3GQysvGo9bijYufQ@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers@google.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
	Roland Kammerer <roland.kammerer@linbit.com>
Subject: Re: [Drbd-dev] [PATCH] drbd: dynamically allocate shash descriptor
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

On Mon, Jun 17, 2019 at 10:58:58PM +0200, Arnd Bergmann wrote:
>
> The warning is gone with this patch. Instead of 1280 bytes for drbd_receiver,
> I now see 512 bytes, and 768 bytes for drbd_get_response, everything else is
> under 160 bytes in this file.
> 
> However, with the call chain of
> 
> drbd_receiver
>    conn_connect
>        drbd_do_auth
>              drbd_get_response
> 
> This still adds up to as much as before, so it only shuts up the
> warning but does not reduce the maximum stack usage.

OK so it doesn't really reduce it.  Let's just go with your patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
