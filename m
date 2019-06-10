Return-Path: <kcchuang.white@gmail.com>
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
	[209.85.208.180])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 045481011BFC
	for <drbd-dev@lists.linbit.com>; Mon, 10 Jun 2019 14:26:58 +0200 (CEST)
Received: by mail-lj1-f180.google.com with SMTP id 131so7758383ljf.4
	for <drbd-dev@lists.linbit.com>; Mon, 10 Jun 2019 05:26:58 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6I6K5Yex5YKR?= <kcchuang.white@gmail.com>
Date: Mon, 10 Jun 2019 20:20:22 +0800
Message-ID: <CAFsC7=cjKn2XKdOrQHsB8XMUnRQom7wd8yxHbp2s0afZLZRqkA@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/mixed; boundary="000000000000127d56058af7352d"
Subject: [Drbd-dev] drbd local replication usage problem
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

--000000000000127d56058af7352d
Content-Type: multipart/alternative; boundary="000000000000127d53058af7352b"

--000000000000127d53058af7352b
Content-Type: text/plain; charset="UTF-8"

Hi drbd-dev,

It will be appreciated if you can give me some advice.
I'm try to do local block device replication(vda vdb), in the very
beginning I use drbdsetup to create a local replication connection with the
same ip + different port, and it works(as attached
drbdsetup-to-create-local-replication.sh). It seems like drbd kernel module
support this kind of usage(local replication).

Then I try to make it as /etc/drbd.d/*.res formats, I create r0.res and
r0-local.res. When I execute drbdadm up r0, drbdadm report error(as
attached drbdadm_up_error.log) something like "address conflict". And I
found it was caused by the function 'check_addr_conflict' in
$drbd-utils/user/v9/drbdadm_postparse.c Line 1171~1173, I can see the
comments of check_addr_conflict(below), but I don't get it ^^" :
/* An AF/IP/addr triple might be used by multiple connections within one
resource,  but may not be mentioned in any other resource... */. As my
understanding the function check_addr_conflict is checking all resources if
there's any AF/IP/addr triple mentioned in any other resources.

