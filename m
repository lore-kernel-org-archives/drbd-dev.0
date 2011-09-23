Return-Path: <kyle@moffetthome.net>
Received: from mail-pz0-f44.google.com (mail-pz0-f44.google.com
	[209.85.210.44]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 3327C10556BA
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 19:55:05 +0200 (CEST)
Received: by pzk32 with SMTP id 32so15585011pzk.3
	for <drbd-dev@lists.linbit.com>; Fri, 23 Sep 2011 10:55:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316788285-17433-11-git-send-email-philipp.reisner@linbit.com>
References: <1316788285-17433-1-git-send-email-philipp.reisner@linbit.com>
	<1316788285-17433-11-git-send-email-philipp.reisner@linbit.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Fri, 23 Sep 2011 13:24:48 -0400
Message-ID: <CAGZ=bqJpPOFVbONmRbfww+GYb-9__33wGwbBYN0Gjt+3+w4o5g@mail.gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 10/10] drbd: For protocol versions before 100,
 use mixed header versions
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Sep 23, 2011 at 10:31, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> Previous versions of drbd are using version 80 headers for all packets
> short enough for protocol 80. =C2=A0They support both header versions in
> worker context, but only version 80 headers in asynchronous context.
> For backwards compatibility, continue to use version 80 headers for
> short packets before protocol version 100.
>
> From protocol version 100 on, use the same header version for all
> packets.

If I understand it correctly, this patch fixes a backwards compat bug in
code introduced 2 patches earlier:
  [PATCH 08/10] drbd: Introduce protocol version 100 headers

Therefore this patch (and its commit message) should just be rolled into
that one to prevent the bug in the first place.

Cheers,
Kyle Moffett
