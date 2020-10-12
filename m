Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id BF8264204E6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 17:43:52 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id y12so14351601wrp.6
	for <drbd-dev@lists.linbit.com>; Mon, 12 Oct 2020 08:43:52 -0700 (PDT)
Received: from soda.linbit (62-99-137-214.static.upcbusiness.at.
	[62.99.137.214]) by smtp.gmail.com with ESMTPSA id
	o6sm25500487wrm.69.2020.10.12.08.42.51
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 12 Oct 2020 08:42:52 -0700 (PDT)
Resent-Message-ID: <20201012154250.GT2116@soda.linbit>
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 1684E4203DE
	for <drbd-dev@lists.linbit.com>; Sun,  5 Jul 2020 22:31:06 +0200 (CEST)
From: Jonathan Corbet <corbet@lwn.net>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <20200705142200.2154779f@lwn.net>
In-Reply-To: <20200627103111.71771-1-grandmaster@al2klimov.de>
References: <20200627103111.71771-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, philipp.reisner@linbit.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	mchehab+samsung@kernel.org, lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Replace HTTP links with HTTPS ones: DRBD
	driver
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
Date: Mon, 12 Oct 2020 15:45:15 -0000

On Sat, 27 Jun 2020 12:31:11 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

So I've applied this but...
> ---
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/admin-guide/blockdev/drbd/index.rst | 2 +-
>  Documentation/admin-guide/blockdev/floppy.rst     | 6 +++---
>  drivers/block/drbd/Kconfig                        | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/drbd/index.rst b/Documentation/admin-guide/blockdev/drbd/index.rst
> index 68ecd5c113e9..561fd1e35917 100644
> --- a/Documentation/admin-guide/blockdev/drbd/index.rst
> +++ b/Documentation/admin-guide/blockdev/drbd/index.rst
> @@ -10,7 +10,7 @@ Description
>    clusters and in this context, is a "drop-in" replacement for shared
>    storage. Simplistically, you could see it as a network RAID 1.
>  
> -  Please visit http://www.drbd.org to find out more.
> +  Please visit https://www.drbd.org to find out more.

This link redirects to a somewhat commercial page and may not be what was
intended back then.

>  
>  .. toctree::
>     :maxdepth: 1
> diff --git a/Documentation/admin-guide/blockdev/floppy.rst b/Documentation/admin-guide/blockdev/floppy.rst
> index 4a8f31cf4139..0328438ebe2c 100644
> --- a/Documentation/admin-guide/blockdev/floppy.rst
> +++ b/Documentation/admin-guide/blockdev/floppy.rst
> @@ -6,7 +6,7 @@ FAQ list:
>  =========
>  
>  A FAQ list may be found in the fdutils package (see below), and also
> -at <http://fdutils.linux.lu/faq.html>.
> +at <https://fdutils.linux.lu/faq.html>.

This page hasn't been updated in 15 years, and may be of limited utility.
The document itself talks about LILO on a 2.6.9 kernel, PS/2 floppies, and
other such bleeding-edge things.  It sure needs more help than this.

>  
>  
>  LILO configuration options (Thinkpad users, read this)
> @@ -220,11 +220,11 @@ It also contains additional documentation about the floppy driver.
>  
>  The latest version can be found at fdutils homepage:
>  
> - http://fdutils.linux.lu
> + https://fdutils.linux.lu
>  
>  The fdutils releases can be found at:
>  
> - http://fdutils.linux.lu/download.html
> + https://fdutils.linux.lu/download.html
>  
>   http://www.tux.org/pub/knaff/fdutils/

That link is completely dead and should just come out.

But at least we have some HTTPS links.  

jon
