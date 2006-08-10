Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 85AA72D99950
	for <drbd-dev@lists.linbit.com>; Thu, 10 Aug 2006 11:55:39 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 - after_state_ch() can attempt to terminate
	worker thread with wait==true
Date: Thu, 10 Aug 2006 11:55:40 +0200
References: <342BAC0A5467384983B586A6B0B37671034711DB@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671034711DB@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200608101155.41001.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 7. August 2006 15:33 schrieb Graham, Simon:
> Near the end of after_state_ch() there are several clauses that stop
> (and restart) receiver and worker threads synchronously - since this
> function is called from both the worker and receiver thread context,
> these calls cannot be made synchronously (and an ASSERT in
> _drbd_thread_stop will fire).
>
> There seem to be a couple of issues here:
>
> 1. Is it the intention that after_state_ch is always called from the
> worker thread? If so, then the calls in drbd_receiver and
>    drbd_fs need to change to submit work items
>
> 2. No matter what, it should not issue synchronous calls to
> drbd_thread_stop for non-current threads.
>

I have to admit that I do not know myself how to do this right by now.

I wanted to get all those drbd_thread_stop*() calls spread all over the
code (usually happening if a state change was successfull) into a
central place.

The right solution probably is to use the asynchronous versions
in the after_state_ch() function, and to create aditional functions
with the semantics of wait_thread() , that can be used in that
some places after the successfull state change....

Will do this somewhen next week.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
