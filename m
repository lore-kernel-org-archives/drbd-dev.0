Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3786A142FF
	for <drbd-dev@lists.linbit.com>; Wed, 29 Sep 2004 14:58:11 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] (CRM and) DRBD (0.8) states and transistions,
	recovery strategies
Date: Wed, 29 Sep 2004 14:58:47 +0200
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<200409271652.10284.philipp.reisner@linbit.com>
In-Reply-To: <200409271652.10284.philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HGrWBfSIi44Kt6r"
Message-Id: <200409291458.47753.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_HGrWBfSIi44Kt6r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

> [...]
> >     Currently this covers only the states, and outlines the transitions.
> > It should help to define the actions to be taken on every possible
> > "input" to the DRBD internal "state machine".
>
> While reading through this giant e-mail I lost my confidence that it
> could be a good idea to have a "central" state switching function in
> DRBD, but of course I will see what this discussions gives...

Thought about this a bit more... and came to the conclusion that it 
would be a good idea. What do you think of this skeleton -
pseude code (it compiles actually).

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_HGrWBfSIi44Kt6r
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="new_st.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="new_st.c"

typedef struct {
	unsigned role    : 2 ;   // 3   primary/secondary/unknown
	unsigned peer    : 2 ;   // 3   primary/secondary/unknown
	unsigned conn    : 5 ;   // 17  cstates
	unsigned disk    : 3 ;   // 5   from Diskless to UpToDate
	unsigned multi_p : 1 ;   // 2   multiple primaries alloes.
} drbd_state_t;

typedef enum {
	Unconfigured,
	StandAlone,
	Unconnected,
	Timeout,
	BrokenPipe,
	NetworkFailure,
	WFConnection,
	WFReportParams, // we have a socket
	Connected,      // we have introduced each other
	SkippedSyncS,   // we should have synced, but user said no
	SkippedSyncT,
	WFBitMapS,
	WFBitMapT,
	SyncSource,     // The distance between original state and pause
	SyncTarget,     // state must be the same for source and target. (+2)
	PausedSyncS,    // see _drbd_rs_resume() and _drbd_rs_pause()
	PausedSyncT,    // is sync target, but higher priority groups first
} drbd_conns_t;

typedef enum {
	Diskless,
	Failed,         // Moves on to Diskless as soon as we reported it ot the peer
	Inconsistent,
	Outdated,
	Consistent,     // Might be outdated, might be UpTpDate ...
	UpToDate,
} drbd_disks_t;

typedef enum {
	Unknown=0,
	Primary=1,     // role
	Secondary=2,   // role
} drbd_role_t;


drbd_state_t st;  // here for mdev->state;

void lock(){}
void unlock(){}

static int state_change(drbd_state_t ns, int hard)
{
	int rv;

	lock();

	if( ns.role == st.role &&
	    ns.peer == st.peer &&
	    ns.conn == st.conn &&
	    ns.disk == st.disk &&
	    ns.multi_p == st.multi_p ) { 
		rv = 1; 
		goto out; 
	}

	if(!hard) {

		// pre-state-change checks
		if(!ns.multi_p && 
		   ns.role == Primary && 
		   ns.peer == Primary) {
			rv = 0;
			goto out;
		}

		// ...

	}

	// State sanitising
	if ( ns.conn < Connected ) ns.peer = Unknown;

	st = ns;

	// post-state-change actions...
	if( ns.conn < Connected && 
	    ns.disk <= Inconsistent && 
	    ns.role == Primary ) {
		panic(); // Just for illustration
	}
	// ...

	// Probabely it also makes sense to run a dynamic list of 
	// post-state-change-callbacks sitting on a post-state-change-hook.
	//
	// Could use this to implement the sync groupes more sanely.
	// Could also replace the cstate_wait

	rv = 1;
 out:
	unlock();
	return rv;
}


int set_cstate(drbd_conns_t new, int hard)
{
	drbd_state_t ns = st;
	ns.conn = new;

	return state_change(ns,hard);
}

int set_dstate(drbd_disks_t new, int hard)
{
	drbd_state_t ns = st;
	ns.disk = new;

	return state_change(ns,hard);
}

int set_rstate(drbd_role_t new, int hard)
{
	drbd_state_t ns = st;
	ns.role = new;

	return state_change(ns,hard);
}

int set_pstate(drbd_role_t new, int hard)
{
	drbd_state_t ns = st;
	ns.peer = new;

	return state_change(ns,hard);
}

panic()
{ 
	printf("PANIC\n");
}

main()
{
	st = (drbd_state_t){ Secondary,Unknown,Unconfigured,UpToDate,1 };

	set_cstate(Connected,0);
	set_pstate(Primary,0);
	set_rstate(Primary,0); // This one fails...
	set_cstate(WFConnection,0);
	set_rstate(Primary,0);
	set_dstate(Diskless,1); // causes panic...
}

--Boundary-00=_HGrWBfSIi44Kt6r--
