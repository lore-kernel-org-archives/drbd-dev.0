Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
	[209.85.218.43])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9D746420632
	for <drbd-dev@lists.linbit.com>; Wed, 15 Jun 2022 18:32:59 +0200 (CEST)
Received: by mail-ej1-f43.google.com with SMTP id s12so24355334ejx.3
	for <drbd-dev@lists.linbit.com>; Wed, 15 Jun 2022 09:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220615140620.31630-1-kvapss@gmail.com>
In-Reply-To: <20220615140620.31630-1-kvapss@gmail.com>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Wed, 15 Jun 2022 18:32:48 +0200
Message-ID: <CAGNP_+VHaMWzb-Z4ujuasuVDoLE459JAQ6q88JDLGeKJwKfmjw@mail.gmail.com>
To: Andrei Kvapil <kvapss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] compat: make spaas url configurable
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

Thanks for the contribution. Seems like a reasonable idea to me.

> diff --git a/Makefile b/Makefile
> index 87c29518..37d7851d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -37,6 +37,7 @@ DOCKERIMAGESTARGETS = $(addprefix dockerimage.,$(DOCKERIMAGES))
>  # Use the SPAAS (spatch as a service) online service
>  # Have this as make variable for distributions.
>  SPAAS ?= true
> +SPAAS_URL ?= https://drbd.io:2020

What is the purpose of this definition in the top-level Makefile? As
far as I can see, it is only needed in the other one.

I guess it serves a documentation purpose, showing what command line
variables can be set. That is presumably the point of the SPAAS
variable in the top-level makefile. In that case, explicitly pass it
down like the SPAAS variable for consistency.

Best regards,
Joel
