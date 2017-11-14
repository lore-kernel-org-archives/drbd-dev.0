Return-Path: <sekim@mantech.co.kr>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E2C621057593
	for <drbd-dev@lists.linbit.com>; Tue, 14 Nov 2017 05:22:01 +0100 (CET)
Received: by mail-io0-f172.google.com with SMTP id n79so12158147ion.3
	for <drbd-dev@lists.linbit.com>; Mon, 13 Nov 2017 20:22:01 -0800 (PST)
MIME-Version: 1.0
From: "Kim, SungEun" <sekim@mantech.co.kr>
Date: Tue, 14 Nov 2017 13:21:59 +0900
Message-ID: <CAHRYDjiH4awgMW-+h_N6WZhXV=DAKc01ddexZFjhKdwcRehC9w@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/related; boundary="94eb2c0556806c4b71055de9ba2a"
Cc: lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?B?7Jew6rWs7IaM7YyA7J6l?= <devmanager@mantech.co.kr>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Windows DRBD <wdrbd@mantech.co.kr>
Subject: [Drbd-dev] volume I/O hang on Ahead mode
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

--94eb2c0556806c4b71055de9ba2a
Content-Type: multipart/alternative; boundary="94eb2c0556806c4b6f055de9ba29"

--94eb2c0556806c4b6f055de9ba29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We tested the asynchronous replication Ahead mode of drbd9(9.0.9) at low
bandwidth (1 ~ 10 Mbps Network) and found that the I/O response time rate
slowed down during replication and eventually I/O of the volume hang
occurred.
Tests according to the following configuration and procedure will reproduce
well.


<drbd.conf>

global {

        disable-ip-verification;

                usage-count     no;

}

common {

        startup {

                wfc-timeout     1;

        }

        disk {

                resync-rate     100M;

        }

        net {

                on-congestion pull-ahead;

                congestion-fill 480M;

                verify-alg      md5;

        }

        proxy {

                memlimit 500M;

        }

}

resource r0 {

        protocol        A;

        disk {

                on-io-error     detach;

        }

        device  /dev/drbd0;

        floating 200.200.2.10:7788 {

                disk    /dev/sdd1;

                meta-disk internal;

                proxy on pm1 {

                        inside 127.0.0.1:7789;

                        outside 200.200.2.10:7790;

                }

        }



        floating 200.200.2.11:7788 {

                disk    /dev/sdc1;

                meta-disk internal;

                proxy on pm2 {

                        inside 127.0.0.1:7789;

                        outside 200.200.2.11:7790;

                }



        }

}


<Test procedure>
1. Proxy Buffer Size: 500M, congestion-fill: 480M;
2. Replication network bandwidth limit of 10Mbps (using VMware's network
bandwidth limiting feature)
3. Mount the /data on the pm1 node
4. dd if=3D/dev/zero of=3D/data/test.out bs=3D100M count=3D40
5. Enter pm1 ahead mode
6. When ls -l is executed in pm1 node /data directory, the result is not
output and it is almost hang status.


The purpose of this test was to measure the behavior of the drbd9
asynchronous Ahead mode and the I/O response rate of the volume, regardless
of the network bandwidth.

In my opinion, If the number of drbd_req in drbd9 becomes considerably
large (more than tens of drbd_req accumulated in trasfer_log in this test),
the execution time of drbd_sender increases. Especially, it takes much time
to traverse transfer_log in the following code,finally It seems that the
completion time has increased.

// Only the execution time of this logic is measured more than 5 ms

static struct drbd_request *__next_request_for_connection(
struct drbd_connection *connection, struct drbd_request *r)
{
r =3D list_prepare_entry(r, &connection->resource->transfer_log, tl_request=
s);

list_for_each_entry_continue(r, &connection->resource->transfer_log,
tl_requests) {
int vnr =3D r->device->vnr;
struct drbd_peer_device *peer_device =3D conn_peer_device(connection, vnr);
unsigned s =3D drbd_req_state_by_peer_device(r, peer_device);
if (!(s & RQ_NET_QUEUED))
continue;
return r;
}
return NULL;
}


Please check this issue and hope that the performance of asynchronous
replication of drbd9 will improve.

Thanks.


Best Regards
from SungEun Kim

[image: =EC=84=A4=EB=AA=85: logo]

