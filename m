Return-Path: <lars@linbit.com>
Date: Wed, 8 Sep 2004 13:42:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Any updates on drbd-0.7.x on Linux-2.4.x ??
Message-ID: <20040908114209.GB10017@nudl>
References: <200409081155.48942.philipp.reisner@linbit.com>
	<20040908105829.GA7506@nudl>
	<200409081321.55125.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081321.55125.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Sep 08, 2004 at 01:21:55PM +0200, Philipp Reisner wrote:
> On Wednesday 08 September 2004 12:58, Lars Ellenberg wrote:
> > On Wed, Sep 08, 2004 at 11:55:48AM +0200, Philipp Reisner wrote:
> > > Otherwhise I will make the 0.7.4 release
> > > (and reenable the use of sendpage() generally)


  BTW: please only enable it again after you at least did some
       successfull full test runs on bloody&mary,
       in particular T-007.sh

> > we could not get a test run on 2.4 done yet.
> > in fact, we did not do _any_ testruns yet. should be able to get this
> > going today hopefully, but seemingly one of the test clusters here has
> > hardware problems, and the other one does not like us either :(
> >
> > but I had a look at the code, and I have problems with the way
> > page_count works in 2.4.  so I'd say reenable it with 2.6, keep it
> > disabled by default for 2.4...
> >
> > you really want to do 0.7.4. this week?
> > then there probably will be a 0.7.5 within the next two weeks.
> > does realeasing that fast make so much sense?
> 
> * 0.7.4 fixes the >2TB issue.
> * 0.7.3 has a annoying bug in the debian/rules file.
> 
> What do you think will be on the 0.7.5 release ?

currently pending: some modified ioctls for better heartbeat integration
its a minor code change, but it will break API again.
and we should do global cleanup over {user,drbd}/*.[ch] ...

so ok, lets do a test run on blodymary,
release 0.7.4, go sailing, give me some five days of hacking, and
release 0.7.5 then.

if that is ok, then I'd say we fork the 0.7 branch, and continue with
0.8 cleanup and features in the trunk.

	oki?
