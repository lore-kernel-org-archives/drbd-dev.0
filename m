Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 84DE4142FA
	for <drbd-dev@lists.linbit.com>; Fri,  6 Aug 2004 14:41:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 6 Aug 2004 14:41:05 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408061441.05865.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Geht in den =?iso-8859-1?q?n=E4chsten_Minuten?= raus...
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

0.7.2 (api:75/proto:74)
-----
  *) Propper handling of backing storage devices that occasionally fail 
     READA (=read ahead) requests. (E.g. LVM)
  *) DRBD now fails READA requests itself, if a resynchronisation is running
     and it would need to fetch the block from its peer.
  *) "drbdadm adjust" had a race, which caused random errors. ( Missing
     waitpid() ). Fixed now.
  *) Popper substrace SyncPause times from the syncer performance numbers.
  *) Fix to the syncer progress bar in /proc/drbd.
  *) Fix to debian build rules.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
