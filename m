Return-Path: <lars.ellenberg@linbit.com>
Received: from racke.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8692F2E0BCF8
	for <drbd-dev@lists.linbit.com>; Mon, 10 Dec 2007 09:56:13 +0100 (CET)
Date: Mon, 10 Dec 2007 17:56:19 +0900
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Proposed fix to 8.0.x to ALWAYS schedule
	afterstate processing
Message-ID: <20071210085619.GB5055@racke.local>
References: <342BAC0A5467384983B586A6B0B376710761317C@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B376710761317C@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Dec 09, 2007 at 09:05:10PM -0500, Graham, Simon wrote:
> > As you may recall, I ran into a problem recently with some state
> > changes
> > being delivered via netlink out of order because some state changes do
> > not get their after-state-change processing deferred to the worker
> > thread - this is a big problem if you have code trying to track the
> > state changes via the netlink mechanism. The suggested solution was to
> > make the change to schedule ALL after state change processing to the
> > worker thread and the attached patch does this, including the
> > following:
> 
> We have found one issue with this patch -- we are now seeing occasional
> messages:
> 
> BUG! md_sync_timer expired! Worker calls drbd_md_sync()

the "BUG!" already got remove out of that message, it is no bug,
but only some sloppy timing of certain things on our part.

> I _think_ this is because the meta data can be marked dirty in the after
> state change processing and we now have some situations where this
> happens after the code runs that writes the meta data -- I'm not sure
> how terrible it is, but I think we should move the code that marks the
> meta data dirty into _drbd_set_state() so it happens inline -- I don't
> see any reason why it has to be done in the worker thread... what do you
> think?

my design proposal was to set the meta-data dirty flag _implicitly_,
once something is changed that should be recorded on disk.  this
"dirtying" would also schedule the timer to alert us of code pathes that
take too long to actually get these changes on disk.  unfortunately we
never got around to implementing the "implicit" part of it.

yes, this "dirtying" should happen as early as possible.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
