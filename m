Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 24B32142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 11:45:51 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Date: Tue, 7 Sep 2004 11:45:50 +0200
References: <20040906135609.GT11820@marowsky-bree.de>
	<200409070957.57371.philipp.reisner@linbit.com>
	<20040907091507.GA3257@nudl>
In-Reply-To: <20040907091507.GA3257@nudl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409071145.50689.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > > waere es sinnvoll sowas zu haben:
> > >
> > > drbdadm dump_meta_data r0 (oder info oder wie immer wir das nennen
> > > wollen)
> > >
> > > output would be bash sourceable:
> > > GEN_COUNT=SOME:LONGER:STRING:WITH:NUMBERS:AND:STUFF
[...]
> > Ideas:
> >  1) We move the read_gc.pl/write_gc.pl to the user directory.
> >  2) Make them to one C program: drbdmeta
> >     -> in the future the module never creates the meta data
> >        block. One can use drbdmeta to create, read and
> >        modify the drbdmeta block. drbdmeta refuses to write
> >        to it as long as the module is loaded (configured).
> >  3) drbdadm is the nice frontend to drbdmeta is it is to
> >     drbdsetup.
[...]
> > So with continuing the current way of doing things, I would
> > extend the interface in this way:
> >
> > drbdadm md-set-gc 1:2:3:4:5:6 r0
> > drbdadm md-get-gc 1:2:3:4:5:6 r0
> > drbdadm md-get/set-{la-size|consistent|etc...} resources....
> > drbdadm md-create r0
[...]
> I do NOT want to make it easy to _modify_ on-disk meta data.
> if it is too easy (or even documented), people will screw up,
> and blame us for it.
>

Right! All (at least most) of the "set" methods must be undocumented. 
(And not visible in the usage)

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
