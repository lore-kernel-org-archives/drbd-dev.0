Return-Path: <chris@prolocation.net>
Received: from smtpq-133-118.prolocation.net (smtpq-133-118.prolocation.net
	[94.228.133.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 28BDA10556A0
	for <drbd-dev@lists.linbit.com>; Mon, 29 Jun 2015 14:25:06 +0200 (CEST)
Received: from static-38-195-78-212.thenetworkfactory.nl ([212.78.195.38]
	helo=[192.168.2.100])
	by relay40.prolocation.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76) (envelope-from <chris@prolocation.net>)
	id 1Z9Y0m-0003Sk-Lt
	for drbd-dev@lists.linbit.com; Mon, 29 Jun 2015 14:18:09 +0200
From: Christiaan den Besten <chris@prolocation.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <B775D229-620D-4FDE-B041-08E86699F1BB@prolocation.net>
Date: Mon, 29 Jun 2015 14:18:08 +0200
To: drbd-dev@lists.linbit.com
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: [Drbd-dev] Recover node after hard-crash (drbd9)
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi !

I just started testing the (official) drbd9 modules and tools on thee =
CentOS 7 VMx (running on Xen Hypervisor) in PV mode.

My DRBD =E2=80=98cluster=E2=80=99 has 3 nodes :

cluster1-a.storage.as41887.net
cluster1-b.storage.as41887.net
cluster1-c.storage.as41887.net

No actual Cluster software (pacemaker) has been installed just yet. =
Trying to get the hand of =E2=80=98drbdmanage=E2=80=99 and do some =
testing on the recoverability of resources after various scenario=E2=80=99=
s.

Scenario that I can=E2=80=99t seem to =E2=80=98fix=E2=80=99 (or am doing =
wrong =E2=80=A6 )

* Create a resource/volume through drbdmanage (puts it on node-b and =
node-c)
* Remove data from node-c and assign node-a as a secondary data node
* Make node-c a Diskless client node, create a filesystem on the =
drbd-volume and mount it

Then to see how we can can recover from a hard error I started a fio =
disk-benchmark on node-c and few seconds later kill the node-a by =
destroying the VM. All keeps running as expected, but I can=E2=80=99t =
seem to get node-a back into normal shape without having to remove te =
Primary state from node-c.

I followed to following steps, please advise where I went wrong :

IPv7:~ chris$ cat /tmp/drbd-replay.txt=20

[root@cluster1-a ~]# drbdmanage new-volume testvm_prolocation_net 10GB =
--deploy 2
[root@cluster1-a ~]# drbdmanage nodes
=
+-------------------------------------------------------------------------=
-----------------------------------+
| Name                           | Pool Size | Pool Free |               =
                            | State |
=
+-------------------------------------------------------------------------=
-----------------------------------+
| cluster1-a.storage.as41887.net |    204796 |    204792 |               =
                            |    ok |
| cluster1-b.storage.as41887.net |    204796 |    195252 |               =
                            |    ok |
| cluster1-c.storage.as41887.net |    204796 |    195252 |               =
                            |    ok |
=
+-------------------------------------------------------------------------=
-----------------------------------+

[root@cluster1-a ~]# drbdmanage unassign testvm_prolocation_net =
cluster1-c.storage.as41887.net
[root@cluster1-a ~]# drbdmanage assign testvm_prolocation_net =
cluster1-a.storage.as41887.net
[root@cluster1-a ~]# drbdmanage assign --client testvm_prolocation_net =
cluster1-c.storage.as41887.net

[root@cluster1-a ~]# drbdmanage nodes
=
+-------------------------------------------------------------------------=
-----------------------------------+
| Name                           | Pool Size | Pool Free |               =
                            | State |
=
+-------------------------------------------------------------------------=
-----------------------------------+
| cluster1-a.storage.as41887.net |    204796 |    195252 |               =
                            |    ok |
| cluster1-b.storage.as41887.net |    204796 |    195252 |               =
                            |    ok |
| cluster1-c.storage.as41887.net |    204796 |    204792 |               =
                            |    ok |
=
+-------------------------------------------------------------------------=
-----------------------------------+

Affer a few minutes (node-a needs to sync data from node-b) :

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:UpToDate
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate
  cluster1-c.storage.as41887.net role:Secondary
    peer-disk:Diskless

[root@cluster1-c ~]# mkfs.ext4 /dev/drbd10=20
[root@cluster1-c ~]# mount /dev/drbd10 /mnt

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:UpToDate
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate
  cluster1-c.storage.as41887.net role:Primary
    peer-disk:Diskless

[root@cluster1-c mnt]# fio =
/usr/share/doc/fio-2.2.8/examples/iometer-file-access-server.fio

To fake a nice hard crash of one of the data-nodes : xm destroy =
cluster1-a.storage.as41887.net

Before booting cluster1-a :

[root@cluster1-c mnt]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Primary
  disk:Diskless
  cluster1-a.storage.as41887.net connection:Connecting
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate

After booting cluster1-a, now the fun starts ;)

