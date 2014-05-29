Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 02CCC101AC76
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:29:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E02E6302E31
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:29:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wHCHYBsJG5pF for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:29:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id C2663302EAE
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:29:17 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uwgGDOspZWhq for <drbd-dev@lists.linbit.com>;
	Thu, 29 May 2014 23:29:17 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id A7C3B302E31
	for <drbd-dev@lists.linbit.com>; Thu, 29 May 2014 23:29:17 +0200 (CEST)
Date: Thu, 29 May 2014 23:29:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20140529212917.GC6434@soda.linbit>
References: <065690d908f4c5aaeba8d8763c41a764@ugr.es>
	<20140527224053.GD17111@soda.linbit>
	<85bebd869def7c9ebf198ee72baef5ba@ugr.es>
	<20140528115654.GH17111@soda.linbit>
	<41bcdaf0897e6ebd1d919e7675c7f385@ugr.es>
	<20140528124957.GI17111@soda.linbit>
	<fb84d1d109a3575156acc44b4e6d1d00@ugr.es>
	<20140528183616.GJ17111@soda.linbit>
	<9eb0a7ed7c21820d13febc89c63dc340@ugr.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9eb0a7ed7c21820d13febc89c63dc340@ugr.es>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] Protocol C
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

On Thu, May 29, 2014 at 12:45:32PM +0200, raulhp wrote:
>=20
>=20
> El 2014-05-28 20:36, Lars Ellenberg escribi=F3:
> >On Wed, May 28, 2014 at 05:25:28PM +0200, raulhp wrote:
> >>
> >>
> >>El 2014-05-28 14:49, Lars Ellenberg escribi=F3:
> >>>On Wed, May 28, 2014 at 02:32:05PM +0200, raulhp wrote:
> >>>>Hi Lars,
> >>>>
> >>>>Thanks so much, I focus only the replication link, the first
> >>develop
> >>>>is implement the replication to n servers with reliable multicast,
> >>>>ensuring the write in the remote disk.
> >>>>
> >>>>Can you explain me this ? Where? ---> You would need to find the
> >>>>"relevant" requests on the resource->transfer_log()
> >>>
> >>>See in drbd_send_and_submit(), and helpers, e.g.
> >>>drbd_process_write_request,
> >>>where the requests are put on the transfer log in incoming order.
> >>>
> >>>The drbd sender threads (wait_for_sender_todo, process_one_request)
> >>>find them there, and send them.
> >>>
> >>>The drbd asender thread receives the acks (or, in your case
> >>>the retransmit requests), needs to validate thes acks (or neg acks,
> >>>or retrsnamit requests), and change the state of the respective
> >>>request
> >>>object.
> >>>
> >>>That's what happens in got_BlockAck and friends.
> >>All this it=B4s ok!
> >>
> >>>Now you want to implement some mcast.
> >>>I don't know what information you envison to have,
> >>>what would make you ask for retransmit,
> >>>what exactly you would ask for,
> >>>what information you could use in your got_retransmit_request
> >>>function.
> >>>
> >>I want to implement a mcast with NACK, where the receiver send NACK
> >>message to the sender when the receiver detects a loss packet, and
> >>the sender send the packet in question, with this is possible
> >>guarantee all writes in the remote node and reduce the traffic in
> >>the network.
> >>
> >>>But the drbd_request will stay linked on the resource->transfer_log
> >>>until it is "acked", or "cleaned up" due to connection loss.
> >>
> >>It=B4s ok
> >>
> >>>Depending on the information you have in that restransmit request,
> >>>you will be able to find the relevant requests on that transfer
> >>log.
> >>>I don't know what information you have, so I cannot tell how to
> >>best
> >>>find them.
> >>>
> >>>Non-relevant are:
> >>>  those that have not been sent yet (to that peer)
> >>>  those that have already been ACKed (by that peer)
> >>>Which means that relevant are
> >>>  those that have been sent, but not acked,
> >>>  and fall in whatever "range" you request to be restransmitted.
> >>This is ok, but with Multicast communication is necesary to use UDP
> >>Protocol with Reliability.
> >
> >Of course.
> >So?
> >
> >We already have a "NACK", in the DRBD protocol,
> >which carries the meaning "failed to serve this request"
> >(the IO subsystem of the peer reported failure).
>=20
> The NACK in te DRBD protocol is used in Protocol C? or?

Always.

You do realize that there is
  * the transport protocol (TCP)
  * the DRBD protocol

*BOTH*
tcp and DRBD-protocol have "acks" and "nacks",
and they mean different things.

DRBD ACKs (actually: P_WRITE_ACK in protocol C, for other variants see
enum drbd_packet) mean that the corresponding request has been completed
by the remote disk.

DRBD NACKs (P_NEG_ACK) mean that the remote disk was not able to process
the request, or tried and failed (IO-error).

On the TCP level, the TCP acks and stuff has the TCP meaning.

With a "reliable multicast transport" for DRBD,
you will need transport specific messages.
the DRBD protocol on top of that won't care much,
as long as it eventually gets the P_WRITE_ACK
or P_NEG_ACK.

> >Lets not overload the term "nack",
> >and use the term "retransmit request",
> >because that is basically what a "nack"
> >in any reliable multicast protocol is supposed to trigger:
> >retransmit of not received messages.
>=20
> Yes, the term "NACK" works well

I just tried to explain why the term NACK does NOT work,
and why I suggest to use retransmit request instead :-/

> >Am I misunderstanding your question?
> You understand my question :-) only y want to understand how to use
> existing code of ACK for multicast

I don't think it works that way.

--=20
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
