Return-Path: <lmb@suse.de>
Date: Fri, 24 Sep 2004 17:17:25 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: High-Availability Linux Development List <linux-ha-dev@lists.linux-ha.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Linux-ha-dev] Re: [Drbd-dev] [RFC] Handling of internal
	split-brain in multiple state resources
Message-ID: <20040924151725.GY3927@marowsky-bree.de>
References: <20040910185553.GU7359@marowsky-bree.de>
	<200409201709.36849.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409201709.36849.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-20T17:09:36,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> BTW, from the text I realized that hearbeat will monitor the resource (drbd).
> Probabely with calling the resource script with a new method. Basically
> hearbeat polls DRBD for an change in the connection state.
> 
> Would you like to have an active notification from DRBD ? 

Active notification is of course welcome. The CRM is event-based anyway,
so we could throw the event from drbd into the same machinery; that
would be a welcome addition.

Though not only connection state is interesting, but also the loss of
it's local disk.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

