Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Barrier assert failures with latest 8.0 sources
Date: Wed, 23 Jan 2008 08:53:26 -0500
Message-ID: <342BAC0A5467384983B586A6B0B3767107E89F4D@EXNA.corp.stratus.com>
In-Reply-To: 342BAC0A5467384983B586A6B0B3767107E89E95@EXNA.corp.stratus.com
References: <342BAC0A5467384983B586A6B0B3767107E89B46@EXNA.corp.stratus.com><342BAC0A5467384983B586A6B0B3767107E89D34@EXNA.corp.s
	tratus.com> 20080122162007.GD7594@barkeeper1.linbit
	342BAC0A5467384983B586A6B0B3767107E89E95@EXNA.corp.stratus.com
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

> I do feel that the situations when this can arise should be incredibly
> rare - the connection has to fail between issuing the first request
and
> the time it completes... and yet I can hit this problem fairly easily,
> so maybe there is some other situation I haven't thought of that
causes
> this path to be taken.
>=20

So, I was right to be concerned -- the _actual_ cause of the problem is
as follows:

1. tl_clear first runs through the TL and does a
req_mod(connection_lost)
   This _can_ cause requests to be completed and therefore can end up
   calling queue_barrier because this is the first request in the
current
   barrier. This means that CREATE_BARRIER can be set in the flags.

2. Then tl_clear reinitializes the transfer list but does not clear the
flag.

Thus pretty much anytime you lose the connection whilst there is traffic
in progress you run the risk of setting the flag and thereby setting
yourself up to create a new barrier incorrectly next time you connect.

I think the fixes are:

a. Don't do queue_barrier if the connection state is <Connected
b. Make sure the flag is clear in drbd_connect
c. Modify w_send_barrier to decrement the ap count if it decides to not
   send a barrier (e.g. if the connection is lost between the time the
   work item is queued and the time it runs).

Will submit patch once I've tested this...
Simon
