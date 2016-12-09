Return-Path: <david.syzdek@acsalaska.net>
Received: from smtp22.nwc.acsalaska.net (smtp22.nwc.acsalaska.net
	[209.112.142.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5E53F1056332
	for <drbd-dev@lists.linbit.com>; Sat, 10 Dec 2016 01:11:26 +0100 (CET)
Received: from 10-0-10-68.prv.acsalaska.net (10-0-10-68.prv.acsalaska.net
	[10.0.10.68])
	by smtp22.nwc.acsalaska.net (8.14.9/8.14.9) with ESMTP id
	uB9Nvnvu009349
	for <drbd-dev@lists.linbit.com>; Fri, 9 Dec 2016 14:57:49 -0900
From: "David M. Syzdek" <david.syzdek@acsalaska.net>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940"
Message-Id: <B9A4DA4C-C940-46CF-B971-E84C01CA3AEB@acsalaska.net>
Date: Fri, 9 Dec 2016 14:57:49 -0900
To: drbd-dev@lists.linbit.com
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Drbd-dev] drbd-overview misreports volume status if the resource
	contains multiple volumes
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


--Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

DRBD Devs,


DRBD Utilities:	8.9.9
DRBD Module:	9.0.5-1
Linux Kernel:	4.4.35
Perl:		5.18.1


The utility =E2=80=9Cdrbd-overview=E2=80=9D does not appear to proper =
track the status of volumes in a multi-volume resource.  The status of =
the last volume is displayed as the status for all volumes in a =
resource.  For example, if a resource has three volumes; volume 0 and =
volume 1 are inconsistent; and volume 2 is UpToDate, then drbd-overview =
will report all three volumes as UpToDate.

I=E2=80=99ve was able to duplicate the error on multiple DRBD nodes.

I=E2=80=99ve included two examples which use a DRBD resource backed by =
the following LVM volumes:

	root@xen66.prv.nwc# lvdisplay -C |grep ' test'
	test100g	vg_nwc.prv.xen66_drbd -wi-ao---- 100.00g         =
                                  =20
	test100m	vg_nwc.prv.xen66_drbd -wi-ao---- 100.00m         =
                                  =20
	test10g		vg_nwc.prv.xen66_drbd -wi-ao----  10.00g         =
                                  =20
	root@xen66.prv.nwc#

	root@xen67.prv.nwc# lvdisplay -C |grep ' test'
	test100g	vg_nwc.prv.xen67_drbd -wi-a----- 100.00g         =
                                  =20
	test100m	vg_nwc.prv.xen67_drbd -wi-a----- 100.00m         =
                                  =20
	test10g		vg_nwc.prv.xen67_drbd -wi-a-----  10.00g         =
                                  =20
	root@xen67.prv.nwc#=20

Example 1:

	root@xen66.prv.nwc# drbd-overview  |grep :test; drbdsetup =
events2  --now test
	40:test/0                      Connected(2*) Primar/Second =
UpToDate(2*) =20
	41:test/1                      Connected(2*) Primar/Second =
UpToDate(2*) =20
	42:test/2                      Connected(2*) Primar/Second =
UpToDate(2*) =20
	exists resource name:test role:Primary suspended:no
	exists connection name:test peer-node-id:1 conn-name:xen67 =
connection:Connected role:Secondary
	exists device name:test volume:0 minor:40 disk:UpToDate
	exists device name:test volume:1 minor:41 disk:UpToDate
	exists device name:test volume:2 minor:42 disk:UpToDate
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:0 replication:SyncSource peer-disk:Inconsistent =
resync-suspended:no
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:1 replication:SyncSource peer-disk:Inconsistent =
resync-suspended:no
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:2 replication:Established peer-disk:UpToDate resync-suspended:no
	exists -
	root@xen66.prv.nwc#


	root@xen67.prv.nwc# drbd-overview  |grep :test; drbdsetup =
events2  --now test
	40:test/0                      Connected(2*) Second/Primar =
UpToDate(2*)=20
	41:test/1                      Connected(2*) Second/Primar =
UpToDate(2*)=20
	42:test/2                      Connected(2*) Second/Primar =
UpToDate(2*)=20
	exists resource name:test role:Secondary suspended:no
	exists connection name:test peer-node-id:0 conn-name:xen66 =
connection:Connected role:Primary
	exists device name:test volume:0 minor:40 disk:Inconsistent
	exists device name:test volume:1 minor:41 disk:Inconsistent
	exists device name:test volume:2 minor:42 disk:UpToDate
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:0 replication:SyncTarget peer-disk:UpToDate resync-suspended:no
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:1 replication:SyncTarget peer-disk:UpToDate resync-suspended:no
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:2 replication:Established peer-disk:UpToDate resync-suspended:no
	exists -
	root@xen67.prv.nwc#



Example 2:

	root@xen66.prv.nwc# drbd-overview  |grep :test; drbdsetup =
events2  --now test
	40:test/0                      Connected(2*) Secondary(2*) =
UpToDa/Incons=20
	41:test/1                      Connected(2*) Secondary(2*) =
UpToDa/Incons=20
	42:test/2                      Connected(2*) Secondary(2*) =
UpToDa/Incons=20
	exists resource name:test role:Secondary suspended:no
	exists connection name:test peer-node-id:1 conn-name:xen67 =
connection:Connected role:Secondary
	exists device name:test volume:0 minor:40 disk:UpToDate
	exists device name:test volume:1 minor:41 disk:UpToDate
	exists device name:test volume:2 minor:42 disk:UpToDate
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:0 replication:SyncSource peer-disk:Inconsistent =
resync-suspended:no
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:1 replication:Established peer-disk:UpToDate resync-suspended:no
	exists peer-device name:test peer-node-id:1 conn-name:xen67 =
volume:2 replication:SyncSource peer-disk:Inconsistent =
resync-suspended:no
	exists -
	root@xen66.prv.nwc#

	root@xen67.prv.nwc# drbd-overview  |grep :test; drbdsetup =
events2  --now test
	40:test/0                      Connected(2*) Secondary(2*) =
Incons/UpToDa=20
	41:test/1                      Connected(2*) Secondary(2*) =
Incons/UpToDa=20
	42:test/2                      Connected(2*) Secondary(2*) =
Incons/UpToDa=20
	exists resource name:test role:Secondary suspended:no
	exists connection name:test peer-node-id:0 conn-name:xen66 =
connection:Connected role:Secondary
	exists device name:test volume:0 minor:40 disk:Inconsistent
	exists device name:test volume:1 minor:41 disk:UpToDate
	exists device name:test volume:2 minor:42 disk:Inconsistent
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:0 replication:SyncTarget peer-disk:UpToDate resync-suspended:no
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:1 replication:Established peer-disk:UpToDate resync-suspended:no
	exists peer-device name:test peer-node-id:0 conn-name:xen66 =
volume:2 replication:SyncTarget peer-disk:UpToDate resync-suspended:no
	exists -
	root@xen67.prv.nwc#

=E2=80=94David M. Syzdek

----------------------------------------------------------------------
David M. Syzdek                             david.syzdek@acsalaska.com
IP Engineering                                   Work: +1 907 550 8389
                                                 Cell: +1 907 980 1151
Alaska Communications Systems, Inc
MS #53
600 Telephone Avenue
Anchorage, Alaska  99503
----------------------------------------------------------------------


--Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940
Content-Disposition: attachment;
	filename=test-example1.res
Content-Type: application/octet-stream;
	name="test-example1.res"
Content-Transfer-Encoding: 7bit

resource test {
   net {
      # authentication
      cram-hmac-alg       sha1;
      shared-secret       "test: xen66.prv.nwc/xen67.prv.nwc";
   }
   disk {
      #c-min-rate         10M;
      #c-max-rate         41M;
      #resync-rate        82M;
   }
   on xen66 {
      address   10.0.109.66:7740;
      node-id   0;
      volume 0 {
         device    /dev/drbd40;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test10g;
      }
      volume 1 {
         device    /dev/drbd41;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test100g;
      }
      volume 2 {
         device    /dev/drbd42;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test100m;
      }
   }
   on xen67 {
      address   10.0.109.67:7740;
      node-id   1;
      volume 0 {
         device    /dev/drbd40;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test10g;
      }
      volume 1 {
         device    /dev/drbd41;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test100g;
      }
      volume 2 {
         device    /dev/drbd42;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test100m;
      }
   }
   connection-mesh {
      hosts xen66 xen67;
      net {
         use-rle no;
      }
  }
}

--Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940
Content-Disposition: attachment;
	filename=test-example2.res
Content-Type: application/octet-stream;
	name="test-example2.res"
Content-Transfer-Encoding: 7bit

resource test {
   net {
      # authentication
      cram-hmac-alg       sha1;
      shared-secret       "test: xen66.prv.nwc/xen67.prv.nwc";
   }
   disk {
      #c-min-rate         10M;
      #c-max-rate         41M;
      #resync-rate        82M;
   }
   on xen66 {
      address   10.0.109.66:7740;
      node-id   0;
      volume 0 {
         device    /dev/drbd40;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test10g;
      }
      volume 1 {
         device    /dev/drbd41;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test100m;
      }
      volume 2 {
         device    /dev/drbd42;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen66_drbd/test100g;
      }
   }
   on xen67 {
      address   10.0.109.67:7740;
      node-id   1;
      volume 0 {
         device    /dev/drbd40;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test10g;
      }
      volume 1 {
         device    /dev/drbd41;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test100m;
      }
      volume 2 {
         device    /dev/drbd42;
         meta-disk internal;
         disk      /dev/vg_nwc.prv.xen67_drbd/test100g;
      }
   }
   connection-mesh {
      hosts xen66 xen67;
      net {
         use-rle no;
      }
  }
}

--Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



--Apple-Mail=_DF181DE8-41CB-4571-BDEC-C711EE90B940--
