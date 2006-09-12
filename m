Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] Crash in _req_may_be_done()
Date: Tue, 12 Sep 2006 10:00:21 -0400
Message-ID: <342BAC0A5467384983B586A6B0B37671038B027C@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Philipp Reisner" <philipp.reisner@linbit.com>, <drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp,

> Ok, I just document here my findings, in case Simon works on the same,
> I do not want that we hunt the same bugs ...
>=20
> Currently I run drbd in my UML setup and hit a crash in.
> _req_may_be_done()
>=20

I think I may be looking at the same thing although it's tricky to
locate the source code from the optimized binary. I am certainly seeing
a crash in _req_may_be_done I just haven't figured out where yet (too
much inlined optimized code!)

My plan is to take your new instrumentation this morning and run again
but I'll also watch out for any updates from you.

Simon

PS: re -=20

> To understand how this came I added that VERBOSE_REQUEST_CODE
>=20
> [42950452.520000] drbd0: _req_mod(a101c744,to_be_submitted)
> [42950452.520000] drbd0: _req_mod(a101c744,completed_ok)
> [42950452.520000] drbd0: _req_may_be_done(a101c744 L-coN-----)
>            *******   without modifications it would crash here
> **********
> [42950452.540000] drbd0: _req_mod(a101c744,to_be_send)
> [42950452.540000] drbd0: _req_mod(a101c744,to_be_submitted)
> [42950452.540000] drbd0: _req_mod(a101c744,queue_for_net_write)
> [42950452.540000] drbd0: _req_mod(a101c744,handed_over_to_network)
> [42950452.540000] drbd0: _req_may_be_done(a101c744 Lp--Np-s--)
> [42950452.540000] drbd0: _req_mod(a101c744,completed_ok)
> [42950452.540000] drbd0: _req_may_be_done(a101c744 L-coNp-s--)
> [42950452.540000] drbd0: _req_mod(a101c744,recv_acked_by_peer)
> [42950452.540000] drbd0: _req_may_be_done(a101c744 L-coN--s-o)
>=20
> What we see here is, that UML's block layer finishes the write of the
> block before we even mark the request that it should be sent.
> Strange, since the code in drbd_make_request_common() is:
>=20

Well, Are you talking about the 1st few lines in the list above? Where
the order is to_be_submitted, completed_ok, to_be_send, to_be_submitted?
If so, I would suspect that the lines AFTER the crash location are for a
different request that happens to use the same req structure... It might
be a good idea to implement some sort of monotonically increasing
sequence number for each drbd_req_new() that is done and output that in
the trace (the address of the req structure is really not very
interesting for debugging anyway) -- an additional atomic_increment
inside drbd_req_new shouldn't be too bad...

