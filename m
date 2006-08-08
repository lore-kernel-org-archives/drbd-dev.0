Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher EXP1024-RC4-SHA (56/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2FE5D2D99B58
	for <drbd-dev@lists.linbit.com>; Tue,  8 Aug 2006 17:01:49 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 trunk crashes if NegDReply received in reply
	toRSDataRequest
Date: Tue, 8 Aug 2006 17:01:47 +0200
References: <342BAC0A5467384983B586A6B0B3767103471180@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103471180@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608081701.48009.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 6. August 2006 18:18 schrieb Graham, Simon:
> Oh wait... that wont work -- the call to send the negative ack takes the
> epoch_entry* as a parameter...
>
> How about having a new routine that can send a negative ack based on a
> Data packet pointer? I don't like the idea of making drbd_aloc_ee able
> to handle this case as you will get a partially initialized epoch_entry*
> back in that case...
>

Again, I agree completely.

In adition I looked out for more drbd_alloc_ee() and moved them after
the inc_local() statement....

Please check my patch
http://lists.linbit.com/pipermail/drbd-cvs/2006-August/001180.html

=2Dphilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
