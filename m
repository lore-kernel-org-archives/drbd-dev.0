Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B7B01142F8
	for <drbd-dev@lists.linbit.com>; Wed,  8 Sep 2004 13:33:36 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Date: Wed, 8 Sep 2004 13:33:35 +0200
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071447.45785.philipp.reisner@linbit.com>
	<20040908112001.GD20844@marowsky-bree.de>
In-Reply-To: <20040908112001.GD20844@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409081333.35966.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 08 September 2004 13:20, Lars Marowsky-Bree wrote:
> On 2004-09-07T14:47:45,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > No. It would be better to have a "drbdadm fence r0" operation on N2!
> > The "drbdadm fence r0" command would only set the "Outdated" flag.
>
> Well, it's automatically supposed to assume it's outdated when it
> crashes in S-P mode.
>
> When the secondary loses connection to the primary, a mark-peer-dead
> would prevent that flag from being set.
>
> So, why an explicit drbdadm fence operation? I'm missing what that would
> catch.
>

Here is the text you did not quote:

The big advantage over stopping DRBD on N2 is that in case the network
recoveres N2 will be resynced to up-to-date automatically.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
