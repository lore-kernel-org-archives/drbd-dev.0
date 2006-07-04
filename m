Return-Path: <Lars.Ellenberg@linbit.com>
Date: Tue, 4 Jul 2006 17:23:10 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-user] drbd_panic() in drbd_receiver.c
Message-ID: <20060704152310.GH4114@soda.linbit>
References: <342BAC0A5467384983B586A6B0B37671031FB378@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671031FB378@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-07-04 11:01:32 -0400
\ Graham, Simon:
> Thanks -- I'm actually starting with drbd 7 just because it's _much_
> easier for me to test (we have a complete build/install/test
> infrastructure currently based on using 0.7) however I will push the
> changes into the head of the trunk as soon as I can.
> 
> FWIW, I have the set-state, NegDReply and NegDSReply stuff coded and
> running; I'm using a known bad disk and no panics so far!

great, send over a svn diff...

> -- the only
> issue I have now is that I think I need to kick the resync processing
> when a NegDSReply is received -- /proc/drbd always shows the resync as
> 100% and stalled;

there are several internal dependencies and state changes that need to
be adjusted...

> BTW: do you have any suggestions for handling the bitmap and meta-data
> write failures?

difficult. we probably need to have several "drbd super blocks" in
drbd8, so we at least have a much higher chance to get important flags
on stable storage _somewhere_. I guess we don't want to have several
bitmaps, but some means to store the "meta data is not reliable anymore"
flag in several places. updates to these blocks have to be
transactional. this is not yet done, but it is on the todo list...


> Also - let me know if you think you would incorporate these changes into
> the 0.7 branch

unlikely. not impossible, though.

> - if so, I'll send patches (oh and let me know what the
> 'approved' mechanism for sending patches is please).

svn diff

cheers,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
