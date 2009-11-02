Return-Path: <sajan.agr@gmail.com>
Received: from mail-vw0-f192.google.com (mail-vw0-f192.google.com
	[209.85.212.192])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B18FB1011C09
	for <drbd-dev@lists.linbit.com>; Mon,  2 Nov 2009 07:16:39 +0100 (CET)
Received: by vws30 with SMTP id 30so1181520vws.33
	for <drbd-dev@lists.linbit.com>; Sun, 01 Nov 2009 22:16:38 -0800 (PST)
MIME-Version: 1.0
From: sajan agr <sajan.agr@gmail.com>
Date: Mon, 2 Nov 2009 11:40:53 +0530
Message-ID: <6ebabfd80911012210j144a25c9tdac8a88a26f4afd6@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001636c92c369ec91004775d3e2f
Subject: [Drbd-dev] Integrating iSCSI service to DRBD for iSCSI failover -
	Heartbeat
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--001636c92c369ec91004775d3e2f
Content-Type: text/plain; charset=ISO-8859-1

Hi

I am a naive user of pacemaker and have been trying to achieve iSCSI
failover on Pacemaker. I have tried couple of things though, which logically
looks fine. But, I am not able to get any progress in this. So, I wanted to
share this problem with you and help me sort out the problem.

This is how my CIB file looks like :

node $id="1c96735b-59c8-47d9-a2c6-cd2a2731d936" drbd_desk1 \
        attributes standby="off"
node $id="b8c4fa16-df49-45b7-a850-cb9f65af036e" drbd_desk2 \
        attributes standby="off"
primitive drbd_test ocf:linbit:drbd \
        params drbd_resource="r0" \
        op monitor interval="15s" \
        meta target-role="started"
primitive ip_drbd ocf:heartbeat:IPaddr2 \
        params ip="192.168.30.33" nic="eth0" \
        meta target-role="started"
primitive iscsiLU ocf:heartbeat:iSCSILogicalUnit \
        params lun="0" path="/dev/drbd0"
target_iqn="iqn.2009-10.com.systems:Testme" \
        meta target-role="started"
primitive iscsiTG ocf:heartbeat:iSCSITarget \
        params iqn="iqn.2009-10.com.systems:Testme" tid="1" \
        meta target-role="started"
group drbd_group ip_drbd iscsiTG iscsiLU
ms ms_DRBD drbd_test \
        meta master-max="1" master-node-max="1" clone-max="2"
clone-node-max="1" notify="true"
property $id="cib-bootstrap-options" \
        dc-version="1.0.5-462f1569a43740667daf7b0f6b521742e9eb8fa7" \
        cluster-infrastructure="openais" \
        no-quorum-policy="ignore" \
        stonith-enabled="false" \
        default-resource-stickiness="1000" \
        expected-quorum-votes="2" \
        last-lrm-refresh="1256633765"


crm_mon shows perfectly fine when both the nodes are up and shows all
services are running.

I powered off the master (desk2 at present), desk1 becomes master fine, but
the iscsiLU resource is seen 'Stopped' at this machine. I think this service
is not migrated here.

Can anyone guide me through this ?

--001636c92c369ec91004775d3e2f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br clear=3D"all"><span class=3D"Apple-style-span" style=3D"border-collapse=
: separate; color: rgb(0, 0, 0); font-family: &#39;Times New Roman&#39;; fo=
nt-size: medium; font-style: normal; font-variant: normal; font-weight: nor=
mal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0p=
x;"><span class=3D"Apple-style-span" style=3D"font-family: verdana,geneva,h=
elvetica,arial,sans-serif; font-size: 13px;">Hi<span class=3D"Apple-convert=
ed-space">=A0</span><br>

<br>I am a naive user of pacemaker and have been trying to achieve iSCSI fa=
ilover on Pacemaker. I have tried couple of things though, which logically =
looks fine. But, I am not able to get any progress in this. So, I wanted to=
 share this problem with you and help me sort out the problem.<span class=
=3D"Apple-converted-space">=A0</span><br>

<br>This is how my CIB file looks like :<span class=3D"Apple-converted-spac=
e">=A0</span><br><br>node $id=3D&quot;1c96735b-59c8-47d9-a2c6-cd2a2731d936&=
quot; drbd_desk1 \<span class=3D"Apple-converted-space">=A0</span><br>=A0 =
=A0 =A0 =A0 attributes standby=3D&quot;off&quot;<span class=3D"Apple-conver=
ted-space">=A0</span><br>

node $id=3D&quot;b8c4fa16-df49-45b7-a850-cb9f65af036e&quot; drbd_desk2 \<sp=
an class=3D"Apple-converted-space">=A0</span><br>=A0 =A0 =A0 =A0 attributes=
 standby=3D&quot;off&quot;<span class=3D"Apple-converted-space">=A0</span><=
