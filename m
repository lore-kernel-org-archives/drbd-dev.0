Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id A27DD1056318
	for <drbd-dev@lists.linbit.com>; Sun, 24 Jan 2016 00:06:10 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: =?utf-8?B?6rmA7ISx7J2A?= <sekim@mantech.co.kr>
Date: Sun, 24 Jan 2016 00:06:10 +0100
Message-ID: <6568628.beGrssJs4n@nuc>
In-Reply-To: <CAHRYDjgPn=+p4gyUnp=2Wv39rB-v3uJgozfgGdStWBM9ki+g3w@mail.gmail.com>
References: <CAHRYDjgyCcQEA0usvC+oxgtUE=n__4UbxeZUe3694s6P_BdYQQ@mail.gmail.com>
	<1480093.ZW76pyVVg3@phil-dell-xps.local>
	<CAHRYDjgPn=+p4gyUnp=2Wv39rB-v3uJgozfgGdStWBM9ki+g3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2407771.0WZ6mFgT65"
Content-Transfer-Encoding: 7Bit
Cc: =?utf-8?B?7KeE7ZiE7J20?= <jhlee@mantech.co.kr>,
	Windows DRBD <wdrbd@mantech.co.kr>,
	=?utf-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>,
	=?utf-8?B?67CV7ISx7ZmY?= <shpark@mantech.co.kr>,
	lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [CASE 12] 2 primary split-brain is not detected
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

This is a multi-part message in MIME format.

--nextPart2407771.0WZ6mFgT65
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

thanks for the detailed description.
Please find attached a proposed fix. I want to think about it for one m=
ore
day before I push it onto the master branch.

best regards,
  phil

> Hello,
>=20
> thank you for your reply. appreciated that
>=20
> I tested again with current GIT-head version(Commit: [9c711b4]), repr=
oduce
> this issue, and same result is happened.
>=20
> more detail descriptions are below :
>=20
> 1) Env:
>=20
> - CentOS 7 64bit
> - i7 4790K CPU 4Ghz , memory :1G
> - 2 node VM
>=20
> 2) drbd version (self build)
>=20
> [root@drbd9-02 ]# ls -l
> /lib/modules/3.10.0-229.7.2.el7.x86_64/updates/drbd.ko
> -rw-r--r-- 1 root root 10657876 * Jan 21* 11:01
> /lib/modules/3.10.0-229.7.2.el7.x86_64/updates/drbd.ko
>=20
> 3) scenario:
> - basically, progressed to 2-primary split-brain scenario.
> - first, 2 node status is secondary-secondary uptodate
> node 1 node 2
> drbdadm disconnect r0
> drbdadm primary r0
> copy files on node1 volume
>   drbdadm primary r0
>   copy files on node2 volume
> drbdadm connect r0
>=20
> 4) result
>=20
> - 2 primary Split-brain did not occurred.
> - according to drbd kernel log, I guess that connecting phase is fail=
ed and
> retry to connect between 2 nodes, repeatedly.
>=20
>=20
> you will see my drbd configuration and kernel log files, attached.
>=20
> I hope that help for you.
>=20
> Best Regards
> Sung-eun kim
> from Seoul
>=20
>=20
> [image: =EC=84=A4=EB=AA=85: logo]
>=20
> =EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C / DRBD=ED=8C=80        =
Mobile : 010-2813-4843
>=20
> *=EA=B9=80 =EC=84=B1 =EC=9D=80 **=EC=B0=A8=EC=9E=A5               sek=
im@mantech.co.kr <sekim@mantech.co.kr>*
>=20
> =EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=B5=
=AC =EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C4=EA=B8=B8 25 =EC=84=9C=EC=9A=B8=
=EC=88=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=80=
=EC=9B=8C 12=EC=B8=B5
>=20
> Tel : 02-2136-6913 / Fax : 02-575-4858 / =EC=BD=9C=EC=84=BC=ED=84=B0 =
: 1833-7790
>=20
> http://www.mantech.co.kr
>=20
> [image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]
>=20
> 2016-01-20 18:26 GMT+09:00 Philipp Reisner <philipp.reisner@linbit.co=
m>:
> > Hi,
> >=20
> > I am following up on CASE 12 now.
> >=20
> > I was not able to reproduce what you describe in this report.
> > Please check that you can still reproduce it with current GIT-head.=