*My questions are:*
*Q1. why an AF/IP/addr triple may not be mentioned in any other resource?*
*Q2. I mark off Line 1171~1173, make drbdadm skip 'check_addr_conflict' and
it works. Do you have any concerns? *
*Do you have any idea to do local replication with drbdadm and configured
/etc/drbd.d/*.res ?*

== attached files contents ==
1. drbdsetup-to-create-local-replication.sh:
# create r0 resource
drbdmeta 1 v09 /dev/vda internal create-md 3 --force
drbdsetup new-resource r0 1
drbdsetup new-minor r0 1 0
drbdsetup attach 1 /dev/vda /dev/vda internal
drbdsetup new-peer r0 2 --_name=local --protocol=C
drbdsetup primary r0 --force
drbdsetup  connect r0 2

# create r0-local resource
drbdmeta 2 v09 /dev/vdb internal create-md 3 --force
drbdsetup new-resource r0-local 2
drbdsetup new-minor r0-local 2 0
drbdsetup attach 2 /dev/vdb /dev/vdb internal
drbdsetup new-peer r0-local 0 --_name=local --protocol=C
drbdsetup connect r0-local 1

# start syncing vda to vdb ...

2. drbdadm_up_error.log:
[root@k80 ~]# /usr/sbin/drbdadm.org up r0
/etc/drbd.d/r0.res:0: in resource r0
    ipv4:192.168.122.80:7789 is also used /etc/drbd.d/r0-hot.res:0
(resource r0-local)
/etc/drbd.d/r0.res:0: in resource r0
    ipv4:192.168.122.80:7790 is also used /etc/drbd.d/r0-hot.res:0
(resource r0-local)

3. /etc/drbd.d/r0.res(as attached):
resource r0 {
  device /dev/drbd1;
  meta-disk internal;
  disk "/dev/vda";
  on k80 {
    node-id 1;
    address 192.168.122.80:7789;
  }
  on local {
    node-id 2;
    address 192.168.122.80:7790;
  }

  connection-mesh {
    hosts k80 local;
  }
}

4. /etc/drbd.d/r0-local.res:
resource r0-local {
  disk "/dev/vdb";
  device /dev/drbd2;
  meta-disk internal;
  on k80 {
    node-id 2;
    address 192.168.122.80:7790;
  }
  on local {
    node-id 1;
    address 192.168.122.80:7789;
  }

  connection-mesh {
    hosts  k80 local;
  }
}


-- 
Thanks,
Kevin

--000000000000127d53058af7352b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi drbd-dev,<div><br>It will be appreciated if you can giv=
e me some advice.</div><div>I&#39;m try to do local block device replicatio=
n(vda vdb), in the very beginning I use drbdsetup to create a local replica=
tion connection with the same ip + different port, and it works(as attached=
 drbdsetup-to-create-local-replication.sh). It seems like drbd kernel modul=
e support this kind of usage(local replication).</div><div><br></div><div>T=
hen I try to make it as /etc/drbd.d/*.res formats, I create r0.res and r0-l=
ocal.res. When I execute drbdadm up r0, drbdadm report error(as attached dr=
bdadm_up_error.log) something like &quot;address conflict&quot;. And I foun=
d it was caused by the function &#39;check_addr_conflict&#39; in $drbd-util=
s/user/v9/drbdadm_postparse.c Line 1171~1173, I can see the comments of che=
ck_addr_conflict(below), but I don&#39;t get it ^^&quot; :</div><div>/* An =
AF/IP/addr triple might be used by multiple connections within one resource=
,=C2=A0 but may not be mentioned in any other resource... */. As my underst=
anding the function check_addr_conflict is checking all resources if there&=
#39;s any AF/IP/addr triple mentioned in any other resources.</div><div><br=
></div><div><b><font size=3D"4">My questions are:</font></b></div><div><b><=
font size=3D"4">Q1. why an AF/IP/addr triple may not be mentioned in any ot=
her resource?</font></b></div><div><b><font size=3D"4">Q2. I mark off Line =
1171~1173, make drbdadm skip &#39;check_addr_conflict&#39; and it works. Do=
 you have any concerns?=C2=A0</font></b></div><div><b><font size=3D"4">Do y=
