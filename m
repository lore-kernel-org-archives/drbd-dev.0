Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E6F5014311
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 11:42:49 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] gen_counts and primary --human
Date: Wed, 25 Aug 2004 11:42:49 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	</+7SE+vRTb9mi3m45Lh2qDY=lge@web.de>
	<LytGKyglmnZR/Bdz2MpV2To=lge@web.de>
In-Reply-To: <LytGKyglmnZR/Bdz2MpV2To=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251142.49511.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 23 August 2004 16:28, Lars Ellenberg wrote:
> > Yet an other deficiency:
> > we still do not handle the gencounts correctly in this situation:
> >
> >   S --- S
> >   P --- S  drbdsetup primary --human
> >    now, N1 increments its human cnt, N2 only its connection count after
> >    failure of N1, N2 will take over, maybe be primary for a whole week.
> >    then N1 comes back, has the higher human count, and will
> >    either [see above] (if N2 still is Primary)
> >    or wipe out a week worth of changes (if N2 was demoted to Secondary
> >    meanwhile).
> >
> >    Oops :-(
>
> I'd suggest to ignore the --human flag when connected.
> It does not make sense in the connected case.
>

Right. We should fix that rather sooner than later.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
