Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1E063142F8
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 14:08:01 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Wed, 28 Jul 2004 14:08:00 +0200
References: <20040728080645.GB7918@tmathiasen> <200407281210.14894.philipp.reisner@linbit.com> <N0M0aajdbaoiib5RP3b+bp4=lge@web.de>
In-Reply-To: <N0M0aajdbaoiib5RP3b+bp4=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407281408.00730.philipp.reisner@linbit.com>
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

On Wednesday 28 July 2004 12:58, Lars Ellenberg wrote:
> / 2004-07-28 12:10:14 +0200
>
> \ Philipp Reisner:
> > On Wednesday 28 July 2004 10:06, Torben Mathiasen wrote:
> > > Hi,
> > >
> > > Sorry for the delay. We are moving to a new lanana maintainer (me).
> > >
> > > Regarding your Major number. You will receive block major 147. How do
> > > you want to minors named? /dev/drbd0, /dev/drbd1, ok?
> >
> > /dev/drbd0, /dev/drbd1... are fine
>
> great.
>
> so, do we include that right away?
> i.e. remove CONFIG_DRBD_MAJOR and module param major_nr again,
> and make it fixed on 147 ?
>
> or just "default" to 147 for now?
>

Yes I think so. The users should move to 147 with 0.7.1. 
Do you like to do the removal of module param ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
