Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6F5B0106DFE9
	for <drbd-dev@lists.linbit.com>; Sun, 31 Jan 2010 16:41:57 +0100 (CET)
Date: Sun, 31 Jan 2010 10:41:35 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Oleg Nesterov <oleg@redhat.com>
Message-ID: <20100131154135.GA1950@localhost.localdomain>
References: <20100121200806.GA29801@shamino.rdu.redhat.com>
	<20100129151024.GA19249@hmsreliant.think-freely.org>
	<20100129151351.GB19249@hmsreliant.think-freely.org>
	<20100131144606.GA13402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100131144606.GA13402@redhat.com>
Cc: jmoskovc@redhat.com, neilb@suse.de, benh@kernel.crashing.org,
	gregkh@suse.de, takedakn@nttdata.co.jp,
	linux-kernel@vger.kernel.org, spock@gentoo.org, mingo@redhat.com,
	viro@zeniv.linux.org.uk, mfasheh@suse.com,
	akpm@linux-foundation.org, t.sailer@alumni.ethz.ch,
	shemminger@linux-foundation.org, menage@google.com,
	abelay@mit.edu, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/2] exec: allow core_pipe recursion check to
 look for a value of 1 rather than 0 (v2)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Jan 31, 2010 at 03:46:06PM +0100, Oleg Nesterov wrote:
> On 01/29, Neil Horman wrote:
> >
> > Add init function to usermodehelper
> >
> > Convert call_usermodehelper_cleanup to usermodehelper_fns and allow it to assign
> > both an init function and a cleanup function.
> 
> Can't apply this patch, I guess -mm tree has other changes which
> this patch depends on. However afaics this series is fine, just
> a couple of nits.
> 
Yeah, this will only apply to latest -mm

> > @@ -154,7 +155,9 @@ struct subprocess_info {
> >  	enum umh_wait wait;
> >  	int retval;
> >  	struct file *stdin;
> > -	void (*cleanup)(char **argv, char **envp);
> > +	int (*init)(void *data);
> > +	void (*cleanup)(char **argv, char **envp, void *data);
> > +	void *data;
> 
> OK, we add *data. But why this patch changes the prototype of ->cleanup() ?
> OTOH, I completely agree, it should be changed, and it should lose the
> ugly argv/envp arguments.
> 
> Since we add subprocess_info->data ptr, I think both ->init and ->cleanup
> funcs should have the single arg, "subprocess_info *info". argv, envp, data
> they all can be accessed via *info.
> 
Yeah, I can do that.

> Also. It is not clear why this patch changes call_usermodehelper_setup()
> to set info->data. Unless the caller uses call_usermodehelper_setinit()
> or call_usermodehelper_setcleanup() info->data is not used. Perhaps
> it is better to have a single helper which takes (init, cleanup, data)
> args.
> 
> What do you think?
> 
Yeah, that seems reasonable, Honestly, I'm a bit confused as to why there are
set* helpers in the first place, we could just eliminate them entirely, since
callers can set all three independently with call_usermodehelper_fns.  Anywho,
I'll clean that up some more.
 
> In any case, I believe you should fix the subjects ;)
> 
Not sure whats wrong with the subjects, although I guess I am doing a good bit
more than just fixing that at this point :).  I'll expand them.

Give me a few days, and I'll repost.
Neil

> Oleg.
> 
> 