br>primitive drbd_test ocf:linbit:drbd \<span class=3D"Apple-converted-spac=
e">=A0</span><br>

=A0 =A0 =A0 =A0 params drbd_resource=3D&quot;r0&quot; \<span class=3D"Apple=
-converted-space">=A0</span><br>=A0 =A0 =A0 =A0 op monitor interval=3D&quot=
;15s&quot; \<span class=3D"Apple-converted-space">=A0</span><br>=A0 =A0 =A0=
 =A0 meta target-role=3D&quot;started&quot;<span class=3D"Apple-converted-s=
pace">=A0</span><br>

primitive ip_drbd ocf:heartbeat:IPaddr2 \<span class=3D"Apple-converted-spa=
ce">=A0</span><br>=A0 =A0 =A0 =A0 params ip=3D&quot;192.168.30.33&quot; nic=
=3D&quot;eth0&quot; \<span class=3D"Apple-converted-space">=A0</span><br>=
=A0 =A0 =A0 =A0 meta target-role=3D&quot;started&quot;<span class=3D"Apple-=
converted-space">=A0</span><br>

primitive iscsiLU ocf:heartbeat:iSCSILogicalUnit \<span class=3D"Apple-conv=
erted-space">=A0</span><br>=A0 =A0 =A0 =A0 params lun=3D&quot;0&quot; path=
=3D&quot;/dev/drbd0&quot; target_iqn=3D&quot;iqn.2009-10.com.systems:Testme=
&quot; \<span class=3D"Apple-converted-space">=A0</span><br>

=A0 =A0 =A0 =A0 meta target-role=3D&quot;started&quot;<span class=3D"Apple-=
converted-space">=A0</span><br>primitive iscsiTG ocf:heartbeat:iSCSITarget =
\<span class=3D"Apple-converted-space">=A0</span><br>=A0 =A0 =A0 =A0 params=
 iqn=3D&quot;iqn.2009-10.com.systems:Testme&quot; tid=3D&quot;1&quot; \<spa=
n class=3D"Apple-converted-space">=A0</span><br>

=A0 =A0 =A0 =A0 meta target-role=3D&quot;started&quot;<span class=3D"Apple-=
converted-space">=A0</span><br>group drbd_group ip_drbd iscsiTG iscsiLU<spa=
n class=3D"Apple-converted-space">=A0</span><br>ms ms_DRBD drbd_test \<span=
 class=3D"Apple-converted-space">=A0</span><br>

=A0 =A0 =A0 =A0 meta master-max=3D&quot;1&quot; master-node-max=3D&quot;1&q=
uot; clone-max=3D&quot;2&quot; clone-node-max=3D&quot;1&quot; notify=3D&quo=
t;true&quot;<span class=3D"Apple-converted-space">=A0</span><br>property $i=
d=3D&quot;cib-bootstrap-options&quot; \<span class=3D"Apple-converted-space=
">=A0</span><br>

=A0 =A0 =A0 =A0 dc-version=3D&quot;1.0.5-462f1569a43740667daf7b0f6b521742e9=
eb8fa7&quot; \<span class=3D"Apple-converted-space">=A0</span><br>=A0 =A0 =
=A0 =A0 cluster-infrastructure=3D&quot;openais&quot; \<span class=3D"Apple-=
converted-space">=A0</span><br>

=A0 =A0 =A0 =A0 no-quorum-policy=3D&quot;ignore&quot; \<span class=3D"Apple=
-converted-space">=A0</span><br>=A0 =A0 =A0 =A0 stonith-enabled=3D&quot;fal=
se&quot; \<span class=3D"Apple-converted-space">=A0</span><br>=A0 =A0 =A0 =
=A0 default-resource-stickiness=3D&quot;1000&quot; \<span class=3D"Apple-co=
nverted-space">=A0</span><br>

=A0 =A0 =A0 =A0 expected-quorum-votes=3D&quot;2&quot; \<span class=3D"Apple=
-converted-space">=A0</span><br>=A0 =A0 =A0 =A0 last-lrm-refresh=3D&quot;12=
56633765&quot;<span class=3D"Apple-converted-space">=A0</span><br><br><br>c=
rm_mon shows perfectly fine when both the nodes are up and shows all servic=
es are running.<span class=3D"Apple-converted-space">=A0</span><br>

<br>I powered off the master (desk2 at present), desk1 becomes master fine,=
 but the iscsiLU resource is seen &#39;Stopped&#39; at this machine. I thin=
k this service is not migrated here.<span class=3D"Apple-converted-space">=
=A0</span><br>

<br>Can anyone guide me through this ?<span class=3D"Apple-converted-space"=
>=A0</span><br></span></span><br>

--001636c92c369ec91004775d3e2f--
