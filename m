Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 27A86106DCC0
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 0C7B71B435C
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:36 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVlJ0HPT1uxM for <drbd-dev@lists.linbit.com>;
	Wed, 30 May 2012 10:40:35 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id B23E41B435B
	for <drbd-dev@lists.linbit.com>; Wed, 30 May 2012 10:40:35 +0200 (CEST)
Resent-Message-ID: <20120530084035.GC4141@soda.linbit>
Received: from mail-pz0-f54.google.com (mail-pz0-f54.google.com
	[209.85.210.54]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id D6BF41013803
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 23:35:25 +0200 (CEST)
Received: by dadv36 with SMTP id v36so2298140dad.27
	for <drbd-dev@lists.linbit.com>; Fri, 25 May 2012 14:35:23 -0700 (PDT)
Date: Fri, 25 May 2012 14:35:20 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Joe Perches <joe@perches.com>
Message-ID: <20120525213520.GC14196@google.com>
References: <1337977539-16977-1-git-send-email-koverstreet@google.com>
	<1337977539-16977-13-git-send-email-koverstreet@google.com>
	<1337979424.30100.19.camel@joe2Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337979424.30100.19.camel@joe2Laptop>
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

On Fri, May 25, 2012 at 01:57:04PM -0700, Joe Perches wrote:
> On Fri, 2012-05-25 at 13:25 -0700, Kent Overstreet wrote:
> > Asynchronous refcounty thingies; they embed a refcount and a work
> > struct. Extensive documentation follows in include/linux/closure.h
> []
> > diff --git a/include/linux/closure.h b/include/linux/closure.h
> []
> > +enum closure_type {
> > +	TYPE_closure				= 0,
> 
> I still think these should be
> 	CLOSURE_TYPE_closure
> etc.

Oh - yes, definitely.

> > +#define __CLOSURE_TYPE(cl, _t)						\
> > +	  __builtin_types_compatible_p(typeof(cl), struct _t)		\
> > +		? TYPE_ ## _t :						\
> 	CLOSURE_TYPE_##_t
> 
> > +#define __closure_type(cl)						\
> > +(									\
> > +	__CLOSURE_TYPE(cl, closure)					\
> > +	__CLOSURE_TYPE(cl, closure_with_waitlist)			\
> > +	__CLOSURE_TYPE(cl, closure_with_timer)				\
> > +	__CLOSURE_TYPE(cl, closure_with_waitlist_and_timer)		\
> > +	invalid_closure_type()						\
> > +)
> 
> You should still feel dirty about this...

I feel a lot dirtier for implementing dynamic dispatch like this than
the macro tricks. The macro stuff at least is pretty simple stuff that
doesn't affect anything outside the 10 lines of code where it's used.

> > +#define continue_at(_cl, _fn, _wq, ...)					\
> > +do {									\
> > +	BUG_ON(!(_cl) || object_is_on_stack(_cl));			\
> > +	closure_set_ip(_cl);						\
> > +	set_closure_fn(_cl, _fn, _wq);					\
> > +	closure_sub(_cl, CLOSURE_RUNNING + 1);				\
> > +	return __VA_ARGS__;						\
> > +} while (0)
> 
> Does this have to be a macro?

Yes (though I could at least drop the __VA_ARGS__ part, I'm not using it
anymore and it was always a hack).

I explained why in the documentation, but basically the return is there
to enforce correct usage (it can't prevent you from doing dumb things,
but it can keep you from doing dumb things accidentally).

It's not _just_ enforcing correct usage though, it leads to better and
cleaner style. continue_at() is really flow control, so it makes the
code clearer and easier to follow if that's how it's used (by using it
also return).


> > diff --git a/lib/closure.c b/lib/closure.c
> []
> > +#define CL_FIELD(type, field)					\
> > +	case TYPE_ ## type:					\
> > +	return &container_of(cl, struct type, cl)->field
> > +
> > +static struct closure_waitlist *closure_waitlist(struct closure *cl)
> > +{
> > +	switch (cl->type) {
> > +		CL_FIELD(closure_with_waitlist, wait);
> > +		CL_FIELD(closure_with_waitlist_and_timer, wait);
> > +	default:
> > +		return NULL;
> > +	}
> > +}
> 
> Here:
> 
> static struct closure_waitlist *closure_waitlist(struct closure *cl)
> {
> 	switch (cl->type) {
> 	case CLOSURE_TYPE_closure_with_waitlist:
> 		return &container_of(cl, struct closure_with_waitlist, cl)->wait;
> 	case CLOSURE_TYPE_closure_with_waitlist_and_timer:
> 		return &container_of(cl, struct closure_with_waitlist_and_timer, cl)->wait;
> 	}
> 
> 	return NULL;
> }

Alright, if you feel that strongly about it :)
