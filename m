Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep12-int.chello.at (viefep12-int.chello.at [213.46.255.25])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4E8F5142F9
	for <drbd-dev@lists.linbit.com>; Wed, 20 Oct 2004 18:17:28 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep12-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20041020161727.OSHJ25452.viefep12-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Wed, 20 Oct 2004 18:17:27 +0200
Message-ID: <41768F97.60206@wollmersdorfer.at>
Date: Wed, 20 Oct 2004 18:17:27 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] user interface test of drbd.conf
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I did some systematic test cases with the parameters and options against 
the man page.

As we do not have documents like Requirement Definition, Detailed 
Functional Specification, Interface Specification (same is true for most 
OSS/GPL projects), the documentation is the only source of "promised 
functionality".

Differences between docu and program behaviour mean wrong docu, wrong 
program, or both wrong.

Enough theory.

Here are some items:

Version 0.7.5
Method: drbdadm -d up all

1) Problem report
-----------------
docu quote:
| minor-count count
|   count may be a number from 1 to 255.

count 	expected-result	test-result
1 	valid   	passed
0 	invalid   	failed
-1 	invalid   	passed
255 	valid   	passed
256 	invalid   	failed
260 	invalid   	failed

Problem description: Parser accepts invalid values.
(assumed) generic requirement: Invalid values should be reported as 
error as near as possible to the interface. Invalid values should not 
enter a system and cause errors in later steps, or other components, or 
in worst case crash the system.

2) Problem report
-----------------
docu quote:
wfc-timeout
The sign is important.
Always use a negative value, positive will (try to) force
primary status, which is not what you want, if it  has  outdated
data.  Default is 0, which means unlimited. Unit is seconds.


100000 valid passed

Problem description: Very high, maybe senseless values are accepted.
 From my experience as tester I will not expect, that _any_ values will 
work correctly without "dry-run". Same is true for other values in 
drbd.conf.

BTW: An appropriate problem tracking system like bugzilla would be nice.

Helmut Wollmersdorfer


