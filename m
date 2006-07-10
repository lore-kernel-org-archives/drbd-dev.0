Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E80992CDC28E
	for <drbd-dev@lists.linbit.com>; Mon, 10 Jul 2006 17:30:33 +0200 (CEST)
Date: Mon, 10 Jul 2006 17:30:35 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Minor fix to DRBD install target...
Message-ID: <20060710153035.GA5354@soda.linbit>
References: <342BAC0A5467384983B586A6B0B37671031FB6F7@EXNA.corp.stratus.com>
	<200607071133.53277.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607071133.53277.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-07-07 11:33:53 +0200
\ Philipp Reisner:
> Lars is the Makefile guru here, I leave these patches for him ...
> [ He is on Monday in the office again. ]

since we only target 2.6. with drbd 8, we can "hardcode" modsub dir.
no one seems to use lib/<ver>/block anymore anywhere.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
