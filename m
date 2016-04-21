Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 099F51056453
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 15:48:12 +0200 (CEST)
Received: by mail-vk0-f42.google.com with SMTP id n62so98639101vkb.0
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 06:48:12 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Apr 2016 22:48:11 +0900
Message-ID: <CAF6H8oFWgKL3W5eeBeisDhk9Ldjm5YKUpKR0jUL-xtOmVbmS4Q@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114364fe0819550530fef6a3
Subject: [Drbd-dev]  [CASE-29] After re-connect,
 WFBitMapS-WFBitMapT status has sustained continuously and copy
 command hangs
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

--001a114364fe0819550530fef6a3
Content-Type: text/plain; charset=UTF-8

Hi,

We wrote some temporary solution to avoid file copy hang problem.
We inserted wake_up function for sender_work queue after  _req_mod(req,
QUEUE_FOR_SEND_OOS, peer_device).
Please check following code in drbd_process_write_request function.

drbd_process_write_request ()
{

  ........


} else if (drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size))

#ifdef _WIN32_V9 // Windows DRBD
{
    _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device);
    if(peer_device->repl_state[NOW] == L_WF_BITMAP_S)
    {
        wake_up(&peer_device->connection->sender_work.q_wait);
    }
}
#else
    _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device); // Linux Org
#endif

}

What do you think about this idea?

Thanks.

--001a114364fe0819550530fef6a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,
<div><br></div><div>We wrote some temporary solution to avoid file copy han=
g problem.</div><div>We inserted wake_up function for sender_work queue aft=
er =C2=A0_req_mod(req, QUEUE_FOR_SEND_OOS, peer_device).</div><div>Please c=
heck following code in drbd_process_write_request function.<br><br>drbd_pro=
cess_write_request ()</div><div>{</div><div><br></div><div>=C2=A0 ........<=
/div><div><br></div><div><br>} else if (drbd_set_out_of_sync(peer_device, r=
eq-&gt;i.sector, req-&gt;i.size))<div><br>#ifdef _WIN32_V9 // Windows DRBD<=
br>{<br>=C2=A0 =C2=A0 _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device);<br>=
=C2=A0 =C2=A0 if(peer_device-&gt;repl_state[NOW] =3D=3D L_WF_BITMAP_S)<br>=
=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wake_up(&amp;peer_device-&gt=
;connection-&gt;sender_work.q_wait);<br>=C2=A0 =C2=A0 }<br>}<br>#else<br>=
=C2=A0 =C2=A0 _req_mod(req, QUEUE_FOR_SEND_OOS, peer_device); // Linux Org<=
br>#endif<br></div></div><div><br></div><div>}</div><div><br></div><div>Wha=
t do you think about this idea?</div><div><br></div><div>Thanks.</div><div>=
<br></div><div><br></div></div>

--001a114364fe0819550530fef6a3--
