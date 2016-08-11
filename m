Return-Path: <kmpak@mantech.co.kr>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 31A8B1056312
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2016 07:48:40 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id l203so88217104oib.1
	for <drbd-dev@lists.linbit.com>; Wed, 10 Aug 2016 22:48:40 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Date: Thu, 11 Aug 2016 14:48:38 +0900
Message-ID: <CALLFrTQW43=D8kJ4Z+rJV=+Dk4BBOA_0hT1rOxFRcqrBAa0K2A@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a113d13805114600539c551af
Subject: [Drbd-dev] Failed to reconnect in different volume's size over the
	3 nodes
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

--001a113d13805114600539c551af
Content-Type: text/plain; charset=UTF-8

Hello

After 2 commit below
585554e drbd: resize: reduce own sanity checks, trust peer
c09ce4b drbd: resize loop avoidance band-aid

It can't reconnect  just in case different volume's size.
That was only occurred over the 3 nodes configuration.

The scenario is below

A(100mb) - B(100mb) - C(90mb)
1. Success to connect at Inconsistent state
2. C node does "Primary --force "
3. All nodes agree 90mb size
4. C node does down
5. A node does down
6. A node does up
7. A and b agree 100mb size
8. C node can't connect because of lower size



I was looking for the code,and I think it was recalculated forcibly because
below

in receive_sizes()
/* Maybe the peer knows something about peers I cannot currently see. */
if (is_handshake)
ddsf |= DDSF_FORCED;


Thank you,

--001a113d13805114600539c551af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div>Hello</div><div><br></div><div>Afte=
r 2 commit below</div><div>585554e drbd: resize: reduce own sanity checks, =
trust peer</div><div>c09ce4b drbd: resize loop avoidance band-aid</div><div=
><br></div><div>It can&#39;t reconnect =C2=A0just in case different volume&=
#39;s size.<br></div><div>That was only occurred over the 3 nodes configura=
tion.</div><div><br></div><div>The scenario is below</div><div><br></div><d=
iv>A(100mb) - B(100mb) - C(90mb)</div><div>1. Success to connect at Inconsi=
stent state</div><div>2. C node does &quot;Primary --force &quot;</div><div=
>3. All nodes agree 90mb size</div><div>4. C node does down</div><div>5. A =
node does down</div><div>6. A node does up</div><div>7. A and b agree 100mb=
 size</div><div>8. C node can&#39;t connect because of lower size</div><div=
><br></div><div><br></div><div><br></div><div><div>I was looking for the co=
de,and I think it was recalculated forcibly because below</div><div><br></d=
iv><div>in=C2=A0receive_sizes()</div><div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>/* Maybe the peer knows something about peers I cann=
ot currently see. */</div><div><span class=3D"" style=3D"white-space:pre">	=
</span>if (is_handshake)</div><div><span class=3D"" style=3D"white-space:pr=
e">		</span>ddsf |=3D DDSF_FORCED;</div></div></div><div><br></div><div><br=
></div><div>Thank you,</div><div><br></div>
</div>

--001a113d13805114600539c551af--
