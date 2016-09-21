Return-Path: <kmpak@mantech.co.kr>
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com
	[209.85.214.42]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C11B4105645E
	for <drbd-dev@lists.linbit.com>; Wed, 21 Sep 2016 10:19:50 +0200 (CEST)
Received: by mail-it0-f42.google.com with SMTP id n143so43265462ita.1
	for <drbd-dev@lists.linbit.com>; Wed, 21 Sep 2016 01:19:50 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Date: Wed, 21 Sep 2016 17:12:43 +0900
Message-ID: <CALLFrTR38BGCxBgD5mXWFYfuCZxaj-iHyB_K6QtwW=QNnoGAhQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a113acda017d830053d001ccc
Subject: [Drbd-dev] About cleanup unprocessed requests
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

--001a113acda017d830053d001ccc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello

I have a question in DRBD9.

In sender thread, if there are some unprocessed requests, then process
through SEND_CANCELED mod. In a code

int drbd_sender(struct drbd_thread *thi)
{
...
/* cleanup all currently unprocessed requests */
if (!connection->todo.req) {
spin_lock_irq(&connection->resource->req_lock);
tl_next_request_for_connection(connection);
spin_unlock_irq(&connection->resource->req_lock);
}
while (connection->todo.req) {
struct bio_and_error m;
struct drbd_request *req =3D connection->todo.req;
struct drbd_device *device =3D req->device;
peer_device =3D conn_peer_device(connection, device->vnr);

spin_lock_irq(&connection->resource->req_lock);
tl_next_request_for_connection(connection);
__req_mod(req, SEND_CANCELED, peer_device, &m);
spin_unlock_irq(&connection->resource->req_lock);
if (m.bio)
complete_master_bio(device, &m);
}
...
}

I think two functions might be exchanged like below
__req_mod(req, SEND_CANCELED, peer_device, &m);
tl_next_request_for_connection(connection);

Because some case(peer's rq_state with RQ_NET_QUEUE)
 __req_mod(SEND_CANCELED) would call the advance_conn_req_next() function
and then connection->todo.req_next could be changed to next request.

__req_mod() ---> changed next request
tl_next_request_for_connection --> adjust the current request


But in original case,
tl_next_request_for_connection  -> current req is same next request
__req_mod() ->  changed next request but can't adjust current request



Thanks
--
=E1=90=A7

--001a113acda017d830053d001ccc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello<div><br></div><div>I have a question in DRBD9.</div>=
<div><br clear=3D"all"><div>In sender thread, if there are some unprocessed=
 requests, then process through SEND_CANCELED mod. In a code</div><div><br>=
</div><div><div>int drbd_sender(struct drbd_thread *thi)</div><div>{</div><=
/div><div>...</div><div><div>/* cleanup all currently unprocessed requests =
*/</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre"=
>	</span>if (!connection-&gt;todo.req) {</div><div><span class=3D"gmail-App=
le-tab-span" style=3D"white-space:pre">		</span>spin_lock_irq(&amp;connecti=
on-&gt;resource-&gt;req_lock);</div><div><span class=3D"gmail-Apple-tab-spa=
n" style=3D"white-space:pre">		</span>tl_next_request_for_connection(connec=
tion);</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:=
pre">		</span>spin_unlock_irq(&amp;connection-&gt;resource-&gt;req_lock);</=
div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</=
span>}</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:=
pre">	</span>while (connection-&gt;todo.req) {</div><div><span class=3D"gma=
il-Apple-tab-span" style=3D"white-space:pre">		</span>struct bio_and_error =
m;</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre"=
>		</span>struct drbd_request *req =3D connection-&gt;todo.req;</div><div><=
span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>stru=
ct drbd_device *device =3D req-&gt;device;</div><div><span class=3D"gmail-A=
pple-tab-span" style=3D"white-space:pre">		</span>peer_device =3D conn_peer=
_device(connection, device-&gt;vnr);</div><div><br></div><div><span class=
=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>spin_lock_irq(=
&amp;connection-&gt;resource-&gt;req_lock);</div><div><span class=3D"gmail-=
Apple-tab-span" style=3D"white-space:pre">		</span>tl_next_request_for_conn=
ection(connection);<br></div><div><span class=3D"gmail-Apple-tab-span" styl=
e=3D"white-space:pre">		</span>__req_mod(req, SEND_CANCELED, peer_device, &=
amp;m);</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space=
:pre">		</span>spin_unlock_irq(&amp;connection-&gt;resource-&gt;req_lock);<=
br></div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre=
">		</span>if (m.bio)</div><div><span class=3D"gmail-Apple-tab-span" style=
=3D"white-space:pre">			</span>complete_master_bio(device, &amp;m);<br></di=
v><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</sp=
an>}<br></div></div><div>...</div><div>}</div><div><br></div><div>I think t=
wo functions might be exchanged like below</div><div>__req_mod(req, SEND_CA=
NCELED, peer_device, &amp;m);<br></div><div>tl_next_request_for_connection(=
connection);<br></div><div><br></div><div>Because some case(peer&#39;s rq_s=
tate with RQ_NET_QUEUE)=C2=A0</div><div>=C2=A0__req_mod(SEND_CANCELED) woul=
d call the advance_conn_req_next() function and then connection-&gt;todo.re=
q_next could be changed to next request.</div><div><br></div><div>__req_mod=
() ---&gt; changed next request</div><div>tl_next_request_for_connection --=
&gt; adjust the current request<br></div><div><br></div><div><br></div><div=
>But in original case,</div><div>tl_next_request_for_connection =C2=A0-&gt;=
 current req is same next request<br></div><div>__req_mod() -&gt; =C2=A0cha=
nged next request but can&#39;t adjust current request<br></div><div><br></=
div><div><br></div><div><br></div><div>Thanks</div><div>--</div></div></div=
><div hspace=3D"streak-pt-mark" style=3D"max-height:1px"><img style=3D"widt=
h:0px;max-height:0px;overflow:hidden" src=3D"https://mailfoogae.appspot.com=
/t?sender=3Daa21wYWtAbWFudGVjaC5jby5rcg%3D%3D&amp;type=3Dzerocontent&amp;gu=
id=3D0da268b7-abca-4cec-930e-38b14d08ce5b"><font color=3D"#ffffff" size=3D"=
1">=E1=90=A7</font></div>

--001a113acda017d830053d001ccc--
