Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F28EE1430D
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 12:07:20 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 25 Aug 2004 12:07:20 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251207.20479.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Summary (=Idems for 0.8 Roadmap)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

New configuration options:

  primary-after-sb  (SB = splitbrain) = 
   older		The node that was primary before split brain (current behaviour)
   younger		The node that became primary during split brain 
   most-mod		The node that modified more of it's data during the SB.
   wait			None, wait for operator's decission. 
   node-"nodename"	The node prefered by the user.[suggested by Helmut]

  wrong-gencnt (secondary-with-higher-genctn) =
   refuse		(Current behaviour) I think the secondary should drop its net-conf.
   update-data		Make the joining node sync-target.

  secondary-after-sb = 
   keep-data		The secondray drops its net-config.
   update-data		Make the looser sync-target (Current behaviour)

What do you think ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
