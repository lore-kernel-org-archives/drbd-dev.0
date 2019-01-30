Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E7AD6103B4DB
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jan 2019 18:15:36 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id z5so277068wrt.11
	for <drbd-dev@lists.linbit.com>; Wed, 30 Jan 2019 09:15:36 -0800 (PST)
Date: Wed, 30 Jan 2019 18:15:34 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20190130171533.2g3fi2544fzai6tx@rck.sh>
References: <20190130154816.6480-1-johannes@johannesthoma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130154816.6480-1-johannes@johannesthoma.com>
Subject: Re: [Drbd-dev] [PATCH] Fix an uninitialized use of loop condition.
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

On Wed, Jan 30, 2019 at 04:48:16PM +0100, Johannes Thoma wrote:
> On a continue the loop condition is checked, however the
> condition used a yet uninitialied variable. gcc does not
> warn about this, however other compilers (Microsoft Visual C,
> IBM AS/400 C compiler) do.
> ---
>  drbd/drbd_transport_tcp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drbd/drbd_transport_tcp.c b/drbd/drbd_transport_tcp.c
> index 64515dce..0eb45567 100644
> --- a/drbd/drbd_transport_tcp.c
> +++ b/drbd/drbd_transport_tcp.c
> @@ -941,6 +941,7 @@ static int dtt_connect(struct drbd_transport *transport)
>  	connect_to_path = container_of(drbd_path, struct dtt_path, path);
>  	spin_unlock(&tcp_transport->paths_lock);
>  
> +	ok = false;
>  	do {
>  		struct socket *s = NULL;
>  

Good catch, it's this one fine continue... Applied.

Thanks, rck
