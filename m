Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 5149D1056330
	for <drbd-dev@lists.linbit.com>; Mon, 11 Apr 2016 08:54:42 +0200 (CEST)
Received: by mail-vk0-f42.google.com with SMTP id e185so200431047vkb.1
	for <drbd-dev@lists.linbit.com>; Sun, 10 Apr 2016 23:54:42 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 Apr 2016 15:54:41 +0900
Message-ID: <CAF6H8oEnzKcY5rLVoSXNiB6bCO87oKqh6Y4w+Vm2yDXrWf77tg@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a113d0d8ada24f90530300461
Subject: [Drbd-dev] [CSE-39] changes to standalone status on disconnecting
	phase.
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

--001a113d0d8ada24f90530300461
Content-Type: text/plain; charset=UTF-8

Dear Phil.

Sometime, the resource goes to standalone status on disconnecting phase.
So, we change the code like this;

void drbd_send_acks_wf(struct work_struct *ws)
{
   ....

#ifdef _WIN32
    if (err)
         change_cstate(connection, C_NETWORK_FAILURE, CS_HARD); // CHAGNE
from C_DISCONNECTING to C_NETWORK_FAILURE
#else
    if (err)
         change_cstate(connection, C_DISCONNECTING, CS_HARD);
#endif
}



On V8.4.7, the same position code is C_NETWORK_FAILURE, as follows;

void drbd_send_acks_wf(struct work_struct *ws)
{
        .....
        if (err) {
             conn_request_state(connection, NS(conn, C_NETWORK_FAILURE),
CS_HARD);
             return;
        }
       .....
}


What do you think about our solution to prohibit from changing standalone
on disconnecting phase?

Thanks.

--001a113d0d8ada24f90530300461
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Phil.<br><br>Sometime, the resource goes to standalon=
e status on disconnecting phase.<br>So, we change the code like this;<br><b=
r>void drbd_send_acks_wf(struct work_struct *ws)<br>{<br>=C2=A0 =C2=A0....<=
br><br>#ifdef _WIN32<br>=C2=A0 =C2=A0 if (err)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0change_cstate(connection, C_NETWORK_FAILURE, CS_HARD); // CHAGNE =
from C_DISCONNECTING to C_NETWORK_FAILURE<br>#else<br>=C2=A0 =C2=A0 if (err=
)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0change_cstate(connection, C_DISCONNE=
CTING, CS_HARD);<br>#endif<br>}<br><br><br><br>On V8.4.7, the same position=
 code is C_NETWORK_FAILURE, as follows;<br><br>void drbd_send_acks_wf(struc=
t work_struct *ws)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .....<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (err) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0conn_request_state(connection, NS(conn, C_NETWORK_FAILURE), CS_HARD);=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0.....<br>}<br><br><br>Wha=
t do you think about our solution to prohibit from changing standalone on d=
isconnecting phase?<br><br>Thanks.<br>
<div><br></div><div><br></div></div>

--001a113d0d8ada24f90530300461--