> >=20
> > If yes, please re-send it with a more detailed description, includi=
ng:
> >  Configuration used.
> >  Logfiles from begin to end of the test.
> >=20
> > Thanks!
> >=20
> > Best regards,
> >=20
> >  Phil
> > =20
> > > Hello,
> > >=20
> > > I am Software Manager in Mantech, and testing drbd 9.
> > >=20
> > > some problems are occurred. CASE 12 is one of them.
> > >=20
> > > [CASE 12] 2 primary split-brain is not detected.
> > >=20
> > > Env:
> > > - Linux VM 2 nodes
> > > - Linux drbd version 9.0.0
> > >=20
> > > Test scenario:
> > >=20
> > > - 2 node's status is uptodate
> > >=20
> > > node 1node 2drbdadm disconnect r0 drbdadm primary r0 copy files o=
n
> > > node1   drbdadm
> > > primary r0 copy files on node2
> > > drbdadm connect r0
> > >=20
> > > - at this point, we predicted that 2 primary split-brain is occur=
red and
> > > drbd9 detect it.
> > >=20
> > > But split-brain is not occurred, not detected. no debug log.
> > > Just retry connection log is showing between two nodes.
> > >=20
> > > Question is :
> > >=20
> > > 1) How can I test 2 primary split-brain situation ?
> > >=20
> > > 2) Does support 2 primary split-brain in drbd9 ?
> > >=20
> > >=20
> > > PS)
> >=20
> > http://drbd.linbit.com/users-guide-9.0/s-configure-split-brain-beha=
vior.ht
> > ml>=20
> > > #s-split-brain-notification
> > >=20
> > > drbd9's manual describe 'after-sb-2pri' option.
> > >=20
> > > Thanks,
> > >=20
> > >=20
> > > Best Regards
> > > Sungeun Kim
> > >=20
> > >=20
> > >=20
> > >=20
> > > [image: =EC=84=A4=EB=AA=85: logo]
> > >=20
> > > =EA=B8=B0=EC=88=A0=EC=97=B0=EA=B5=AC=EC=86=8C / DRBD=ED=8C=80    =
    Mobile : 010-2813-4843
> > >=20
> > > *=EA=B9=80 =EC=84=B1 =EC=9D=80 **=EC=B0=A8=EC=9E=A5              =
 sekim@mantech.co.kr <sekim@mantech.co.kr>*
> > >=20
> > > =EC=84=9C=EC=9A=B8=ED=8A=B9=EB=B3=84=EC=8B=9C =EC=84=B1=EB=8F=99=EA=
=B5=AC =EC=84=B1=EC=88=98=EC=9D=BC=EB=A1=9C4=EA=B8=B8 25 =EC=84=9C=EC=9A=
=B8=EC=88=B2=EC=BD=94=EC=98=A4=EB=A1=B1=EB=94=94=EC=A7=80=ED=84=B8=ED=83=
=80=EC=9B=8C 12=EC=B8=B5
> > >=20
> > > Tel : 02-2136-6913 / Fax : 02-575-4858 / =EC=BD=9C=EC=84=BC=ED=84=
=B0 : 1833-7790
> > >=20
> > > http://www.mantech.co.kr
> > >=20
> > > [image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]

--nextPart2407771.0WZ6mFgT65
Content-Disposition: attachment; filename="case12_fix.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="case12_fix.patch"

commit b775310ecb7549122d6e39b88c84b48ea65a5dc5
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Sat Jan 23 23:49:13 2016 +0100

    drbd: Do not outdate myself if I am primary

diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
index ee63141..8a3ca9f 100644
--- a/drbd/drbd_state.c
+++ b/drbd/drbd_state.c
@@ -3574,6 +3574,9 @@ void __outdate_myself(struct drbd_resource *resource)
 	struct drbd_device *device;
 	int vnr;
 
+	if (resource->role[NOW] == R_PRIMARY)
+		return;
+
 	idr_for_each_entry(&resource->devices, device, vnr) {
 		if (device->disk_state[NOW] > D_OUTDATED)
 			__change_disk_state(device, D_OUTDATED);

commit c6963c44c48c99e7248265ee4318914e69b4a6fd
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Sat Jan 23 22:56:06 2016 +0100

    drbd: When connect fails because too many primaries assume split-brain
    
    If there are more primaries than allowed, and connect fails therefore
    we do not get a chance to look at the UUIDs.
    In order to match expectations (and drbd-8 behaviour) call the
    split-brain handler in this case as well.

diff --git a/drbd/drbd_receiver.c b/drbd/drbd_receiver.c
index 904d444..bd59827 100644
--- a/drbd/drbd_receiver.c
+++ b/drbd/drbd_receiver.c
@@ -667,6 +667,10 @@ int connect_work(struct drbd_work *work, int cancel)
 		connection->connect_timer.expires = jiffies + HZ/20;
 		add_timer(&connection->connect_timer);
 		return 0; /* Return early. Keep the reference on the connection! */
+	} else if (rv == SS_TWO_PRIMARIES) {
+		change_cstate(connection, C_DISCONNECTING, CS_HARD);
+		drbd_alert(connection, "Split-Brain since more primaries than allowed; dropping connection!\n");
+		drbd_khelper(NULL, connection, "split-brain");
 	} else {
 		drbd_info(connection, "Failure to connect; retrying\n");
 		change_cstate(connection, C_NETWORK_FAILURE, CS_HARD);

--nextPart2407771.0WZ6mFgT65--

