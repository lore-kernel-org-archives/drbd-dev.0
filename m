Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 04F4114328
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 11:29:11 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Tue, 19 Oct 2004 11:30:24 +0200
References: <20041019091152.50E053BE6D@garcon.linbit.com>
In-Reply-To: <20041019091152.50E053BE6D@garcon.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410191130.24197.philipp.reisner@linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] r1600 - branches/drbd-0.7/drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 19 October 2004 11:11, svn@svn.drbd.org wrote:
> Author: lars
> Date: 2004-10-19 11:11:49 +0200 (Tue, 19 Oct 2004)
> New Revision: 1600
>
> Modified:
>    branches/drbd-0.7/drbd/drbd_int.h
>    branches/drbd-0.7/drbd/drbd_main.c
>    branches/drbd-0.7/drbd/drbd_receiver.c
>    branches/drbd-0.7/drbd/drbd_req.c
>    branches/drbd-0.7/drbd/drbd_worker.c
> Log:
> get rid of the HERE macro
> provide (experimental) code for decreasing latency on 2.6 kernels by
> pushing the tcp stack
>

Hi Lars,

Do you really think it is an good idea to put that tcp-stack pushing
into drbd-0.7 ??

- Do you know that it improves performance ? 
  Or is it just an assumption.

- Do we really want to do this with the stable code 
  I think we should have a least one or two reports from the list,
  that 
    a) it does not break anything
    b) it improves performance.

-philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
