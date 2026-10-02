Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBA345C6FB
	for <drbd-dev@lists.linux.dev>; Fri,  2 Oct 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930024; cv=none; b=Ky50WTWYGXUXURYXIS9xj4uLUcBZFHFRmmHT2wiTfX4SqDIaNYtndBXdTCjpORWY/omqRaEo3S+xRtwqYiYN1BZxP4p2wns1T/IgLfgnru1dnH9TZe9uyIY5/vdwRl/CfUFADjAq5kFxvuHWqNCKPD8uB5Iu8mR7+twGp0EVFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930024; c=relaxed/simple;
	bh=sFVRBwYDD5Gnyd+B1hrfrWd2GP91KOOcraidKuP/0Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbFewxmh6YdQasiBJf6AnGVxkXOd2VjzDMqzGj/WDCJjYEBarWRAYWPT+d8vU4LyincLJ4OMqbct/A27lkPbEJupltN7J+ocRJrAzFzAQ87Dl3RAaVT8sRdgjJeo6LQfr4TqhhrJRSvpNupozHTDiFGn4Vk7U2BCFySWVmhAWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXZ/vgUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXZ/vgUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C01F008A4
	for <drbd-dev@lists.linux.dev>; Fri,  2 Oct 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930021;
	bh=w4IDAEWUM5goHy4cCtU/RvHHI4fpSYagB5nlgyoCVks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cXZ/vgUCZgLaMpyiIPgB3rJT4TzVgO3zOCcJ1gPBaCItJvklxFcBZMdtto7Vv57j7
	 WtPnQ9vq1tuDS5CQDM1xCaDiB8HsUENjLZd072V53xNDundlLTzOfApih5IAQQEEwq
	 kw+0zUFn1/q1lck7rju1TxV0KHv7tOtmG0P6Fyul1xEFb17OioyhCUTQ3FSYm5UJfH
	 PbkOBxf9tNDoAhY5X3k7VSnU5XvcyndoD3H/Bddsl5x8xLzF7cKCBhKa8gYh4gO6kE
	 pU0jYjH/pfNWir6ig/xaPsMDOo3rFI0WLizKlMts4ZODGEcTULmzs0xWmDvxoqQ5b9
	 PgO6QoK6L9eYg==
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-499c0f06935so2848162fac.3
        for <drbd-dev@lists.linux.dev>; Fri, 02 Oct 2026 01:33:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx46g77wN6QAXrg2mGtU+A04V+TqYsUuM6Wl/qsveyi+3xNTN+h5M2jOytjAMSAizx/SrMm6gYJYw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7XvrcGIiU61OJAGbm6oRhJBSGNSGert1V5upY4KzpgSVIduMX
	/vcVrlI6XObZorcBH7TGRXTkLjilYIe388SxPIG5s7pvuJglJWcpgagxPwQYZb8y5kDNlMgCwK1
	G90sQ+WMfu9JvUbTLQSMp9c1gc/o5g/o=
X-Received: by 2002:a05:6871:a841:b0:475:a153:2dbe with SMTP id
 586e51a60fabf-49e15d371demr1895507fac.20.1790930020024; Fri, 02 Oct 2026
 01:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: drbd-dev@lists.linux.dev
List-Id: <drbd-dev.lists.linux.dev>
List-Subscribe: <mailto:drbd-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:drbd-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
In-Reply-To: <179090395863.434549.3668493667259120759@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:33:29 +0200
X-Gmail-Original-Message-ID: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
X-Gm-Features: AclHuK8nVtaoGsIab0P-m2s1B3ju3ekNwAoCUlK85M2ENTXymnZNl3W63NoMomk
Message-ID: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, edumazet@google.com, 
	netdev@vger.kernel.org, aahringo@redhat.com, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] A TCP reset or TCP timeout while the connection is waiting for
>   send space can stall the dlm connection permanently.

I dunno if I want to spend time fixing all dlm bugs.

It seems TCP changes are now stuck because ood pre-existing bugs in
in-kernel-users.

Sad.
