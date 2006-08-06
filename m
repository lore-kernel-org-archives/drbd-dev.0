Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 5 Aug 2006 22:29:11 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103471178@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in reply to
	RSDataRequest
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

When an RSDataRequest is sent, the block_id field in the request is set
to SYNCER_ID (-1) - if the receiver is unable to process the request
(e.g. if the receiver doesn't have good data) then it sends back a
NegDReply with the same block_id - on the origin side, got_NegDReply
attempts to validate the block_id value using drbd_pr_verify which
promptly crashes attempting to reference the master_bio field to get the
sector (drbd_req_get_sector()).

I found this testing my fixes for removing panic() calls on meta data
read/write failures but I thought it was worth bugging separately;
clearly this routine needs to validate the request pointer before
attempting to access it at all, but also we should have got a
NedRSDreply in this case - so there are at least two bugs here:

1. The target side should have send a NegRSDreply in this case;
receive_DataRequest should switch on h->command=20
   to decide what response to send when it bails early
2. drbd_pr_verify should NOT call drbd_req_get_sector() before
validating the pointer - is there any reason why=20
   it shouldn't use the sector value passed in as a parameter?

I can make patches for these when we agree on the right solution...

Simon