[root@cluster1-c mnt]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Primary
  disk:Diskless
  cluster1-a.storage.as41887.net connection:StandAlone
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:Outdated
  cluster1-b.storage.as41887.net connection:StandAlone
  cluster1-c.storage.as41887.net connection:Connecting

To resolve our 'split brain' I discard the data on node-a

[root@cluster1-a ~]# drbdadm --discard-my-data connect =
testvm_prolocation_net

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:Outdated
  cluster1-b.storage.as41887.net connection:Connecting
  cluster1-c.storage.as41887.net connection:Connecting

[root@cluster1-b ~]# drbdadm connect testvm_prolocation_net

Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Handshake successful: Agreed network =
protocol version 110
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Agreed to support TRIM on protocol level
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Peer authenticated using 20 bytes HMAC
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Starting ack_recv thread (from =
drbd_r_testvm_p [2297])
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Preparing remote state change 2288137045 =
(primary_nodes=3D0, weak_nodes=3D0)
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Committing remote state change =
2288137045
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: conn( Connecting -> Connected ) peer( =
Unknown -> Secondary )
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: drbd_sync_handshake:
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: self =
BF8F65EBAABAF138:0000000000000000:0000000000000000:0000000000000000 =
bits:0 flags:0
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: peer =
374B6E4C8ECEB4F4:2CA8DD9FBE1E313E:0000000000000000:0000000000000000 =
bits:225445 flags:100
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: uuid_compare()=3D-100 by rule 100
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
initial-split-brain
Jun 29 13:47:52 cluster1-a drbdadm[2320]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
initial-split-brain exit code 0 (0x0)
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10: =
Split-Brain detected, manually solved. Sync from peer node
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: pdsk( DUnknown -> UpToDate ) repl( Off =
-> WFBitMapT )
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: receive bitmap stats [Bytes(packets)]: =
plain 0(0), RLE 82229(21), total 82229; compression: 73.1%
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: send bitmap stats [Bytes(packets)]: =
plain 0(0), RLE 82229(21), total 82229; compression: 73.1%
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
before-resync-target
Jun 29 13:47:52 cluster1-a drbdadm[2322]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
before-resync-target exit code 0 (0x0)
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10: =
disk( Outdated -> Inconsistent )
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: repl( WFBitMapT -> SyncTarget )
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-c.storage.as41887.net: resync-susp( no -> connection dependency =
)
Jun 29 13:47:52 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: Began resync as SyncTarget (will sync =
901780 KB [225445 bits set]).

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:Inconsistent
  cluster1-b.storage.as41887.net role:Secondary
    replication:SyncTarget peer-disk:UpToDate done:91.61
  cluster1-c.storage.as41887.net connection:Connecting

end up in ... :

Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: Resync done (total 56 sec; paused 0 sec; =
16100 K/sec)
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: Peer was unstable during resync
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: updated UUIDs =
BF8F65EBAABAF138:0000000000000000:0000000000000000:0000000000000000
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: repl( SyncTarget -> Established )
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-c.storage.as41887.net: resync-susp( connection dependency -> no =
)
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
after-resync-target
Jun 29 13:48:48 cluster1-a drbdadm[2393]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:48:48 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
after-resync-target exit code 0 (0x0)

[root@cluster1-a ~]# drbdadm status | grep 'testvm_prolocation_net' -A 6
testvm_prolocation_net role:Secondary
  disk:Inconsistent
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate
  cluster1-c.storage.as41887.net connection:Connecting

To get it going I need to unmount the mountpoint on the Diskless DRBD =
client node-c.

[root@cluster1-c ~]# umount /mnt

[root@cluster1-c ~]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Secondary
  disk:Diskless
  cluster1-a.storage.as41887.net connection:StandAlone
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate

[root@cluster1-a ~]# drbdadm disconnect testvm_prolocation_net

[root@cluster1-b ~]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Secondary
  disk:UpToDate
  cluster1-a.storage.as41887.net connection:Connecting
  cluster1-c.storage.as41887.net role:Secondary
    peer-disk:Diskless

[root@cluster1-a ~]# drbdadm --discard-my-data connect =
testvm_prolocation_net

