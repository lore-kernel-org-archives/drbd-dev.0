Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 892D7142F2
	for <drbd-dev@lists.linbit.com>; Tue, 27 Jul 2004 10:28:24 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 27 Jul 2004 10:28:23 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200407271028.23677.philipp.reisner@linbit.com>
Subject: [Drbd-dev] 0.7.1 release...
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

Hi,

Ich habe vor gegen ende der Woche 0.7.1 zu taggen. 
 * Damit XFS nun wirklich mit DRBD stable funktioniert
 * Damit ein upgrade Guide 0.6.x -> 0.7.x enthalten ist

sonstige TODOs (soweit ich das bis jetzt sehe):

* Increment the primary-count if someone types in "yes" at the user's
  dialog
* Make sure the timeout-count is increased if the timeout is expired
  at the user's dialog
* Make the ":sendpage fallback/total: %lu/%lu\n" more aggressive towards
  XFS. "drbd0: XFS's erronous IO requests detected. Workaround engaged."
* Some fix to Martin Bene's "Child process does not terminate!" issue in
  drbdadm.

LGE: 
* Hast du noch irgendwelche Dinge die in 0.7.1 rein sollten ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
