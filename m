Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1F02A142F3
	for <drbd-dev@lists.linbit.com>; Wed, 25 Aug 2004 15:02:00 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Wed, 25 Aug 2004 15:01:59 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200408251501.59314.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Summary (2nd try) 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

After I realized that we no longer make any node primary automatically :)
Here the suggestion of the new configure option:

after-primary-primary = 
 disconnect	No automatic resynchronisation gets performed. One
		node should drop its net-conf (preferable the
		node that would become sync-target)
		I think this should be default.
 ass-older	Auto sync source is the oder primary (current default i.t.s.)
 ass-younger	Auto sync source is the younger primary
 ass-furthest   Auto sync source is the node that did more modifications
 ass-NODENAME   Auto sync source is the named node 

Falls es schon einen pirmary gibt (also dieses:

      N1    N2
  P --- S   Everything ok.
  P - - S   N1 is failing, but for the moment being just can no
            longer answer the network; but it is still able to update
            drbds generation counts
  ?   - S   Now N1 may be dead, or maybe not
  X   - S   A sane Cluster-mgr makes N2 primary, but stonith N1 first ...
  X   - P   N1 now is really dead.
  S --- P   N1 comes back
  S - : P   oops, N1 has "better" generation counts than N2
            N2 shall become sync target, but since it is
            currently Primary, it will refuse this.
            It goes standalone.

) Dann:

 disconnect   (current behaviour in the situation.)
 ass-*        Auto sync, but the current primary gets sync-source.

What do you think ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
