Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id CE9BD2D99B53
	for <drbd-dev@lists.linbit.com>; Tue,  8 Aug 2006 15:43:44 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in reply to
	RSDataRequest
Date: Tue, 8 Aug 2006 15:43:46 +0200
References: <342BAC0A5467384983B586A6B0B3767103471178@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103471178@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608081543.46668.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 6. August 2006 04:29 schrieb Graham, Simon:
> When an RSDataRequest is sent, the block_id field in the request is set
> to SYNCER_ID (-1) - if the receiver is unable to process the request
> (e.g. if the receiver doesn't have good data) then it sends back a
> NegDReply with the same block_id - on the origin side, got_NegDReply
> attempts to validate the block_id value using drbd_pr_verify which
> promptly crashes attempting to reference the master_bio field to get the
> sector (drbd_req_get_sector()).
>
> I found this testing my fixes for removing panic() calls on meta data
> read/write failures but I thought it was worth bugging separately;
> clearly this routine needs to validate the request pointer before
> attempting to access it at all, but also we should have got a
> NedRSDreply in this case - so there are at least two bugs here:
>
> 1. The target side should have send a NegRSDreply in this case;
> receive_DataRequest should switch on h->command
>    to decide what response to send when it bails early

Right.=20

> 2. drbd_pr_verify should NOT call drbd_req_get_sector() before
> validating the pointer - is there any reason why
>    it shouldn't use the sector value passed in as a parameter?

You are completely right. I guess this is a copy-n-paste error.
It should definitely use the passed parameter and not
call drbd_req_get_sector().

> I can make patches for these when we agree on the right solution...
>

I did the patching myself, in that cases. Please verify my
changes:
http://lists.linbit.com/pipermail/drbd-cvs/2006-August/001179.html

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
