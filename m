Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7A9710556CA
	for <drbd-dev@lists.linbit.com>; Wed,  9 Nov 2011 21:24:29 +0100 (CET)
Resent-Message-ID: <20111109202429.GR15431@barkeeper1-xen.linbit>
MIME-Version: 1.0
In-Reply-To: <1320850927-30240-3-git-send-email-ian.campbell@citrix.com>
References: <1320850895.955.172.camel@zakaz.uk.xensource.com>
	<1320850927-30240-3-git-send-email-ian.campbell@citrix.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Wed, 9 Nov 2011 19:02:44 +0100
Message-ID: <CAHXqBFKXV14WrKRipaeMJ9_fpWDH_ud_2UjpKYKHKN08t3m-yw@mail.gmail.com>
To: Ian Campbell <ian.campbell@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: devel@driverdev.osuosl.org, rds-devel@oss.oracle.com,
	"Pekka Savola \(ipv6\)" <pekkas@netcore.fi>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	James Morris <jmorris@namei.org>,
	Patrick McHardy <kaber@trash.net>, cluster-devel@redhat.com,
	ocfs2-devel@oss.oracle.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, drbd-user@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 3/4] net: add paged frag destructor support
	to kernel_sendpage.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

2011/11/9 Ian Campbell <ian.campbell@citrix.com>:
> This requires adding a new argument to various sendpage hooks up and down=
 the
> stack. At the moment this parameter is always NULL.
[...]
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -203,6 +204,7 @@ struct proto_ops {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*sendpage=
) =C2=A0(struct socket *sock, struct page *page,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct skb_frag_des=
tructor *destroy,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int offset, size=
_t size, int flags);

Maybe you could instead add new op like sendfrag() that would get
already prepared skb_frag_struct? In the end all page data ends up
described in skb_frag_struct, so this would reduce copying this
information all over network stack. This might be a bigger change,
though.

Best Regards,
Micha=C5=82 Miros=C5=82aw
