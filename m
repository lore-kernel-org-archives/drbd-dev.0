Return-Path: <lmb@suse.de>
Date: Wed, 28 Jul 2004 16:12:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Message-ID: <20040728141220.GV26564@marowsky-bree.de>
References: <20040728080645.GB7918@tmathiasen> <200407281210.14894.philipp.reisner@linbit.com> <N0M0aajdbaoiib5RP3b+bp4=lge@web.de> <200407281408.00730.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407281408.00730.philipp.reisner@linbit.com>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

On 2004-07-28T14:08:00,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> > or just "default" to 147 for now?
> >
> Yes I think so. The users should move to 147 with 0.7.1. 
> Do you like to do the removal of module param ?

You want to move the _device major_ within a stable series?!? I can see
the next local patch for SUSE coming right up ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

