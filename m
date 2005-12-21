Return-Path: <Lars.Ellenberg@linbit.com>
Date: Wed, 21 Dec 2005 09:56:24 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, drbd-dev@linbit.com
Subject: Re: [Drbd-dev] Problem with DRBD0.7 on Debian Sarge.
Message-ID: <20051221085624.GB9127@soda.linbit>
References: <43A819F6.3000505@nask.pl> <20051220154331.GC5803@soda.linbit>
	<43A90E1B.1030204@nask.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A90E1B.1030204@nask.pl>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-12-21 09:11:07 +0100
\ Szymon Madej:
> Thanks for fast answer.
> 
> >>kernel: drbd0: Resync done (total 1 sec; paused 0 sec; 0 K/sec)
> >>kernel: drbd1: sock_recvmsg returned -14
> >>kernel: drbd1: drbd1_receiver [699]: cstate SyncTarget --> BrokenPipe
> >>kernel: drbd1: short read receiving data block: read -14 expected 4096
> >>kernel: drbd1: error receiving RSDataReply, l: 4112!
> >>    
> >>
> >
> >you probably hit the bug which was fixed in 0.7.12:
> > * Fixed a connection flip-flop bug when the two peers used different
> >    user provided sizes.
> >
> >to verify this, first, do "drbdadm disconnect <bad_resource>".
> >then "drbdsetup /dev/drbdX show", as well as "cat /proc/partitions",
> >on both nodes.  compare the results.
> >
> >  
> >
> 
> And this is the second strange thing. The device sizes are identical on
> both nodes:
> primary_node# cat /proc/partitions
> ...
>    8     8   12048718 sda8
>    8     9   12851968 sda9
>    8    10    1004031 sda10
>  147     0   11917644 drbd0
>  147     1   12720896 drbd1
> 
> secondary_node# cat /proc/partitions
> ...
>    8     8   12048718 sda8
>    8     9   12851968 sda9
>    8    10    1004031 sda10
>  147     0   11917644 drbd0
>  147     1   12720896 drbd1
> 
> where drbd0 is built over sda8, drbd1 is built over sda9, sda10 is swap
> and sda1-7 are system partitions (/ /usr /home etc.). Is there any
> chance that this error could really happen?

Then maybe you hit something else.  Not obvious from the logs, though,
and I am not aware of anything else with these symptoms.

> And another thing, when secondary went into infinite loop trying to get
> drbd1 in sync (every try ended with NetworkError and BrokenPipe) the
> drbd1 mounted on primary as /data hanged on listing with "ls -la". The
> fast and brutal solution was to disconnect both machines cross link on
> eth1 (used by DRBD) and reboot both nodes, and then reconnect them...
> but this is not a good  method to get HA cluster back to action, isn't
> it? :-)

drbdadm disconnect rX ; drbdadm connect rX
should have had the same effect.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
