Return-Path: <akhilesh@ee.iitb.ac.in>
Received: from smtp1.iitb.ac.in (smtpd7.iitb.ac.in [103.21.126.62])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 6A32C16225B
	for <drbd-dev@lists.linbit.com>; Wed, 13 Aug 2025 11:49:59 +0200 (CEST)
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 4441F101A45B
	for <drbd-dev@lists.linbit.com>; Wed, 13 Aug 2025 15:10:40 +0530 (IST)
Date: Wed, 13 Aug 2025 15:10:30 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Erick Karanja <karanja99erick@gmail.com>
Subject: Re: [PATCH] Docs: admin-guide: Correct spelling mistake
Message-ID: <aJxdjoALgYkPJ61Y@bhairav-test.ee.iitb.ac.in>
References: <20250813071837.668613-1-karanja99erick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813071837.668613-1-karanja99erick@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, skhan@linuxfoundation.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 13, 2025 at 10:18:36AM +0300, Erick Karanja wrote:
> Fix spelling mistake directoy to directory
 Fix spelling mistake directoy --> directory

> 
> Reported-by: codespell
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  Documentation/admin-guide/blockdev/zoned_loop.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
> index 9c7aa3b482f3..64dcfde7450a 100644
> --- a/Documentation/admin-guide/blockdev/zoned_loop.rst
> +++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
> @@ -79,7 +79,7 @@ zone_capacity_mb   Device zone capacity (must always be equal to or lower than
>                     the zone size. Default: zone size.
>  conv_zones         Total number of conventioanl zones starting from sector 0.
>                     Default: 8.
> -base_dir           Path to the base directoy where to create the directory
> +base_dir           Path to the base directory where to create the directory
>                     containing the zone files of the device.
>                     Default=/var/local/zloop.
>                     The device directory containing the zone files is always
> -- 
> 2.43.0
> 
> 
