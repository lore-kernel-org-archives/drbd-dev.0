Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B5D331028A6D
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 16:11:52 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id e16so17123801wrn.1
	for <drbd-dev@lists.linbit.com>; Wed, 12 Jun 2019 07:11:52 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219])
	by smtp.gmail.com with ESMTPSA id k82sm149312wma.15.2019.06.12.07.11.50
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 12 Jun 2019 07:11:51 -0700 (PDT)
Date: Wed, 12 Jun 2019 16:11:49 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190612141149.GA5803@soda.linbit>
References: <e9d5ec6e-30e9-9af1-06c3-bcf8b1d92068@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d5ec6e-30e9-9af1-06c3-bcf8b1d92068@gmail.com>
Subject: Re: [Drbd-dev] avoid use of errno as a function parameter name
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

On Wed, Jun 05, 2019 at 10:14:19AM -0600, David Butterfield wrote:
> Avoid use of errno as an argument name because it is allowed to be a macro such as
>     # define errno (*__errno_location ())

You do realize that we are kernel code...

   Lars
