Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Date: Wed, 23 Jan 2008 09:03:27 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E89F55@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107E89F4D@EXNA.corp.stratus.com>
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.s
	tratus.com> 20080122162007.GD7594@barkeeper1.linbit
	342BAC0A5467384983B586A6B0B3767107E89E95@EXNA.corp.stratus.com
	<342BAC0A5467384983B586A6B0B3767107E89F4D@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	"Lars Ellenberg" <lars.ellenberg@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> I think the fixes are:
>=20
> a. Don't do queue_barrier if the connection state is <Connected
> b. Make sure the flag is clear in drbd_connect
> c. Modify w_send_barrier to decrement the ap count if it decides to
not
>    send a barrier (e.g. if the connection is lost between the time the
>    work item is queued and the time it runs).
>=20

Scratch item c) -- tl_clear already does this...
/simgr
