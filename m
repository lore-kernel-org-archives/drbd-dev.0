Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B8354142FF
	for <drbd-dev@lists.linbit.com>; Fri, 19 Nov 2004 15:12:46 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
Date: Fri, 19 Nov 2004 15:12:50 +0100
References: <200411152259.28960.philipp.reisner@linbit.com>
	<87llcy0zn8.fsf@wide.bouthors.org>
In-Reply-To: <87llcy0zn8.fsf@wide.bouthors.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411191512.50171.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Friday 19 November 2004 13:52, Cyril Bouthors wrote:
> On 16 Nov 2004, philipp.reisner@public.gmane.org wrote:
> > What exactly should I put into debian/changelog ?
>
> Since DRBD is not a native Debian package (i.e., package which have
> been written especially for Debian), I think the tarball must not
> contain a debian/changelog nor a debian/ directory.
>

It was told me before. But I will continue to maintain it for my
own (possibly other's) convenience. [With 'maintain' I mean to take
the official debian/ directory and to put it intdo DRBD's SVN.]

> FYI, the debian/ tree from upstream is not used for the official
> Debian package.  If you want to help maintaining the Debian package,
> Philipp Hug and I would be glad to welcome you as a co-maintainer.

Philipp Hug has an account for DRBD's SVN and I hope that he still
commits his changes also to DRBD's SVN.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
