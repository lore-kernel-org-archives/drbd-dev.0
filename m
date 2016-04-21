Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
	[209.85.213.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6303D1056456
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 16:01:57 +0200 (CEST)
Received: by mail-vk0-f54.google.com with SMTP id t129so99173852vkg.2
	for <drbd-dev@lists.linbit.com>; Thu, 21 Apr 2016 07:01:57 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Apr 2016 23:01:56 +0900
Message-ID: <CAF6H8oFVMK8vNg9jTBwZRThPtkBBb83jLXcej99whLC92+uO7A@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a114325ec350c8d0530ff27b5
Subject: [Drbd-dev]  [CASE-41] After re-connected,
 despite of OOS remaining primary does not start re-synchronization
 or continues AHEAD mode.
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

--001a114325ec350c8d0530ff27b5
Content-Type: text/plain; charset=UTF-8

Hi,

We wrote some temporary solution to avoid "continues AHEAD mode problem".
We cleared AHEAD_TO_SYNC_SOURCE and forced drbd_uuid_new_current
at conn_disconnect.

Please check following codes;


1. drbd_disconnected()
{

 .....

drbd_md_sync(device);

if (get_ldev(device)) {
    drbd_bitmap_io(device, &drbd_bm_write_copy_pages, "write from
disconnected",
                 BM_LOCK_BULK | BM_LOCK_SINGLE_SLOT, peer_device);
    put_ldev(device);
}

#ifdef _WIN32_V9 // temporary patch (clear AHEAD_TO_SYNC_SOURCE flag)
clear_bit(AHEAD_TO_SYNC_SOURCE, &device->flags); //  Windows DRBD
#endif

}



2. conn_disconnect()
{

... at the end of this function.

#ifdef _WIN32_V9 // (don't create uuid when primary is
drbdadm-disconnected) temporary patch

 if( (resource->role[NOW] == R_PRIMARY)
 {
        test_and_clear_bit(NEW_CUR_UUID, &device->flags);
        mutex_lock(&resource->conf_update);
        drbd_uuid_new_current(device, false);
        mutex_unlock(&resource->conf_update);
 }
#endif

}

What do you think about this idea?

But we have no idea to resolve "OOS remaining problem" yet.
Please check "despite of OOS remaining primary does not start
re-synchronization" problem.

Thanks.

--001a114325ec350c8d0530ff27b5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>We wrote some temporary solution to avoid &quot=
;continues AHEAD mode problem&quot;.<br>We cleared AHEAD_TO_SYNC_SOURCE and=
 forced drbd_uuid_new_current at=C2=A0conn_disconnect.<div><br>Please check=
 following codes;<br><br><br>1. drbd_disconnected()<br>{</div><div><br>=C2=
=A0.....=C2=A0</div><div><br>drbd_md_sync(device);<br><br>if (get_ldev(devi=
ce)) {<br>=C2=A0 =C2=A0 drbd_bitmap_io(device, &amp;drbd_bm_write_copy_page=
s, &quot;write from disconnected&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BM_LOCK_BULK | BM_LOCK_SINGLE_SLOT, peer_dev=
ice);<br>=C2=A0 =C2=A0 put_ldev(device);<br>}<br><br>#ifdef _WIN32_V9 // te=
mporary patch (clear AHEAD_TO_SYNC_SOURCE flag)<br>clear_bit(AHEAD_TO_SYNC_=
SOURCE, &amp;device-&gt;flags); // =C2=A0Windows DRBD<br>#endif<br><br>}</d=
iv><div><br></div><div><br><br>2. conn_disconnect()</div><div>{<br><br>... =
at the end of this function.</div><div><br>#ifdef _WIN32_V9 // (don&#39;t c=
reate uuid when primary is drbdadm-disconnected) temporary patch<br><br>=C2=
=A0if( (resource-&gt;role[NOW] =3D=3D R_PRIMARY) <br>=C2=A0{<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 test_and_clear_bit(NEW_CUR_UUID, &amp;device-&gt;flags);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;resource-&gt;conf_update);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 drbd_uuid_new_current(device, false);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;resource-&gt;conf_update);<br>=
=C2=A0}<br>#endif <br><br>}</div><br>What do you think about this idea?<div=
><br><div>But we have no idea to resolve &quot;OOS remaining problem&quot; =
yet.<br>Please check &quot;despite of OOS remaining primary does not start =
re-synchronization&quot; problem.<br><br>Thanks.
</div></div><div><br></div></div>

--001a114325ec350c8d0530ff27b5--
