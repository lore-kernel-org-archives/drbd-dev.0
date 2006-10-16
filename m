Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 67F832DF652B
	for <drbd-dev@lists.linbit.com>; Mon, 16 Oct 2006 11:13:59 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: weirdness with netlink/connector
Date: Mon, 16 Oct 2006 11:13:58 +0200
References: <342BAC0A5467384983B586A6B0B3767103C3B980@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767103C3B980@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610161113.58450.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 13. Oktober 2006 21:02 schrieb Graham, Simon:
> We have noticed that when issuing a sequence of drbdadm secondary &
> primary commands, we get errors from the underlying drbdsetup command
> like this:
>
> [root@adam ~]# drbdadm secondary vm1.root.fs
> [root@adam ~]# drbdadm primary vm1.root.fs
> [root@adam ~]# drbdadm secondary vm1.root.fs
> No response from the DRBD driver! Is the module loaded?
>
> I noticed in the code that this error message is produced in a loop that
> keeps reading from the netlink socket until it gets the expected reply
> and also that there was some commented out trace code that would print
> info if an unexpected reply was seen so I enabled this and now see
> things like this:
>
> [root@adam ~]# drbdadm secondary vm1.root.fs
> [root@adam ~]# drbdadm primary vm1.root.fs
> INFO: got other message
> got seq: 110 ; ack 0
> exp seq: 1 ; ack 1849768433
> [root@adam ~]# drbdadm secondary vm1.root.fs
> INFO: got other message
> got seq: 111 ; ack 0
> exp seq: 1 ; ack 299691195
> No response from the DRBD driver! Is the module loaded?
>
> This is very reproducible and is presumably either due to the wrong size
> messages being sent by the kernel or some sort of data corruption in
> drbdsetup - I figured you guys might have a better handle on fixing this
> quickly!

Hi Simon,

I also noticed this already. It is simply a too small timeout in drbdsetup.
I just changed it from 300ms to 5 seconds.=20

BTW, the "other messages" are the status events broad casted by DRBD=20
on every state change. It is ok, that drbdsetup gets those messages.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
