Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 901341430A
	for <drbd-dev@lists.linbit.com>; Mon,  8 Nov 2004 13:36:19 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 8 Nov 2004 13:38:09 +0100
References: <20041024112015.D1DD53BE6D@garcon.linbit.com>
In-Reply-To: <20041024112015.D1DD53BE6D@garcon.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411081338.10061.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1611 - branches/drbd-0.7/drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sunday 24 October 2004 13:20, svn@svn.drbd.org wrote:
> Author: lars
> Date: 2004-10-24 13:20:13 +0200 (Sun, 24 Oct 2004)
> New Revision: 1611
>
> Modified:
>    branches/drbd-0.7/drbd/drbd_receiver.c
> Log:
> * wake_up_interruptible did not wake up threads in wait_even(cstate)
> * down_interruptible in drbd_send_handshake, just in case some drbdsetup
> kills us
>


Lars,

One last DRBD related question before your get on the plain.
Does this fix this "deadlock in WFConnection state", which was
discussed on the list ? 

 I want to release 0.7.6 soon, and it would be nice to know
 for the changelog.

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
