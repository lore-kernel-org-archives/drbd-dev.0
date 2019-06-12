Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BCF2F1028A6C
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:09:02 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id p13so6979857wru.10
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:09:02 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id d3sm9488733wrf.87.2019.06.12.07.09.01
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:09:01 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:09:00 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612140900.GY5803@soda.linbit>
References: <9ddd5d91-affe-4a82-b563-45ea6082f5df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ddd5d91-affe-4a82-b563-45ea6082f5df@gmail.com>
Subject: Re: [Drbd-dev] avoid compiler warning about redefined macro
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

On Wed, Jun 05, 2019 at 10:05:29AM -0600, David Butterfield wrote:
> In drbd_dax_pmem.h:35:
> -#define arch_wb_cache_pmem(A, L) do { } while (0)
> +#define arch_wb_cache_pmem(A, S) do { } while (0)
> 
> Avoid compiler warning by making the macro definition exactly match the one in
> linux/libnvdimm.h:
>     drbd_dax_pmem.h:35: warning: "arch_wb_cache_pmem" redefined

Well, it should not have to define the same macro,
so there is likely some compat ifdef missing (or just an ifndef)

also I'm pretty sure the original in our code was copy pasted from their code...

    Lars

