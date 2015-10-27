Return-Path: <tpoluri@mvista.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 717D110556D9
	for <drbd-dev@lists.linbit.com>; Tue, 27 Oct 2015 07:18:34 +0100 (CET)
Received: by wicll6 with SMTP id ll6so144200612wic.0
	for <drbd-dev@lists.linbit.com>; Mon, 26 Oct 2015 23:18:33 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Oct 2015 11:40:34 +0530
Message-ID: <CAM8gD7Xvm3=UU=M0nZcdL-ByJ4noJbxJqMe0D1=rG2=TQ_SSbA@mail.gmail.com>
From: Tejaswini Poluri <tpoluri@mvista.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=bcaec53f2feb90079305230fefe1
Subject: [Drbd-dev] Understanding barriers in DRBD
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

--bcaec53f2feb90079305230fefe1
Content-Type: text/plain; charset=UTF-8

Hii all,

I have been trying to solve an issue on DRBD-8.3 branch since a month and
could not yet find a solution.  We have a iscsid secondary disk and a
primary drbd mounted disk using protocol B and are in sync.  During writing
in the primary when the network of the iscsi disk of secondary is down, the
request timer function is supposed to be triggered within ko-count time and
the primary should change the connection state to Timeout and then to
Network Failure state. This is happening in Protocol C and not is not
working in Protocol B.

During debugging, we came to stage where  even after the iscsi disk is in
blocked state the Primary sends *w_send_barrier* continuously even though
there is no *BarrierAck.*

I would like to understand the implementation of barriers and barrier acks
of DRBD in more detail. I think there could be some synchronization problem
of barriers for every epoch. It would be great if someone could share me
some pointers about barrier acks,


Regards,
Tejaswini

--bcaec53f2feb90079305230fefe1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hii all,=C2=A0<div><br></div><div>I have been trying to so=
lve an issue on DRBD-8.3 branch since a month and could not yet find a solu=
tion.=C2=A0 We have a iscsid secondary disk and a primary drbd mounted disk=
 using protocol B and are in sync.=C2=A0 During writing in the primary when=
 the network of the iscsi disk of secondary is down, the request timer func=
tion is supposed to be triggered within ko-count time and the primary shoul=
d change the connection state to Timeout and then to Network Failure state.=
 This is happening in Protocol C and not is not working in Protocol B.=C2=
=A0</div><div><br></div><div>During debugging, we came to stage where=C2=A0=
=C2=A0even after the iscsi disk is in blocked state the Primary sends <b>w_=
send_barrier</b> continuously even though there is no <b>BarrierAck.</b></d=
iv><div><br></div><div>I would like to understand the implementation of bar=
riers and barrier acks of DRBD in more detail. I think there could be some =
synchronization problem of barriers for every epoch. It would be great if s=
omeone could share me some pointers about barrier acks,</div><div><br></div=
><div><br></div><div>Regards,</div><div>Tejaswini</div><div><br></div><div>=
<br></div></div>

--bcaec53f2feb90079305230fefe1--
