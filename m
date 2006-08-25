Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 7F0D62CF555E
	for <drbd-dev@lists.linbit.com>; Fri, 25 Aug 2006 07:57:21 +0200 (CEST)
Date: Fri, 25 Aug 2006 07:57:22 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20060825055722.GC8443@soda.linbit>
References: <1156443913.44edef0904c2c@mail.cs.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156443913.44edef0904c2c@mail.cs.umass.edu>
Subject: [Drbd-dev] Re: DRBD-filesystem interaction
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-08-24 14:25:13 -0400
\ gniv@cs.umass.edu:
> Hi,
> 
> I am a student who is looking to understand how DRBD interacts with
> the file system for a project.

it does not. the file system interacts with us...
we are a block device, we don't know nothing about file systems.
"something" submits a block request (generic_make_request, submit_bio
and the like in the generic kernel code), which ends up in
drbd_make_request_*, where we do the housekeeping and send the data to
our peer, and submit it locally to the layers below us and so on.

but we don't care at all about what is being written,
and whether it is a file system or anything else that is writing to us.

> I have looked through the code, but could use some help (maybe a basic
> overview) figuring out the flow of operations from the time the
> operating system opens a file and writes to it, to DRBD performing
> replication; i.e. how DRBD listens to/intercepts system calls.

it does not.
we are a block device driver, we register as such (register_blkdev).
any block device has a request queue, and we register our custom
make_request_fn on it: blk_queue_make_request(q, drbd_make_request_26);

that is all there is to it to get requests delivered to us.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
