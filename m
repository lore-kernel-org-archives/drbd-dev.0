Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E69D2D99950
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2006 01:14:34 +0200 (CEST)
Date: Thu, 10 Aug 2006 01:14:34 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Proposed update to packet dumping code
Message-ID: <20060809231434.GF4555@soda.linbit>
References: <342BAC0A5467384983B586A6B0B3767103624D59@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103624D59@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-09 18:50:56 -0400
\ Graham, Simon:
> I'm trying to track down a problem where I really need to get a dump of
> the packets sent back and forth and I also need to be able to control
> the output at run time - the attached is a proposed patch to the
> DUMP_EACH_PACKET code in trunk that does the following:
> 
> 1. I've fixed the code so it compiles and runs and updated it to include
> (some of) the new messages in drbd-8
> 
> 2. When you build with DUMP_EACH_PACKET defined, a module parameter
> dump_packets is added that can be set via sysfs. Values
>    are:
> 
> 	0 - no tracing of packets
> 	1 - summary tracing of key packets - no file/line # and no
> tracing of Ping packets
> 	2 - full tracing - trace includes file/line# and all packets are
> traced
> 	3 - max tracing -- info on set-in-sync and set-out-of-sync calls
> also included (this set-in-sync was in
> 		 the existing code, so I left it there but it's annoying
> in general!)
> 
> 3. I've split the code into an inline that does a quick check to see if
> the tracing is enabled and a global function
>    that does the work.
> 
> At the moment, this is still not on by default but my intention would be
> that you could use a driver with this turned on in production (and
> therefore be able to debug problems in the field).

yes, this would have been usefull at times.  since during normal
operation (no tracing) the perfomance impact would be not noticable,
we probably should do it that way.

> Let me know what you think and if anything else should be done.

nice. in fact somewhere on my todo list there is a
"FIXME: DUMP_EACH_PACKET" ...

I'd like to even be able to "echo $mask > sysfs", to select which
packets to dump. this could be done by reserving the lower values
(using the first few bits) for generic switching, and if you see a
higher number with all lower bits cleared, you'd shift it and interpret
it as a bitmask.  whether thats useful, I don't know...

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
