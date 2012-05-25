Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id C1262100008C
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id B21D41B4354
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:52 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWwvaAw5AWdZ for <drbd-dev@lists.linbit.com>;
	Fri, 25 May 2012 23:14:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 550F81B4315
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:14:52 +0200 (CEST)
Resent-Message-ID: <20120525211451.GU1903@soda.linbit>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id AA4FB1013803
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 22:57:06 +0200 (CEST)
Message-ID: <1337979424.30100.19.camel@joe2Laptop>
From: Joe Perches <joe@perches.com>
To: Kent Overstreet <koverstreet@google.com>
Date: Fri, 25 May 2012 13:57:04 -0700
In-Reply-To: <1337977539-16977-13-git-send-email-koverstreet@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-13-git-send-email-koverstreet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Cc: axboe@kernel.dk, yehuda@hq.newdream.net, dm-devel@redhat.com, neilb@suse.de,
	linux-kernel@vger.kernel.org, tj@kernel.org,
	linux-bcache@vger.kernel.org, mpatocka@redhat.com,
	vgoyal@redhat.com, bharrosh@panasas.com,
	linux-fsdevel@vger.kernel.org, sage@newdream.net, agk@redhat.com,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH v3 12/16] Closures
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, 2012-05-25 at 13:25 -0700, Kent Overstreet wrote:
> Asynchronous refcounty thingies; they embed a refcount and a work
> struct. Extensive documentation follows in include/linux/closure.h
[]
> diff --git a/include/linux/closure.h b/include/linux/closure.h
[]
> +enum closure_type {
> +	TYPE_closure				= 0,

I still think these should be
	CLOSURE_TYPE_closure
etc.

> +#define __CLOSURE_TYPE(cl, _t)						\
> +	  __builtin_types_compatible_p(typeof(cl), struct _t)		\
> +		? TYPE_ ## _t :						\
	CLOSURE_TYPE_##_t

> +#define __closure_type(cl)						\
> +(									\
> +	__CLOSURE_TYPE(cl, closure)					\
> +	__CLOSURE_TYPE(cl, closure_with_waitlist)			\
> +	__CLOSURE_TYPE(cl, closure_with_timer)				\
> +	__CLOSURE_TYPE(cl, closure_with_waitlist_and_timer)		\
> +	invalid_closure_type()						\
> +)

You should still feel dirty about this...

> +#define continue_at(_cl, _fn, _wq, ...)					\
> +do {									\
> +	BUG_ON(!(_cl) || object_is_on_stack(_cl));			\
> +	closure_set_ip(_cl);						\
> +	set_closure_fn(_cl, _fn, _wq);					\
> +	closure_sub(_cl, CLOSURE_RUNNING + 1);				\
> +	return __VA_ARGS__;						\
> +} while (0)

Does this have to be a macro?

> diff --git a/lib/closure.c b/lib/closure.c
[]
> +#define CL_FIELD(type, field)					\
> +	case TYPE_ ## type:					\
> +	return &container_of(cl, struct type, cl)->field
> +
> +static struct closure_waitlist *closure_waitlist(struct closure *cl)
> +{
> +	switch (cl->type) {
> +		CL_FIELD(closure_with_waitlist, wait);
> +		CL_FIELD(closure_with_waitlist_and_timer, wait);
> +	default:
> +		return NULL;
> +	}
> +}

Here:

static struct closure_waitlist *closure_waitlist(struct closure *cl)
{
	switch (cl->type) {
	case CLOSURE_TYPE_closure_with_waitlist:
		return &container_of(cl, struct closure_with_waitlist, cl)->wait;
	case CLOSURE_TYPE_closure_with_waitlist_and_timer:
		return &container_of(cl, struct closure_with_waitlist_and_timer, cl)->wait;
	}

	return NULL;
}


