Return-Path: <gniv@cs.umass.edu>
Received: (from apache@localhost)
	by loki.cs.umass.edu (8.13.7/8.13.1/Submit) id k7OIPDWp017063
	for drbd-dev@lists.linbit.com; Thu, 24 Aug 2006 14:25:13 -0400
Message-ID: <1156443913.44edef0904c2c@mail.cs.umass.edu>
Date: Thu, 24 Aug 2006 14:25:13 -0400
From: gniv@cs.umass.edu
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] DRBD-filesystem interaction
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I am a student who is looking to understand how DRBD interacts with the file
system for a project. I have looked through the code, but could use some help
(maybe a basic overview) figuring out the flow of operations from the time the
operating system opens a file and writes to it, to DRBD performing replication;
i.e. how DRBD listens to/intercepts system calls.
I understand what happens after DRBD gets the request, just looking for the
parts before that time.

Thanks,
Gal

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