Jun 29 13:54:37 cluster1-a kernel: drbd testvm_prolocation_net =
tcp:cluster1-c.storage.as41887.net: Closing unexpected connection from =
94.228.142.34 to port 7700
Jun 29 13:54:44 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: conn( StandAlone -> Unconnected )
Jun 29 13:54:44 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Starting receiver thread (from =
drbd_w_testvm_p [1330])
Jun 29 13:54:44 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: conn( Unconnected -> Connecting )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Handshake successful: Agreed network =
protocol version 110
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Agreed to support TRIM on protocol level
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Peer authenticated using 20 bytes HMAC
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Starting ack_recv thread (from =
drbd_r_testvm_p [2481])
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Preparing remote state change 439073605 =
(primary_nodes=3D0, weak_nodes=3D0)
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: Committing remote state change 439073605
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net =
cluster1-b.storage.as41887.net: conn( Connecting -> Connected ) peer( =
Unknown -> Secondary )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: drbd_sync_handshake:
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: self =
BF8F65EBAABAF138:0000000000000000:0000000000000000:0000000000000000 =
bits:0 flags:0
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: peer =
374B6E4C8ECEB4F4:2CA8DD9FBE1E313E:0000000000000000:0000000000000000 =
bits:2 flags:120
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: uuid_compare()=3D-100 by rule 100
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
initial-split-brain
Jun 29 13:54:45 cluster1-a drbdadm[2485]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
initial-split-brain exit code 0 (0x0)
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10: =
Split-Brain detected, manually solved. Sync from peer node
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: pdsk( DUnknown -> UpToDate ) repl( Off =
-> WFBitMapT )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: receive bitmap stats [Bytes(packets)]: =
plain 0(0), RLE 25(1), total 25; compression: 100.0%
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: send bitmap stats [Bytes(packets)]: =
plain 0(0), RLE 25(1), total 25; compression: 100.0%
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
before-resync-target
Jun 29 13:54:45 cluster1-a drbdadm[2487]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
before-resync-target exit code 0 (0x0)
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: repl( WFBitMapT -> SyncTarget )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-c.storage.as41887.net: resync-susp( no -> connection dependency =
)
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: Began resync as SyncTarget (will sync 8 =
KB [2 bits set]).
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: Resync done (total 1 sec; paused 0 sec; =
8 K/sec)
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: updated UUIDs =
374B6E4C8ECEB4F4:0000000000000000:BF8F65EBAABAF138:406F8167C11BEB40
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10: =
disk( Inconsistent -> UpToDate )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: repl( SyncTarget -> Established )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-c.storage.as41887.net: pdsk( DUnknown -> Outdated ) =
resync-susp( connection dependency -> no )
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
after-resync-target
Jun 29 13:54:45 cluster1-a drbdadm[2489]: Don't know which config file =
belongs to resource testvm_prolocation_net, trying default ones...
Jun 29 13:54:45 cluster1-a kernel: drbd testvm_prolocation_net/0 drbd10 =
cluster1-b.storage.as41887.net: helper command: /sbin/drbdadm =
after-resync-target exit code 0 (0x0)

[root@cluster1-a ~]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Secondary
  disk:UpToDate
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate
  cluster1-c.storage.as41887.net connection:Connecting

Now I still need to re-connect node-c to the recovered node-a

[root@cluster1-c ~]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Secondary
  disk:Diskless
  cluster1-a.storage.as41887.net connection:StandAlone
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate

[root@cluster1-c ~]# drbdadm connect testvm_prolocation_net
testvm_prolocation_net: Failure: (125) Device has a net-config (use =
disconnect first)
Command 'drbdsetup connect testvm_prolocation_net 0' terminated with =
exit code 10

[root@cluster1-c ~]# drbdadm connect testvm_prolocation_net --peer =
cluster1-a.storage.as41887.net
testvm_prolocation_net: Failure: (125) Device has a net-config (use =
disconnect first)
Command 'drbdsetup connect testvm_prolocation_net 0' terminated with =
exit code 10

[root@cluster1-c ~]# drbdadm disconnect testvm_prolocation_net
[root@cluster1-c ~]# drbdadm connect testvm_prolocation_net
[root@cluster1-c ~]# drbdadm status | grep testvm_prolocation_net -A 6
testvm_prolocation_net role:Secondary
  disk:Diskless
  cluster1-a.storage.as41887.net role:Secondary
    peer-disk:UpToDate
  cluster1-b.storage.as41887.net role:Secondary
    peer-disk:UpToDate

Finally, all is synced and well connected again =E2=80=A6.

Above steps where a replay I did today after having seen this behaviour =
last night. So it seems to be reproducible. Also wondering if the =
=E2=80=98recover=E2=80=99 steps should be done though drbdmanage as =
well? Can=E2=80=99t seem to find any complete documentation on =
drbdmanage besides the man-page.

Yours,
Chris



