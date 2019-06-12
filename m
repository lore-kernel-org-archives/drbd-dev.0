Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
	[209.85.128.46])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C469A1028A6C
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:06:19 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id v19so6681546wmj.5
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:06:19 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	j3sm18765274wrt.73.2019.06.12.07.06.16
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:06:17 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:06:15 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612140615.GX5803@soda.linbit>
References: <8ceba717-542f-5898-d5d4-890945a022fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ceba717-542f-5898-d5d4-890945a022fb@gmail.com>
Subject: Re: [Drbd-dev] integer overflow in dagtag_newer_eq(0, 1ULL<<63)
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

On Wed, Jun 05, 2019 at 10:01:27AM -0600, David Butterfield wrote:
> drbd_sender.c:maybe_send_unplug_remote() can assign (1ULL << 63) to unplug_dagtag_sector[i]:
> 
> 1674                 connection->todo.unplug_dagtag_sector[connection->todo.unplug_slot] =
> 1675                         connection->send.current_dagtag_sector + (1ULL << 63);
> 
> Later it reaches dagtag_newer_eq(0, unplug_dagtag_sector[i]) which converts its arguments to
> signed before subtracting.
> 
> 272 #define dagtag_newer_eq(a,b)      \
> 273         (typecheck(u64, a) && \
> 274          typecheck(u64, b) && \
> 275         ((s64)(a) - (s64)(b) >= 0))
> 
> But (signed)(1ULL << 63) is the maximum negative integer, and the value of
> (0 - (signed)(1ULL << 63)) cannot be represented.  So the subtraction ends in integer overflow.
> 
> drbd_sender.c:1660:9: runtime error: signed integer overflow: 0 - -9223372036854775808 cannot be represented in type 'long i

I don't care ;-)
but we can add in a -1, if it makes the world a better place


    Lars

