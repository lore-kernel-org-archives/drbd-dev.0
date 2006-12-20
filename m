Return-Path: <home_king@163.com>
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by mail.linbit.com (LINBIT Mail Daemon) with SMTP id A7A6E2DEACCF
	for <drbd-dev@lists.linbit.com>; Wed, 20 Dec 2006 08:27:04 +0100 (CET)
Message-ID: <4588E111.8090102@163.com>
Date: Wed, 20 Dec 2006 15:06:57 +0800
From: home_king <home_king@163.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] About the UUID
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

hi, Philipp.

Now drbd-0.8.x uses UUID instead of GC as the data-relationship-detection
-tool, right? Its logic seems clearer than GC. However, I am confused
about the UUID in the two-primaries-healedpartition scenario.

Given the original uuids below (both nodes are connected):
P <5,0,0,0>      S <5,0,0,0>
then, I plug out the wire of the primary node (disconnected):
P <6,5,0,0>      S <5,0,0,0>
I let the downgraded secondary become new primary, UUID should become:
P <6,5,0,0>      S <6,5,0,0>
Finally, I recover the wire of primary. And Now, there comes my problem.
Accordding to the UUID algorithm, when Cs == Cp, no resynchronisation
necessary. However it is obviously split-brain, and drbd ignores it.

Why?

BTW, I did not test such scenario, because I can't compile drbd-0.8.x
in my RedHat AS4 distro. I just browsed the doc & code. :-)

Regards,
luo.jinhua


