Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] [RFC] (CRM and) DRBD (0.8) states and transistions,
	recovery strategies
Date: Mon, 27 Sep 2004 16:52:10 +0200
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
In-Reply-To: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409271652.10284.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 24. September 2004 16:29 schrieb Lars Ellenberg:

[...]

>     Currently this covers only the states, and outlines the transitions. It
>     should help to define the actions to be taken on every possible "input"
>     to the DRBD internal "state machine".
>

While reading through this giant e-mail I lost my confidence that it 
could be a good idea to have a "central" state switching function in 
DRBD, but of course I will see what this discussions gives...

We have a huge space of possible cominations of these attributes, but
a lot of those are impossible/invalid... etc. Currently these constraints
are expressed by the code ...

The question is, what is easier to read/understand/code/get right.

[...]
>
>     Allowed node state transition "inputs" or "reactions" are
>
>     *   up or down the node
>
>     *   add/remove the disk (by administrative request or in response to io
>         error)
>
>         if it was the last accessible good data, should this result in
>         suicide, or block all further io, or just fail all further io?
>
>         if this lost the meta-data storage at the same time (meta-data
>         internal), do we handle this differently?

I guess this is a question we can not answer here for all of our users,
some one might want this, the others that... etc.. If it is a question 
you can not answer, it probabely needs to be configurable.

>     *   fail meta-data storage
>
>         should result in suicide.
>
>     *   establish or lose the connection; quit/start retrying to establish
> a connection.
>
>     *   promote to active / demote to non-active
>
>         To promote an unconnected inconsistent non-active node you need
>         brute force. Similar if it thinks it is outdated.
>
>         Promoting an unconnected diskless node is not possible. But those
>         should have been mapped to a "down" node, anyways.
>

Hmmm ? 

Just had a look at what we are currently doing. Probabely we should 
drop the DISKLESS bit and replace this by an enum

dstate: inconsistent, 
        outdated  (known to be outdated -- happens via drbdadm outdate and 
                   in data was consistent negotiation's outcome was this this
                   is old data and sync is Paused),
        consistent (this reflects the meta-data meaning of consistent i.e.
                    might be outdated),
        na (=diskless), 
        uptodate

and display this in /proc/drbd "ld:"

>     *   start/finish synchronization
>
>         One must not request a running and up-to-date active node to become
>         target of synchronization.
>
>     *   block/unblock all io requests
>
>         This is in response to drbdadm suspend/resume, or a result of an
>         "execption handler".
>
>     *   commit suicide
>
>         This is our last resort emergency handler. It should not be
>         implemented as "panic", though currently it is.
>
>     Again, this is important, please double check: Did I miss something?
>

I think everything is there... (and reading it is quite inspiring)

-Philipp
