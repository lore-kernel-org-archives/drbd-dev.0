Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 02AD41433D
	for <drbd-dev@lists.linbit.com>; Wed, 22 Sep 2004 14:03:04 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] r1550 - trunk
Date: Wed, 22 Sep 2004 14:03:18 +0200
References: <20040921153713.3E1613BE6E@garcon.linbit.com>
	<YscVefD2K3hzkd308QASFow=lge@web.de>
In-Reply-To: <YscVefD2K3hzkd308QASFow=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409221403.18410.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> please name it more agressive. how about:
>  discard-older-transactions
>  discard-younger-transactions
>  discard-less-modified
>  discard-changes-on-NODENAME
>
> > +
> > +  pri-sees-sec-with-higher-gc =
> > +   disconnect     (current behaviour)
> > +   asf-primary    Auto sync from is the current primary
>
> again: discard-...
>

In the first place I thought it is more intuitive to mention the
node which's data become the valid data.
But on the other hand, yes, I will change it to the discard- naming
sheme....

asf-older   => discard-younger-primary
 The thing is there are no older or younger transactions, both nodes
 did transactions, there is one node that has been primary for 
 a longer timer -> discard data on the younger primary.

asl-younger  => discard-older-primary
asf-furthest => discard-less-modified
asf-NODENDE  => discard-NODENEME
 otherwise all should be called discard-changes-on-....
 E.g. discard-chagnes-on-younger-primary, discard-changes-on-less-modified...


> > +   panic          The current primary panics. The node with the
> > +                  higher gc should take over.
>
> we should replace all panic calls with something else,
> because the panic is not guaranteed to work anyways, and
> it is very rude to other resources, too.
>
> maybe rather replace it with some exeption handling scheme which would
> block all further access to the device first, then call some user space
> helper to do problem solving (and that script then can decide to do
> something like halt -nf, shutdown now+60seconds bla ...
>

ACK.

[...]
> > +7 Handle split brain situations; Support IO fencing;
> > +  introduce the "Dead" peer state (o_state)
> > +
> > +  New commands:
> > +    drbdadm peer-dead r0
>
>      peer-is-dead r0

Like that one best.

>    suspend
>    resume

Right. But peer-is-dead is just a fancy name for resume, right.
I do not like to have multiple names for one and the same thing.
So lets keep "resume" and drop "peer-is-dead".

>
> > +    drbdadm [ considered-dead | die | fence | outdate ] r0
> > +      ( What do you like best ? Suggestions ? )
> > +

By now I think "outdate" is the best naming.


[...]
> this will be sorted out in detail once we get to
> implementing it on the drbd and on the crm side...

My plan is to do the thinking before the coding, should save
troubles afterwards.... :)

> > +8 New command drbdmeta
> > +
> > +  We move the read_gc.pl/write_gc.pl to the user directory.
> > +  Make them to one C program: drbdmeta
> > +   -> in the future the module never creates the meta data
> > +      block. One can use drbdmeta to create, read and
> > +      modify the drbdmeta block. drbdmeta refuses to write
> > +      to it as long as the module is loaded (configured).
>
> I think the module still needs to generate the meta data.
> only it no longer does so by itself, it needs to be asked explicitly.
> helps to avoid funny races.
>

[Do we claim the meta data device somehow ?]

> > +  drbdsetup gets the ability to read the gc values while DRBD
> > +  is set up via an ioctl() call. -- drbdmeta refuses to run
> > +  if DRBD is configured.
>
> hm. could, and maybe should, go through the module.
> then it could manipulate GCs on a running drbd, too.

I think that drbdmeta should also work if the module is not 
present at all. -- just like the perl scripts nowadays.

> I can imagine situations where this would be convenient.

Which ?

While beeing able to modify the meta-data offline is 
sometimes usefull, modifing it online is not adviseable,
I think.

> > +  drbdadm is the nice frontend. It alsways uses the right
> > +  backend (drbdmeta or drbdsetup)...
> > +
> > +  drbdadm md-set-gc 1:2:3:4:5:6 r0
> > +  drbdadm md-get-gc r0
> > +  drbdadm md-get/set-{la-size|consistent|etc...} resources....
> > +  drbdadm md-create r0
>
> md-create would ask nasty questions about whether you are really sure
> and so on, and do some plausibility checks first...
> md-set would be undocumented and for wizards only.

ACK.
> > +9 Support shared disk semantics  ( for GFS, OCFS etc... )
> > +plus-banches:
>
> I already commented on these two.
>
>
>  lge
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> http://lists.linbit.com/mailman/listinfo/drbd-dev

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
