Return-Path: <lars@linbit.com>
Date: Wed, 8 Sep 2004 12:58:29 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Any updates on drbd-0.7.x on Linux-2.4.x ??
Message-ID: <20040908105829.GA7506@nudl>
References: <200409081155.48942.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081155.48942.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 08, 2004 at 11:55:48AM +0200, Philipp Reisner wrote:
> Otherwhise I will make the 0.7.4 release 
> (and reenable the use of sendpage() generally)

we could not get a test run on 2.4 done yet.
in fact, we did not do _any_ testruns yet. should be able to get this
going today hopefully, but seemingly one of the test clusters here has
hardware problems, and the other one does not like us either :(

but I had a look at the code, and I have problems with the way
page_count works in 2.4.  so I'd say reenable it with 2.6, keep it
disabled by default for 2.4...

you really want to do 0.7.4. this week?
then there probably will be a 0.7.5 within the next two weeks.
does realeasing that fast make so much sense?

	lge
