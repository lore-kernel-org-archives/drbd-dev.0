Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 455D5142F8
	for <drbd-dev@lists.linbit.com>; Wed, 28 Jul 2004 11:49:50 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 28 Jul 2004 11:49:49 +0200
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407281149.49509.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Fwd: [john.cagle@hp.com: FW: device number request for drbd]
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


----------  Forwarded Message  ----------

Subject: [john.cagle@hp.com: FW: device number request for drbd]
Date: Wednesday 28 July 2004 10:06
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: philipp.reisner@linbit.com

Hi,

Sorry for the delay. We are moving to a new lanana maintainer (me).

Regarding your Major number. You will receive block major 147. How do you
 want to minors named? /dev/drbd0, /dev/drbd1, ok?

Thanks,
Torben


-----Original Message-----
From: Philipp Reisner [mailto:philipp.reisner@linbit.com]
Sent: Tuesday, July 13, 2004 5:42 AM
To: device@lanana.org
Subject: device number request for drbd

Hi John,

I would like to register a major number for DRBD. Up to now we
(mis)used 43 (the major number of NBD). We plan to make a new
major release in the next days, so it would be great if we
had our own device number...

Description:
DRBD (Distributed Replicated Block Device) is a block device which is
designed to build high availability clusters. This is done by mirroring
a whole block device via (a dedicated) network. You could see it as a
network raid-1.

Find more at http://www.drbd.org

Thanks a lot,
  Philipp
--

: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

----- End forwarded message -----

-------------------------------------------------------

-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
