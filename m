Return-Path: <lmb@suse.de>
Date: Sat, 25 Sep 2004 11:59:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@linbit.com, linux-ha-dev@lists.linux-ha.org
Subject: Re: [Drbd-dev] Re: [Linux-ha-dev] [RFC] (CRM and) DRBD (0.8) states
	and transistions, recovery strategies
Message-ID: <20040925095924.GE4267@marowsky-bree.de>
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<20040924211133.GC3927@marowsky-bree.de>
	<qEu8Pd/NWgF9/2NlEKWF2r4=lge@web.de>
	<20040925085428.GA4267@marowsky-bree.de>
	<Hk8L7YsCaLPZMUXM+NGHIHM=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Hk8L7YsCaLPZMUXM+NGHIHM=lge@web.de>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-25T11:50:04,
   Lars Ellenberg <Lars.Ellenberg@linbit.com> said:

> well. they are different events, and I must handle both of them.
> there indeed is no benefit to it. but this is not about theoretically
> descibing it, in the end I want to code a state machine from it,
> and know that it is complete.

Ah. Ok. Then we agree.

> appart from the fact that the local storage should never fail,
> and should possibly be some sort of raid itself...

Right! It'd all be best if nothing ever failed! ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