Technical Research Center / Dev3 Team

Principal Research Engineer

*SungEun Kim               sekim@mantech.co.kr <sekim@mantech.co.kr>*

12F, Seoulforest Kolon digital Tower, 308-4, Seongsudong 2ga, Seongdong-gu,
Seoul, Korea

Tel : 02-2136-6913 / Fax : 02-575-4858 / Call Center : 1833-7790

http://www.mantech.co.kr

[image: =EB=B3=B8=EB=AC=B8 =EC=9D=B4=EB=AF=B8=EC=A7=80 1]

--94eb2c0556806c4b6f055de9ba29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,=C2=A0<br></div><div><div><br></div><div>We tested=
 the asynchronous replication Ahead mode of drbd9(9.0.9) at low bandwidth (=
1 ~ 10 Mbps Network) and found that the I/O response time rate slowed down =
during replication and eventually I/O of the volume hang occurred.</div><di=
v>Tests according to the following configuration and procedure will reprodu=
ce well.</div></div><div><br></div><div><br></div><div><p class=3D"MsoNorma=
l" style=3D"font-size:14px"><span lang=3D"EN-US">&lt;drbd.conf&gt;<u></u><u=
></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=
=3D"EN-US">global {<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D=
"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 disable-ip-verification;<u></u><u></u></span></p><p class=3D"MsoNorm=
al" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage-co=
unt=C2=A0=C2=A0=C2=A0=C2=A0 no;<u></u><u></u></span></p><p class=3D"MsoNorm=
al" style=3D"font-size:14px"><span lang=3D"EN-US">}<u></u><u></u></span></p=
><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">commo=
n {<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"=
><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 startup {<=
u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><sp=
an lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wfc-timeout=C2=A0=C2=A0=C2=A0=C2=A0 1;<u>=
</u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span=
 lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<u></u><u></u><=
/span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-=
US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk {<u></u><u></u></span><=
/p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 resync-rate=C2=A0=C2=A0=C2=A0=C2=A0 100M;<u></u><u></u></span>=
</p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<u></u><u></u></span></p><p cla=
ss=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net {<u></u><u></u></span></p><p class=3D"Ms=
oNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on=
-congestion pull-ahead;<u></u><u></u></span></p><p class=3D"MsoNormal" styl=
e=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 congestion-fill 4=
80M;<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px=
"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verify-alg=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 md5;<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-si=
ze:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<=
u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><sp=
an lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0proxy {<u></u>=
<u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lan=
g=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 memlimit 500M;<u></u><u></u></span></p><p class=
=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<u></u><u></u></span></p><p class=3D"MsoNor=
mal" style=3D"font-size:14px"><span lang=3D"EN-US">}<u></u><u></u></span></=
p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">reso=
urce r0 {<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size=
:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prot=
ocol=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A;<u></u><u></u></span></p><=
p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk {<u></u><u></u></span></p><p clas=
s=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 on-io-error=C2=A0=C2=A0=C2=A0=C2=A0 detach;<u></u><u></u></span></p><p =
class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<u></u><u></u></span></p><p class=3D"Mso=
Normal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 device=C2=A0 /dev/drbd0;<u></u><u></u></span></p><p c=
lass=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 floating=C2=A0<a href=3D"http://200.200.2=
.10:7788/" target=3D"_blank">200.200.2.10:7788</a>=C2=A0{<u></u><u></u></sp=
an></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 disk=C2=A0=C2=A0=C2=A0 /dev/sdd1;<u></u><u></u></span></=
p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 meta-disk internal;<u></u><u></u></span></p><p class=3D"MsoNor=
mal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy on=
 pm1 {<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14=
px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 inside=C2=A0<a href=3D"http://127.0.0.1:7789/" target=3D"_b=
lank">127.0.0.1:7789</a>;<u></u><u></u></span></p><p class=3D"MsoNormal" st=
yle=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outside=C2=A0<a href=3D"http://200.200.2.=
10:7790/" target=3D"_blank">200.200.2.10:7790</a>;<u></u><u></u></span></p>=
<p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-si=
ze:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<=
u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><sp=
an lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal" sty=
le=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 floating=C2=A0<a href=3D"http://200.200.2.11:7788/" target=3D"=
_blank">200.200.2.11:7788</a>=C2=A0{<u></u><u></u></span></p><p class=3D"Ms=
oNormal" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
sk=C2=A0=C2=A0=C2=A0 /dev/sdc1;<u></u><u></u></span></p><p class=3D"MsoNorm=
al" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta-dis=
k internal;<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-si=
ze:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proxy on pm2 {<u></u><u></u><=
/span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=3D"EN-=
US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insid=
e=C2=A0<a href=3D"http://127.0.0.1:7789/" target=3D"_blank">127.0.0.1:7789<=
/a>;<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px=
"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 outside=C2=A0<a href=3D"http://200.200.2.11:7790/" target=3D"_=
blank">200.200.2.11:7790</a>;<u></u><u></u></span></p><p class=3D"MsoNormal=
" style=3D"font-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<u></u><u>=
</u></span></p><p class=3D"MsoNormal" style=3D"font-size:14px"><span lang=
=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal" style=3D"f=
ont-size:14px"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<u></u><u></u></span></p><p class=3D"MsoNormal" style=3D"font-size:14p=
x"><span lang=3D"EN-US">}</span></p></div><div><br></div><div><br></div><di=
v><div>&lt;Test procedure&gt;</div><div>1. Proxy Buffer Size: 500M, congest=
ion-fill: 480M;</div><div>2. Replication network bandwidth limit of 10Mbps =
(using VMware&#39;s network bandwidth limiting feature)</div><div>3. Mount =
the /data on the pm1 node</div><div>4. dd if=3D/dev/zero of=3D/data/test.ou=
t bs=3D100M count=3D40</div><div>5. Enter pm1 ahead mode</div><div>6. When =
ls -l is executed in pm1 node /data directory, the result is not output and=
 it is almost hang status.</div></div><div><br></div><div><br></div><div>Th=
e purpose of this test was to measure the behavior of the drbd9 asynchronou=
s Ahead mode and the I/O response rate of the volume, regardless of the net=
work bandwidth.<br></div><div><br></div><div>In my opinion, If the number o=
f drbd_req in drbd9 becomes considerably large (more than tens of drbd_req =
accumulated in trasfer_log in this test), the execution time of drbd_sender=
 increases. Especially, it takes much time to traverse transfer_log in the =
following code,finally It seems that the completion time has increased.=C2=
=A0</div><div><br></div><div>//=C2=A0Only the execution time of this logic =
is measured more than 5 ms</div><div><br></div><div><div>static struct drbd=
_request *__next_request_for_connection(</div><div><span style=3D"white-spa=
ce:pre">		</span>struct drbd_connection *connection, struct drbd_request *r=
)</div><div>{</div><div><span style=3D"white-space:pre">	</span>r =3D list_=
prepare_entry(r, &amp;connection-&gt;resource-&gt;transfer_log, tl_requests=
);</div><div><br></div><div><span style=3D"white-space:pre">	</span>list_fo=
r_each_entry_continue(r, &amp;connection-&gt;resource-&gt;transfer_log, tl_=
requests) {</div><div><span style=3D"white-space:pre">		</span>int vnr =3D =
r-&gt;device-&gt;vnr;</div><div><span style=3D"white-space:pre">		</span>st=
ruct drbd_peer_device *peer_device =3D conn_peer_device(connection, vnr);</=
div><div><span style=3D"white-space:pre">		</span>unsigned s =3D drbd_req_s=
tate_by_peer_device(r, peer_device);</div><div><span style=3D"white-space:p=
re">		</span>if (!(s &amp; RQ_NET_QUEUED))</div><div><span style=3D"white-s=
pace:pre">			</span>continue;</div><div><span style=3D"white-space:pre">		<=
/span>return r;</div><div><span style=3D"white-space:pre">	</span>}</div><d=
iv><span style=3D"white-space:pre">	</span>return NULL;</div><div>}</div></=
div><div><br></div><div><br></div><div>Please check this issue and hope tha=
t the performance of asynchronous replication of drbd9 will improve.<br></d=
iv><div><br></div><div>Thanks.</div><div><br></div><div><br></div><div>Best=
 Regards</div><div>from SungEun Kim</div><br clear=3D"all"><div><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><p st=
yle=3D"margin:0cm 0cm 0pt"><img src=3D"cid:image001.png@01D0F522.B2A586F0" =
alt=3D"=EC=84=A4=EB=AA=85: logo"></p><p style=3D"font-size:small;margin:0cm=
 0cm 0.0001pt;background-image:initial;background-repeat:initial"><font fac=
e=3D"verdana, sans-serif"><span style=3D"font-size:10pt;color:black">Techni=
cal Research Center<span lang=3D"EN-US">=C2=A0</span><span lang=3D"EN-US">/=
=C2=A0</span>Dev3 Team</span><span lang=3D"EN-US" style=3D"font-size:10.5pt=
;color:rgb(136,136,136)"></span></font></p><p style=3D"font-size:small;marg=
in:0cm 0cm 0.0001pt;background-image:initial;background-repeat:initial"><fo=
nt face=3D"verdana, sans-serif"><span style=3D"font-size:10pt;color:black">=
<span lang=3D"EN-US">Principal Research Engineer</span></span></font></p><p=
 style=3D"font-size:small;margin:0cm 0cm 0pt"></p><p style=3D"font-size:sma=
ll;margin:0cm 0cm 0.0001pt;background-image:initial;background-repeat:initi=
al"><font face=3D"verdana, sans-serif"><b><span style=3D"color:black"><span=
 lang=3D"EN-US"><span style=3D"font-size:14px">SungEun Kim</span><span styl=
e=3D"font-size:10pt">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0</span><a href=3D"mailto:sekim@mantech.co.kr" style=3D"color:rgb(17,85,2=
04);font-size:10pt" target=3D"_blank">sekim@mantech.co.kr</a></span></span>=
</b><span lang=3D"EN-US" style=3D"font-size:10.5pt;color:rgb(136,136,136)">=
</span></font></p><p style=3D"font-size:small;margin:0cm 0cm 0.0001pt;line-=
height:21px"><font color=3D"#000000" face=3D"verdana, sans-serif"><span sty=
le=3D"font-size:8pt;line-height:16px">12F, Seoulforest Kolon digital Tower,=
 308-4, Seongsudong 2ga, Seongdong-gu, Seoul, Korea</span></font></p><p sty=
le=3D"font-size:small;margin:0cm 0cm 0.0001pt;line-height:21px"><span style=
=3D"font-size:8pt;line-height:16px;color:rgb(0,0,0);font-family:verdana,san=
s-serif">Tel : 02-2136-6913 / Fax : 02-575-4858 / Call Center : 1833-7790</=
span></p><p style=3D"margin:0cm 0cm 0.0001pt;line-height:21px"><span lang=
=3D"EN-US" style=3D"color:rgb(0,0,0);font-family:verdana,sans-serif;font-si=
ze:8pt;line-height:16px"><a href=3D"http://www.mantech.co.kr/" style=3D"col=
or:rgb(17,85,204)" target=3D"_blank">http://www.mantech.co.kr</a></span><sp=
an lang=3D"EN-US" style=3D"color:rgb(0,0,0);font-family:verdana,sans-serif;=
font-size:8pt;line-height:16px">=C2=A0</span><font color=3D"#000000" face=
=3D"verdana, sans-serif"><span lang=3D"EN-US" style=3D"font-size:8pt;line-h=
eight:16px"><br></span></font></p><p style=3D"margin:0cm 0cm 0.0001pt;line-=
height:21px"><img src=3D"cid:ii_150a68c3811acf54" alt=3D"=EB=B3=B8=EB=AC=B8=
 =EC=9D=B4=EB=AF=B8=EC=A7=80 1" width=3D"400" height=3D"160" style=3D"line-=
height: normal;"><br></p></div></div></div></div></div></div></div></div></=
div></div></div></div></div></div></div></div></div></div></div></div></div=
></div></div></div></div></div></div></div></div></div></div>
</div>

--94eb2c0556806c4b6f055de9ba29--

--94eb2c0556806c4b71055de9ba2a
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_150a68c3811acf54>
X-Attachment-Id: ii_150a68c3811acf54

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
--94eb2c0556806c4b71055de9ba2a
Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <image001.png@01D0F522.B2A586F0>
X-Attachment-Id: 1b04d787799a09e8_0.0.1

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
--94eb2c0556806c4b71055de9ba2a--
