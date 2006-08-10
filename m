Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1AAD12D99950
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2006 11:49:06 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - after_state_ch() can attempt to terminate
	worker thread with wait==true
Date: Thu, 10 Aug 2006 11:49:06 +0200
References: <342BAC0A5467384983B586A6B0B37671034711DB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671034711DB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608101149.07279.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 7. August 2006 15:33 schrieb Graham, Simon:
> 3. In receive_state() -- should after_state_ch() be called at all if the
> preceding call to _drbd_set_state fails? It seems a
>    bit wrong to me to pass in the new state to after_state_ch when you
> know this does not represent the actual new state...
>
> 4. Ditto receive_outdate().

Ok, forgot to fix the issue 4 up to now.=20
=46ied it with this commit.
http://lists.linbit.com/pipermail/drbd-cvs/2006-August/001184.html

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
