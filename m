Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5AD7A2E08420
	for <drbd-dev@lists.linbit.com>; Fri, 18 May 2007 10:05:10 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 18 May 2007 10:05:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705181005.09112.philipp.reisner@linbit.com>
Subject: [Drbd-dev] DRBD-8.1
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi There,

There are a number of patches and minor features to get integrated
into drbd-8. Therefore I copied over the trunk to branches/drbd-8.0.

We will integrate bugfixes in the 8.0 branch, and do the new
features in the trunk which will be released as 8.1 when it is
ready. (The bugfixes get merged from 8.0 to 8.1 with the svnp tool)

8.0 and 8.1 will be write protocol compatible. (If the netlink
protocol will be compatible as well will turn out during the merge
of the "many devices patch".)

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
