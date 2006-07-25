Return-Path: <Lars.Ellenberg@linbit.com>
Date: Tue, 25 Jul 2006 23:49:24 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Milind Dumbare <milind.dumbare@gmail.com>
Subject: Re: [Drbd-dev] Bug?
Message-ID: <20060725214924.GC4633@soda.linbit>
References: <44C4E271.3080607@gmail.com> <20060725015703.GG4596@soda.linbit>
	<44C5E049.1030606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C5E049.1030606@gmail.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-07-25 14:41:37 +0530
\ Milind Dumbare:
> Where can we access SVN from? Do everybody has access to it? What do I
> have to do if I want to have access if its resticted?

the first hit in google "drbd svn access" is
http://www.drbd.org/latest.html and explains it.

svn co http://svn.drbd.org/drbd/trunk/ drbd-latest
(which may well be in a state that does not even work at all.
 though we try to avoid non-working commits)

thanks,

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
