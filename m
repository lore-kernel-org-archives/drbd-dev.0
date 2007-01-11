Return-Path: <ard@kwaak.net>
Date: Thu, 11 Jan 2007 15:38:45 +0100
From: Ard van Breemen <ard@kwaak.net>
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] drbd 2.6.19 crypto changes
Message-ID: <20070111143845.GB15730@kwaak.net>
References: <20070110123116.GX15730@kwaak.net>
	<200701101723.47571.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101723.47571.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jan 10, 2007 at 05:23:46PM +0100, Philipp Reisner wrote:
> Here is the result of my work, maybe you can test it with a new
> kernel ? -- I only tested it on an old kernel with the old
> API.
> 
> My idea was to have wrappers that look like the new API for the
> old kernels, and make DRBD to use the new API in the DRBD code.
> 
> PS: In case you test it, please post the outcome.
drbd0: Writing meta data super block now.

crypto type=3
drbd0: conn( StandAlone -> Unconnected ) 

I got the message "not a digest", which is correct.
We are using CRYPTO_TYPE_HASH, which in turn uses
CRYPTO_TYPE_DIGEST.

Eh, never mind my babling, just this:

> -		if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST) {
> +		if (crypto_tfm_alg_type(crypto_hash_tfm(tfm)) != CRYPTO_ALG_TYPE_DIGEST) {
>  			retcode=CRAMAlgNotDigest;
>  			goto fail;
>  		}

s/CRYPTO_ALG_TYPE_DIGEST/CRYPTO_ALG_TYPE_HASH/g

then it probably works (I've removed the goto fail and just
printed the type, which was a HASH :-) ).

