Return-Path: <lars@linbit.com>
Date: Tue, 7 Sep 2004 11:15:07 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Message-ID: <20040907091507.GA3257@nudl>
References: <20040906135609.GT11820@marowsky-bree.de>
	<20040906145237.GB28956@nudl>
	<200409070957.57371.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409070957.57371.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 07, 2004 at 09:57:57AM +0200, Philipp Reisner wrote:
> On Monday 06 September 2004 16:52, you wrote:
> > waere es sinnvoll sowas zu haben:
> >
> > drbdadm dump_meta_data r0 (oder info oder wie immer wir das nennen wollen)
> >
> > output would be bash sourceable:
> > GEN_COUNT=SOME:LONGER:STRING:WITH:NUMBERS:AND:STUFF
> > LOCAL_STATE={Primary,Secondary}
> > REMOTE_STATE=...
> > CSTATE=...
> > LOCAL_STORAGE=...
> >
> >
> > name space clashes können so gelöst werden:
> > eval `drbdadm info r0 | sed 's/^/DRBD_/'`
> >
> > müsste einmal vernünftig überlegt werden, welche informationen wir
> > exportieren wollen, und wie die variablen genannt werden.
> > wie drbdadm an die info rankommt ist seine sache.
> >
> > deal?
> >
> 
> Of course I am open to this idea.
> 
> Ideas:
>  1) We move the read_gc.pl/write_gc.pl to the user directory. 
>  2) Make them to one C program: drbdmeta
>     -> in the future the module never creates the meta data
>        block. One can use drbdmeta to create, read and 
>        modify the drbdmeta block. drbdmeta refuses to write
>        to it as long as the module is loaded (configured).
>  3) drbdadm is the nice frontend to drbdmeta is it is to
>     drbdsetup.

I don't want to make it easier to write generation counts.
heartbeat-TNG may have use for knowing the current ones, though.

> Currently we have these drbdadm commands that are not displayed
> at the usage output:
> 
>   { "sh-resources",      sh_resources,0                  ,0,0 },
>   { "sh-mod-parms",      sh_mod_parms,0                  ,0,0 },
>   { "sh-dev",            sh_dev,      0                  ,0,1 },
>   { "sh-ll-dev",         sh_ll_dev,   0                  ,0,1 },
>   { "sh-md-dev",         sh_md_dev,   0                  ,0,1 },
>   { "sh-md-idx",         sh_md_idx,   0                  ,0,1 }
> 
> ... and we have state and cstate:
> 
>   { "state",             adm_generic_s,"state"           ,1,1 },
>   { "cstate",            adm_generic_s,"cstate"          ,1,1 },
> 
> with the current interface you would do:
> 
> CSTATE=$(drbdadm cstate r0)
> LOCAL_STATE=$( $DRBDADM state $RES 2> /dev/null )
> LOCAL_STATE=${LOCAL_STATE%/*}
> LOCAL_STORAGE= $(drbdadm sh-ll-dev r0)
> ...
> 
> With the current interface we have a lot of calls to drbdadm, so lets
> have a look at the performance:
> 
> root@bloody:~/drbd07/user# time drbdadm sh-ll-dev r0
> /dev/hdc1
> 
> real    0m0.170s
> user    0m0.059s
> sys     0m0.111s
> 
> ... Quite slow!
> 
> 
> So I disabled "verify_ips()". [ should probabely be really disabled. ]

or only enabled with "verify config" or something like that.

> root@bloody:~/drbd07/user# time ./drbdadm sh-ll-dev r0
> /dev/hdc1
> 
> real    0m0.006s
> user    0m0.001s
> sys     0m0.005s
> 
> ... now a call to drbdadm is as cheap as expected.
> 
> So with continuing the current way of doing things, I would 
> extend the interface in this way:
> 
> drbdadm md-set-gc 1:2:3:4:5:6 r0
> drbdadm md-get-gc 1:2:3:4:5:6 r0
> drbdadm md-get/set-{la-size|consistent|etc...} resources....
> drbdadm md-create r0
> 
> I rather prefer the current way, since it is also language
> agnostic. In perl: $local_storage = `drbdadm sh-ll-dev r0`;
> While the proposed interface is tied to bash.

the point was to have an easy way to _read_ all available information in
a well defined way in one chunk. and having it in k=v form makes it
direktly useable by bash, and easily useable by perl:

  $_=`drbdadm info r0`; %drbdinfo = /^(.*?)=(.*?)$/mg; # :-)

I do NOT want to make it easy to _modify_ on-disk meta data.
if it is too easy (or even documented), people will screw up,
and blame us for it.

	lge
