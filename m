Return-Path: <roland.kammerer@linbit.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 76A8D105647D
	for <drbd-dev@lists.linbit.com>; Thu,  9 Mar 2017 11:39:57 +0100 (CET)
Received: by mail-wr0-f179.google.com with SMTP id l37so42068756wrc.1
	for <drbd-dev@lists.linbit.com>; Thu, 09 Mar 2017 02:39:57 -0800 (PST)
Received: from localhost (213-47-144-126.static.upcbusiness.at.
	[213.47.144.126]) by smtp.gmail.com with ESMTPSA id
	o15sm7655512wra.61.2017.03.09.02.33.18
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 Mar 2017 02:33:18 -0800 (PST)
Date: Thu, 9 Mar 2017 11:33:17 +0100
From: Roland Kammerer <roland.kammerer@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20170309103317.GC18615@rck.sh>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
	<1488857279-29079-6-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488857279-29079-6-git-send-email-nwang@suse.com>
Subject: Re: [Drbd-dev] [Patch v0 5/8] Use refcount_t 'atomic' type to
 implement structref
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

On Tue, Mar 07, 2017 at 11:27:56AM +0800, Nick Wang wrote:
> diff --git a/drbd/drbd_req.c b/drbd/drbd_req.c
> index d6d9dc1..467549a 100644
> --- a/drbd/drbd_req.c
> +++ b/drbd/drbd_req.c
> @@ -124,7 +124,11 @@ void drbd_queue_peer_ack(struct drbd_resource *resource, struct drbd_request *re
>  		    connection->cstate[NOW] != C_CONNECTED ||
>  		    !(req->rq_state[1 + node_id] & RQ_NET_SENT))
>  			continue;
> +#ifdef COMPAT_HAVE_REFCOUNT_INC
> +		refcount_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
> +#else
>  		atomic_inc(&req->kref.refcount); /* was 0, instead of kref_get() */
> +#endif

We want to avoid #ifdef hell as much as possible in the code itself. In
that case use the new refcount_inc() and if it does not exist, fall back
to atomic_inc() via defining refcount_inc() to atomic_inc.

Regards, rck