ou have any idea to do local replication with drbdadm and configured /etc/d=
rbd.d/*.res ?</font></b></div><div><br>=3D=3D attached files contents =3D=
=3D</div><div>1. drbdsetup-to-create-local-replication.sh:</div># create r0=
 resource<br>drbdmeta 1 v09 /dev/vda internal create-md 3 --force<br>drbdse=
tup new-resource r0 1<br>drbdsetup new-minor r0 1 0<br>drbdsetup attach 1 /=
dev/vda /dev/vda internal<br>drbdsetup new-peer r0 2 --_name=3Dlocal --prot=
ocol=3DC<br>drbdsetup primary r0 --force<br>drbdsetup =C2=A0connect r0 2<br=
><br># create r0-local resource<br>drbdmeta 2 v09 /dev/vdb internal create-=
md 3 --force<br>drbdsetup new-resource r0-local 2<br>drbdsetup new-minor r0=
-local 2 0<br>drbdsetup attach 2 /dev/vdb /dev/vdb internal<br>drbdsetup ne=
w-peer r0-local 0 --_name=3Dlocal --protocol=3DC<br>drbdsetup connect r0-lo=
cal 1<br><br><div># start syncing vda to vdb ...</div><div><br></div><div>2=
. drbdadm_up_error.log:</div><div>[root@k80 ~]# /usr/sbin/<a href=3D"http:/=
/drbdadm.org">drbdadm.org</a> up r0<br>/etc/drbd.d/r0.res:0: in resource r0=
<br>=C2=A0 =C2=A0 ipv4:<a href=3D"http://192.168.122.80:7789">192.168.122.8=
0:7789</a> is also used /etc/drbd.d/r0-hot.res:0 (resource r0-local)<br>/et=
c/drbd.d/r0.res:0: in resource r0<br>=C2=A0 =C2=A0 ipv4:<a href=3D"http://1=
92.168.122.80:7790">192.168.122.80:7790</a> is also used /etc/drbd.d/r0-hot=
.res:0 (resource r0-local)<br></div><div><br></div><div>3. /etc/drbd.d/r0.r=
es(as attached):</div><div>resource r0 {<br>=C2=A0 device /dev/drbd1;<br>=
=C2=A0 meta-disk internal;<br>=C2=A0 disk &quot;/dev/vda&quot;;<br>=C2=A0 o=
n k80 {<br>=C2=A0 =C2=A0 node-id 1;<br>=C2=A0 =C2=A0 address <a href=3D"htt=
p://192.168.122.80:7789">192.168.122.80:7789</a>;<br>=C2=A0 }<br>=C2=A0 on =
local {<br>=C2=A0 =C2=A0 node-id 2;<br>=C2=A0 =C2=A0 address <a href=3D"htt=
p://192.168.122.80:7790">192.168.122.80:7790</a>;<br>=C2=A0 }<br><br>=C2=A0=
 connection-mesh {<br>=C2=A0 =C2=A0 hosts k80 local;<br>=C2=A0 }<br>}<br></=
div><div><br></div><div>4. /etc/drbd.d/r0-local.res:</div><div>resource r0-=
local {<br>=C2=A0 disk &quot;/dev/vdb&quot;;<br>=C2=A0 device /dev/drbd2;<b=
r>=C2=A0 meta-disk internal;<br>=C2=A0 on k80 {<br>=C2=A0 =C2=A0 node-id 2;=
<br>=C2=A0 =C2=A0 address <a href=3D"http://192.168.122.80:7790">192.168.12=
2.80:7790</a>;<br>=C2=A0 }<br>=C2=A0 on local {<br>=C2=A0 =C2=A0 node-id 1;=
<br>=C2=A0 =C2=A0 address <a href=3D"http://192.168.122.80:7789">192.168.12=
2.80:7789</a>;<br>=C2=A0 }<br><br>=C2=A0 connection-mesh {<br>=C2=A0 =C2=A0=
 hosts =C2=A0k80 local;<br>=C2=A0 }<br>}<br></div><div><br></div><div><div>=
<br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr">Thanks,<div>Kevin</div></div></div></=
div></div>

--000000000000127d53058af7352b--

--000000000000127d56058af7352d
Content-Type: text/plain; charset="US-ASCII"; name="r0-local.res"
Content-Disposition: attachment; filename="r0-local.res"
Content-Transfer-Encoding: base64
Content-ID: <f_jwq4zd9l1>
X-Attachment-Id: f_jwq4zd9l1

cmVzb3VyY2UgcjAtbG9jYWwgew0KICBkaXNrICIvZGV2L3ZkYiI7DQogIGRldmljZSAvZGV2L2Ry
YmQyOw0KICBtZXRhLWRpc2sgaW50ZXJuYWw7DQogIG9uIGs4MCB7DQogICAgbm9kZS1pZCAyOw0K
ICAgIGFkZHJlc3MgMTkyLjE2OC4xMjIuODA6Nzc5MDsNCiAgfQ0KICBvbiBsb2NhbCB7DQogICAg
bm9kZS1pZCAxOw0KICAgIGFkZHJlc3MgMTkyLjE2OC4xMjIuODA6Nzc4OTsNCiAgfQ0KDQogIGNv
bm5lY3Rpb24tbWVzaCB7DQogICAgaG9zdHMgIGs4MCBsb2NhbDsNCiAgfQ0KfQ==
--000000000000127d56058af7352d
Content-Type: text/plain; charset="US-ASCII"; name="r0.res"
Content-Disposition: attachment; filename="r0.res"
Content-Transfer-Encoding: base64
Content-ID: <f_jwq4zd870>
X-Attachment-Id: f_jwq4zd870

cmVzb3VyY2UgcjAgew0KICBkZXZpY2UgL2Rldi9kcmJkMTsNCiAgbWV0YS1kaXNrIGludGVybmFs
Ow0KICBkaXNrICIvZGV2L3ZkYSI7DQogIG9uIGs4MCB7DQogICAgbm9kZS1pZCAxOw0KICAgIGFk
ZHJlc3MgMTkyLjE2OC4xMjIuODA6Nzc4OTsNCiAgfQ0KICBvbiBsb2NhbCB7DQogICAgbm9kZS1p
ZCAyOw0KICAgIGFkZHJlc3MgMTkyLjE2OC4xMjIuODA6Nzc5MDsNCiAgfQ0KDQogIGNvbm5lY3Rp
b24tbWVzaCB7DQogICAgaG9zdHMgazgwIGxvY2FsOw0KICB9DQp9
--000000000000127d56058af7352d
Content-Type: text/x-sh; charset="US-ASCII"; name="drbdsetup-to-create-local-replication.sh"
Content-Disposition: attachment;
	filename="drbdsetup-to-create-local-replication.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_jwq9ni612>
X-Attachment-Id: f_jwq9ni612

IyBjcmVhdGUgcjAgcmVzb3VyY2UNCmRyYmRtZXRhIDEgdjA5IC9kZXYvdmRhIGludGVybmFsIGNy
ZWF0ZS1tZCAzIC0tZm9yY2UNCmRyYmRzZXR1cCBuZXctcmVzb3VyY2UgcjAgMQ0KZHJiZHNldHVw
IG5ldy1taW5vciByMCAxIDANCmRyYmRzZXR1cCBhdHRhY2ggMSAvZGV2L3ZkYSAvZGV2L3ZkYSBp
bnRlcm5hbA0KZHJiZHNldHVwIG5ldy1wZWVyIHIwIDIgLS1fbmFtZT1sb2NhbCAtLXByb3RvY29s
PUMNCmRyYmRzZXR1cCBwcmltYXJ5IHIwIC0tZm9yY2UNCmRyYmRzZXR1cCAgY29ubmVjdCByMCAy
DQoNCiMgY3JlYXRlIHIwLWxvY2FsIHJlc291cmNlDQpkcmJkbWV0YSAyIHYwOSAvZGV2L3ZkYiBp
bnRlcm5hbCBjcmVhdGUtbWQgMyAtLWZvcmNlDQpkcmJkc2V0dXAgbmV3LXJlc291cmNlIHIwLWxv
Y2FsIDINCmRyYmRzZXR1cCBuZXctbWlub3IgcjAtbG9jYWwgMiAwDQpkcmJkc2V0dXAgYXR0YWNo
IDIgL2Rldi92ZGIgL2Rldi92ZGIgaW50ZXJuYWwNCmRyYmRzZXR1cCBuZXctcGVlciByMC1sb2Nh
bCAwIC0tX25hbWU9bG9jYWwgLS1wcm90b2NvbD1DDQpkcmJkc2V0dXAgY29ubmVjdCByMC1sb2Nh
bCAxDQoNCiMgc3RhcnQgc3luY2luZy4uLg==
--000000000000127d56058af7352d
Content-Type: application/octet-stream; name="drbdadm_up_error.log"
Content-Disposition: attachment; filename="drbdadm_up_error.log"
Content-Transfer-Encoding: base64
Content-ID: <f_jwq9nyur3>
X-Attachment-Id: f_jwq9nyur3

W3Jvb3RAazgwIH5dIyAvdXNyL3NiaW4vZHJiZGFkbS5vcmcgdXAgcjANCi9ldGMvZHJiZC5kL3Iw
LnJlczowOiBpbiByZXNvdXJjZSByMA0KICAgIGlwdjQ6MTkyLjE2OC4xMjIuODA6Nzc4OSBpcyBh
bHNvIHVzZWQgL2V0Yy9kcmJkLmQvcjAtaG90LnJlczowIChyZXNvdXJjZSByMC1sb2NhbCkNCi9l
dGMvZHJiZC5kL3IwLnJlczowOiBpbiByZXNvdXJjZSByMA0KICAgIGlwdjQ6MTkyLjE2OC4xMjIu
ODA6Nzc5MCBpcyBhbHNvIHVzZWQgL2V0Yy9kcmJkLmQvcjAtaG90LnJlczowIChyZXNvdXJjZSBy
MC1sb2NhbCk=
--000000000000127d56058af7352d--
