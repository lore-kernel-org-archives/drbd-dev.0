Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 976F82E3849D
	for <drbd-dev@lists.linbit.com>; Wed,  6 Aug 2008 10:53:08 +0200 (CEST)
Date: Wed, 6 Aug 2008 10:53:08 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
Message-ID: <20080806085308.GB32114@soda.linbit>
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
	<87y73cochw.87wsiwochw@87vdygochw.message.id>
	<200808051335.15444.philipp.reisner@linbit.com>
	<873aljpey0.871w13pey0@87zlnro0dk.message.id>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873aljpey0.871w13pey0@87zlnro0dk.message.id>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Aug 05, 2008 at 07:15:20PM +0200, syrius.ml@no-log.org wrote:
> Philipp Reisner <philipp.reisner@linbit.com> writes:
> 
> > We do not experience any issue with the 500ms in our setups, as are reports
> > about such an issue rather rare. Could you give a more details description
> > about the conditions you trigger can trigger this ?
> 
> I have several drbd devices (4 atm).
> Most of the time it is triggered by heartbeat RA scripts when the
> device are setup one after the other.
> could also happen if i do "echo r1 r2 r3 r4 | xargs -n 1 drbdadm
> primary" for example.
> 
> > I guess we will add an option to drbdsetup then, and have it is setting
> > in the globals section of drbd.conf. 
> 
> sounds good.
> 
> > I do not want to inrecase it for all users, since is seems to affect only
> > a very small part of our user base.

it may well affect all.
sometimes we do something that involves IO from the context of the
cqueue thread. we probably should not.

if I have too few of them (typically depends on number of cores), and
all are busy (for a second or so), any communication attempt with a
500ms timeout will time out while they are still processing the previous
command.

I'd suggest to replace that check function by a simple stat on
/proc/drbd. The netlink path will be exercised by the next command
anyways, with a much larger timeout. The extra call with short timeout
in the beginning was just a convenience to not run into the full timeout
and only then realize that the module is missing.

The only drawback I can see to this aproach is, that if now someone loads
a pre-DRBD-8 module (0.7, 0.6), but uses DRBD-8 userland, the driver
would appear to be loaded, and drbdsetup will then still run into the
full timeout of the respective commands.

yes, stupid things do happen.
but, how much do we care?

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
