Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B87AD142F8
	for <drbd-dev@lists.linbit.com>; Wed,  8 Sep 2004 13:21:55 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Any updates on drbd-0.7.x on Linux-2.4.x ??
Date: Wed, 8 Sep 2004 13:21:55 +0200
References: <200409081155.48942.philipp.reisner@linbit.com>
	<20040908105829.GA7506@nudl>
In-Reply-To: <20040908105829.GA7506@nudl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409081321.55125.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 08 September 2004 12:58, Lars Ellenberg wrote:
> On Wed, Sep 08, 2004 at 11:55:48AM +0200, Philipp Reisner wrote:
> > Otherwhise I will make the 0.7.4 release
> > (and reenable the use of sendpage() generally)
>
> we could not get a test run on 2.4 done yet.
> in fact, we did not do _any_ testruns yet. should be able to get this
> going today hopefully, but seemingly one of the test clusters here has
> hardware problems, and the other one does not like us either :(
>
> but I had a look at the code, and I have problems with the way
> page_count works in 2.4.  so I'd say reenable it with 2.6, keep it
> disabled by default for 2.4...
>
> you really want to do 0.7.4. this week?
> then there probably will be a 0.7.5 within the next two weeks.
> does realeasing that fast make so much sense?

* 0.7.4 fixes the >2TB issue.
* 0.7.3 has a annoying bug in the debian/rules file.

What do you think will be on the 0.7.5 release ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
