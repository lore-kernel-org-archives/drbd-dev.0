Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 89429142F2
	for <drbd-dev@lists.linbit.com>; Fri, 30 Jul 2004 13:12:44 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 30 Jul 2004 13:12:43 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407301312.43896.philipp.reisner@linbit.com>
Subject: [Drbd-dev] changelog for 0.7.1
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

Everything there ?

0.7.1 (api:75/proto:74)
-----
  *) Upgrade instructions for 0.6.x -> 0.7.0 and 0.7.0 -> 0.7.1
  *) Workaround for XFS' IO requests with page count of zero.
  *) Handle the human and the timeout count correctly in the new init script.
  *) The implementation of the incon-degr-cmd was missing, added.
  *) Longer timeouts in drbdadm for drbdsetup commands witch operate on 
     meta data.
  *) New major number 147 (officially registered at lanana.org).
  *) Added a missing w_resume_next_wg() in case we stop syncing because
     of connection loss.
  *) Fixed a Linux-2.2-ismus in recieve_data_tail(). Should considerably
     speed up protocols A and B.
  *) Some work on vendor kernel compatibility
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
