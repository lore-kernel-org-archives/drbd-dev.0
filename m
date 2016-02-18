Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
	[209.85.213.44]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 621141056323
	for <drbd-dev@lists.linbit.com>; Thu, 18 Feb 2016 06:45:48 +0100 (CET)
Received: by mail-vk0-f44.google.com with SMTP id e6so35102276vkh.2
	for <drbd-dev@lists.linbit.com>; Wed, 17 Feb 2016 21:45:48 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 18 Feb 2016 14:39:13 +0900
Message-ID: <CAF6H8oH0tjfACC2RA06xQA8QTM-L8-71Lh661ex2=ZhAW7+BZQ@mail.gmail.com>
From: =?UTF-8?B?6rmA7J6s7ZeM?= <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a113da7c861391b052c04c938
Subject: [Drbd-dev] [CASE-22] VM hung during complicated testing on 4 nodes
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--001a113da7c861391b052c04c938
Content-Type: text/plain; charset=UTF-8

Hi,

VM hung during complicated testing on 4 nodes.

1. version
 - drbd-9.0.1-1
 - drbd-utils-8.9.6
 - CentOS 7

2. Test procedures
 - On 4 nodes
 - runs up/down,disconnect/connect randomly several times and sometimes
md-create
 - node2 vm hung suddenly. Vm freezed.

3. Logs

1) Node1

Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 575587423 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 575587423 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3005066576 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3005066576 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2982970747 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2982970747 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1635237549 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1635237549 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3629941899 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3629941899 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3986545484 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3986545484 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3563238485 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3563238485 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2815311641 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2815311641 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3238325029 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3238325029 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2126091279 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2126091279 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3638753626 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3638753626 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3599232118 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3599232118 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 113146377 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 113146377 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 776632002 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 776632002 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3173991607 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3173991607 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1425635733 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1425635733 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3766324938 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3766324938 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3678332951 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3678332951 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1350394170 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1350394170 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3453543298 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3453543298 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2874348269 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2874348269 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1961866418 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1961866418 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1422080841 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1422080841 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1106447724 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1106447724 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1935970639 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1935970639 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1369156260 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1369156260 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 36989052 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 36989052 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 582050229 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 582050229 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 4192500224 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 4192500224 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2039128137 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2039128137 (1ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 821093755 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 821093755 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3518597027 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3518597027 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 452858682 (0->2 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 452858682 (0ms) rv = -19
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2321677588 (0->1 499/146)
Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2321677588 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3637280121 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3637280121 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 261689227 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 261689227 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1843385190 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1843385190 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3197178194 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3197178194 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 767463344 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 767463344 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3875723021 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3875723021 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3351946337 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3351946337 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3454915512 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3454915512 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2640937765 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2640937765 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3044822599 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3044822599 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3354987837 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3354987837 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3556374775 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3556374775 (4ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2026795642 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2026795642 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1409529751 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1409529751 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3085364587 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3085364587 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1803219856 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1803219856 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2423822761 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2423822761 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2070740492 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2070740492 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 424571609 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 424571609 (0ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1861094959 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1861094959 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1439155988 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1439155988 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1912776257 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1912776257 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3342040311 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3342040311 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3583634975 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3583634975 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3560986460 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3560986460 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1059596388 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1059596388 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2039774846 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2039774846 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2984515839 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2984515839 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2729731529 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2729731529 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3776435962 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3776435962 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1499748024 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1499748024 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2633932659 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2633932659 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3420883318 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3420883318 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3805539839 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3805539839 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2892821134 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2892821134 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3642844571 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3642844571 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 110768160 (0->2 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 110768160 (1ms) rv = -19
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 17859418 (0->1 499/146)
Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 17859418 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1919413000 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1919413000 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1145386916 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1145386916 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2321101024 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2321101024 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3288824952 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3288824952 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2274965928 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2274965928 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3641522607 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3641522607 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3926057794 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3926057794 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 128435041 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 128435041 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 620951758 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 620951758 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1067274131 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1067274131 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3401606816 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3401606816 (2ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2464745589 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2464745589 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3575638272 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3575638272 (2ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 289378464 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 289378464 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1793285500 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1793285500 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2159434546 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2159434546 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3776803522 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3776803522 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2020636307 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2020636307 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2574235971 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2574235971 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1115473996 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1115473996 (13ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1681934234 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1681934234 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2926904129 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2926904129 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1651456969 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1651456969 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1578249747 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1578249747 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 430284320 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 430284320 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 4168451443 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 4168451443 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3304566520 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3304566520 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2489323610 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2489323610 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2784036568 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2784036568 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2444898555 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2444898555 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2821131655 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2821131655 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 649862413 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 649862413 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1360241560 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1360241560 (1ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3610428486 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3610428486 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2654692450 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2654692450 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 237694475 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 237694475 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2561046587 (0->2 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2561046587 (0ms) rv = -19
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2123728468 (0->1 499/146)
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2123728468 (0ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1716193777 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1716193777 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 954801834 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 954801834 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 997680699 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 997680699 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1595210697 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1595210697 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1795247459 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1795247459 (7ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1312694431 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1312694431 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1531206635 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1531206635 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1379557998 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1379557998 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3792084596 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3792084596 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1368060281 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1368060281 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 3569716009 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 3569716009 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1393085582 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1393085582 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 4267014762 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 4267014762 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1428881181 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1428881181 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 1718804050 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 1718804050 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 610769045 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 610769045 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 795605995 (0->2 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 795605995 (2ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 2783224475 (0->1 499/146)
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state
change 2783224475 (1ms) rv = -19
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: conn( Connecting ->
Disconnecting )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: conn( Disconnecting ->
StandAlone )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Terminating receiver
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Terminating sender thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: conn( Connecting ->
Disconnecting )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: ack_receiver terminated
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: Terminating ack_recv
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: Connection closed
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: conn( Disconnecting ->
StandAlone )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: Terminating receiver
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: Terminating sender thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: conn( Connecting ->
Disconnecting )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: Connection closed
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: conn( Disconnecting ->
StandAlone )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: Terminating receiver
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: Terminating sender thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: conn( Connecting ->
Disconnecting )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: Connection closed
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: conn( Disconnecting ->
StandAlone )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: Terminating receiver
thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: Terminating sender thread
Feb 18 12:49:19 drbd9-01 kernel: drbd r0/0 drbd1: disk( UpToDate ->
Detaching )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0/0 drbd1: disk( Detaching ->
Diskless )
Feb 18 12:49:19 drbd9-01 kernel: drbd r0/0 drbd1: drbd_bm_resize called
with capacity == 0
Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Terminating worker thread
Feb 18 12:49:29 drbd9-01 kernel: drbd r0: Starting worker thread (from
drbdsetup [32709])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: disk( Diskless ->
Attaching )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: Maximum number of peer
devices = 4
Feb 18 12:49:29 drbd9-01 kernel: drbd r0: Method to ensure write ordering:
flush
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: peer does not support
WRITE_SAME
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to
backing device's (32 -> 1024)
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: drbd_bm_resize called
with capacity == 9996656
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: resync bitmap:
bits=1249582 words=78100 pages=153
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: recounting of set bits
took additional 0ms
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: disk( Attaching ->
Inconsistent )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: attached to current UUID:
0000000000000004
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-02: Starting sender thread
(from drbdsetup [32719])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: Starting sender thread
(from drbdsetup [32723])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: Starting sender thread
(from drbdsetup [32726])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-05: Starting sender thread
(from drbdsetup [32729])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-02: conn( StandAlone ->
Unconnected )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-02: Starting receiver thread
(from drbd_w_r0 [32710])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: conn( StandAlone ->
Unconnected )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: Starting receiver thread
(from drbd_w_r0 [32710])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: conn( StandAlone ->
Unconnected )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: Starting receiver thread
(from drbd_w_r0 [32710])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: conn( Unconnected ->
Connecting )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-05: conn( StandAlone ->
Unconnected )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-05: Starting receiver thread
(from drbd_w_r0 [32710])
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: conn( Unconnected ->
Connecting )
Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-05: conn( Unconnected ->
Connecting )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: Starting ack_recv thread
(from drbd_r_r0 [32736])
Feb 18 12:49:30 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 444800473 (0->2 499/146)
Feb 18 12:49:30 drbd9-01 kernel: drbd r0: State change 444800473:
primary_nodes=0, weak_nodes=0
Feb 18 12:49:30 drbd9-01 kernel: drbd r0: Committing cluster-wide state
change 444800473 (0ms)
Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1: peer does not support
WRITE_SAME
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03:
drbd_sync_handshake:
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000 bits:0
flags:0
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: peer
B6CAADFB7D215BC6:FFFFFFFFFFFFFFFF:B6CAADFB7D215BC6:0000000000000000 bits:0
flags:20
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03:
uuid_compare()=-3 by rule 20
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: Writing the
whole bitmap, full sync required after drbd_sync_handshake.
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: pdsk( DUnknown
-> UpToDate ) repl( Off -> WFBitMapT )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1: size = 4881 MB (4998328
KB)
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: send bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper command:
/sbin/drbdadm before-resync-target
Feb 18 12:49:30 drbd9-01 drbdadm[32746]: Don't know which config file
belongs to resource r0, trying default ones...
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper command:
/sbin/drbdadm before-resync-target exit code 0 (0x0)
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-05: resync-susp( no
-> connection dependency )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-04: resync-susp( no
-> connection dependency )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: repl( WFBitMapT
-> SyncTarget )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: resync-susp( no
-> connection dependency )
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: Began resync as
SyncTarget (will sync 4998328 KB [1249582 bits set]).
Feb 18 12:49:33 drbd9-01 kernel: drbd r0 tcp:drbd9-02: Receiver busy;
rejecting incoming connection
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [32734])
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: sock was shut down by
peer
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:49:42 drbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet S
crossed
Feb 18 12:49:54 drbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet M
crossed
Feb 18 12:49:55 drbd9-01 kernel: drbd r0 drbd9-03: Preparing remote state
change 2594601400 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:01 drbd9-01 systemd: Starting Session 295 of user root.
Feb 18 12:50:01 drbd9-01 systemd: Started Session 295 of user root.
Feb 18 12:50:25 drbd9-01 kernel: drbd r0 drbd9-03: Aborting remote state
change 2594601400
Feb 18 12:50:25 drbd9-01 kernel: drbd r0 drbd9-03: Preparing remote state
change 1091225699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:25 drbd9-01 kernel: drbd r0 drbd9-03: Committing remote state
change 1091225699
Feb 18 12:50:26 drbd9-01 kernel: drbd r0 drbd9-03: Preparing remote state
change 583992461 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:26 drbd9-01 kernel: drbd r0 drbd9-03: Committing remote state
change 583992461
Feb 18 12:51:11 drbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet S
crossed
Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [32734])
Feb 18 12:51:23 drbd9-01 kernel: drbd r0: Preparing cluster-wide state
change 955356902 (0->1 499/146)
Feb 18 12:51:23 drbd9-01 kernel: drbd r0: State change 955356902:
primary_nodes=0, weak_nodes=0
Feb 18 12:51:23 drbd9-01 kernel: drbd r0: Committing cluster-wide state
change 955356902 (1ms)
Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1: peer does not support
WRITE_SAME
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02:
drbd_sync_handshake:
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:570368 flags:0
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: peer
0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000 bits:0
flags:24
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: uuid_compare()=0
by rule 10
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1: No resync, but 570368
bits in bitmap!
Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: pdsk( DUnknown
-> Inconsistent ) repl( Off -> Established )
Feb 18 12:51:24 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 515638917 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 515638917
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 137570080 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 137570080
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 997229091 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 997229091
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 82178736 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 82178736
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 3821653145 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 3821653145
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 2763345815 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 2763345815
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 2378645705 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 2378645705
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1701376328 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1701376328
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 404563979 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 404563979
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 2322165605 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 2322165605
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 3116638354 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 3116638354
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 4171949499 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 4171949499
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 4153763848 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 4153763848
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1547352803 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1547352803
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1194426093 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1194426093
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 3141780427 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 3141780427
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 2111985163 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 2111985163
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 3255414054 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 3255414054
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 993220877 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 993220877
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 2752612106 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 2752612106
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1639712018 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1639712018
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 793028279 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 793028279
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1975781053 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1975781053
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 402090143 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 402090143
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 1357840858 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 1357840858
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 4293365755 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 4293365755
Feb 18 12:51:27 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state
change 3296526104 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:27 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state
change 3296526104
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: PingAck did not arrive
in time.
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: conn( Connected ->
NetworkFailure ) peer( Secondary -> Unknown )
Feb 18 12:51:44 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: repl(
Established -> Off )
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:51:44 drbd9-01 kernel: drbd r0/0 drbd1: ASSERTION
list_empty(&device->done_ee) FAILED in drbd_disconnected
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: conn( NetworkFailure ->
Unconnected )
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: Resync done
(total 147 sec; paused 0 sec; 34000 K/sec)
Feb 18 12:51:57 drbd9-01 drbdadm[32809]: Don't know which config file
belongs to resource r0, trying default ones...
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: updated UUIDs
B6CAADFB7D215BC6:0000000000000000:0000000000000000:0000000000000000
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-05: pdsk( DUnknown
-> Outdated ) resync-susp( connection dependency -> no )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-04: resync-susp(
connection dependency -> no )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: repl( SyncTarget
-> Established )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: resync-susp(
connection dependency -> no )
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper command:
/sbin/drbdadm after-resync-target
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper command:
/sbin/drbdadm after-resync-target exit code 0 (0x0)




2) Node2

Feb 18 12:49:15 drbd9-02 drbdadm[17377]: Don't know which config file
belongs to resource r0, trying default ones...
Feb 18 12:49:15 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-04: helper command:
/sbin/drbdadm before-resync-source exit code 0 (0x0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-04: repl( WFBitMapS
-> PausedSyncS )
Feb 18 12:49:15 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-04: Began resync as
PausedSyncS (will sync 4998328 KB [1249582 bits set]).
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 352665508 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 3171251231 because of state change 352665508
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 352665508
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1037382588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 141488321 because of state change 1037382588
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT
packet 141488321.
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1037382588
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 399118927 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 1396949391 because of state change 399118927
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 399118927
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1547038261 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1547038261
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 90711453 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 90711453
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2906061427 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2906061427
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 110758586 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 110758586
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 19982401 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 19982401
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1229720926 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1229720926
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2599231352 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2599231352
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1975668868 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1975668868
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2505675278 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2505675278
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 4000831140 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 4000831140
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2750887982 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2750887982
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2468909229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2468909229
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2662778291 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2662778291
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 4035033791 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 4035033791
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1708023363 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1708023363
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 575587423 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 575587423
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3005066576 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3005066576
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2982970747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2982970747
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1635237549 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1635237549
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3629941899 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3629941899
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3563238485 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 2815311641 because of state change 3563238485
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3563238485
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3238325029 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 2126091279 because of state change 3238325029
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3238325029
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3638753626 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3638753626
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3599232118 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3599232118
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 113146377 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 776632002 because of state change 113146377
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 113146377
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3173991607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3173991607
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3766324938 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3766324938
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1350394170 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1350394170
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2874348269 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2874348269
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1961866418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1961866418
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1422080841 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1422080841
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1935970639 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1935970639
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 36989052 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 36989052
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 582050229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 582050229
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 4192500224 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 4192500224
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2039128137 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2039128137
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 821093755 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 821093755
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3518597027 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3518597027
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 452858682 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 452858682
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2321677588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2321677588
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3637280121 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3637280121
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 261689227 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 261689227
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1843385190 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1843385190
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3197178194 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3197178194
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 767463344 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 767463344
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3875723021 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3875723021
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3351946337 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3351946337
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3454915512 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3454915512
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2640937765 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2640937765
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3044822599 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3044822599
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3354987837 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3354987837
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3556374775 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3556374775
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2026795642 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2026795642
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1409529751 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1409529751
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3085364587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3085364587
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1803219856 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1803219856
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2423822761 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2423822761
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2070740492 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2070740492
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 424571609 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 424571609
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1861094959 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1861094959
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1439155988 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1439155988
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1912776257 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1912776257
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3342040311 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3342040311
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3583634975 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3583634975
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3560986460 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3560986460
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1059596388 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1059596388
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2039774846 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2039774846
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2984515839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2984515839
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2729731529 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2729731529
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3776435962 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3776435962
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1499748024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1499748024
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2633932659 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2633932659
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3420883318 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3420883318
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3805539839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3805539839
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2892821134 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2892821134
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3642844571 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3642844571
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 110768160 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 110768160
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 17859418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 17859418
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1919413000 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1919413000
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1145386916 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1145386916
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2321101024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2321101024
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3288824952 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3288824952
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2274965928 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2274965928
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3641522607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3641522607
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3926057794 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3926057794
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 128435041 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 128435041
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 620951758 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 620951758
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1067274131 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1067274131
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3401606816 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3401606816
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2464745589 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2464745589
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3575638272 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3575638272
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 289378464 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 289378464
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1793285500 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1793285500
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2159434546 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2159434546
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3776803522 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3776803522
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2020636307 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2020636307
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2574235971 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2574235971
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1115473996 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1115473996
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1681934234 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1681934234
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2926904129 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2926904129
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1651456969 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1651456969
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1578249747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1578249747
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 430284320 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 430284320
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 4168451443 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 4168451443
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3304566520 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3304566520
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2489323610 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2489323610
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2784036568 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2784036568
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2444898555 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2444898555
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2821131655 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2821131655
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 649862413 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 649862413
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1360241560 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1360241560
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 3610428486 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 3610428486
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2654692450 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2654692450
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 237694475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 237694475
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 2561046587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 2561046587
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2123728468 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2123728468
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1716193777 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1716193777
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 954801834 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 954801834
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 997680699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 997680699
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1595210697 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1595210697
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1795247459 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1795247459
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1312694431 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1312694431
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1531206635 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1531206635
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1379557998 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1379557998
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3792084596 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3792084596
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1368060281 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1368060281
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 3569716009 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 3569716009
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1393085582 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1393085582
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 4267014762 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 4267014762
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 1428881181 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 1428881181
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 1718804050 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 1718804050
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 610769045 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 610769045
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 795605995 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state
change 795605995
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state
change 2783224475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state
change 2783224475
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: sock was shut down by
peer
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: ack_receiver terminated
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Terminating ack_recv
thread
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Restarting receiver
thread
Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected ->
Connecting )
Feb 18 12:49:30 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state
change 444800473 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:30 drbd9-02 kernel: drbd r0 drbd9-03: Committing remote state
change 444800473
Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: sock_recvmsg returned -11
Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:33 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected ->
Connecting )
Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: sock was shut down by
peer
Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:42 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected ->
Connecting )
Feb 18 12:49:42 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet S
crossed
Feb 18 12:49:54 drbd9-02 kernel: drbd r0 tcp:drbd9-01: initial packet M
crossed
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting ->
Disconnecting )
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: sock_recvmsg returned -4
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: conn( Disconnecting ->
StandAlone )
Feb 18 12:49:55 drbd9-02 kernel: drbd r0: State change failed: Need a
connection to start verify or resync
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Failed: conn( StandAlone
-> Connecting )
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Terminating receiver
thread
Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Terminating sender thread
Feb 18 12:49:56 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:01 drbd9-02 systemd: Starting Session 171 of user root.
Feb 18 12:50:01 drbd9-02 systemd: Started Session 171 of user root.
Feb 18 12:50:04 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:16 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Preparing cluster-wide state
change 2594601400 (1->2 496/16)
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Retrying cluster-wide state
change after 332ms
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Preparing cluster-wide state
change 1091225699 (1->2 496/16)
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: State change 1091225699:
primary_nodes=0, weak_nodes=0
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Committing cluster-wide state
change 1091225699 (10ms)
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Feb 18 12:50:25 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-03: pdsk( UpToDate
-> DUnknown ) repl( Established -> Off )
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: ack_receiver terminated
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Terminating ack_recv
thread
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Connection closed
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: conn( Disconnecting ->
StandAlone )
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Terminating receiver
thread
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Terminating sender thread
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Preparing cluster-wide state
change 1955398811 (1->3 496/16)
Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Retrying cluster-wide state
change after 193ms
Feb 18 12:50:25 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.31
Feb 18 12:50:26 drbd9-02 kernel: drbd r0: Preparing cluster-wide state
change 583992461 (1->3 496/16)
Feb 18 12:50:26 drbd9-02 kernel: drbd r0: State change 583992461:
primary_nodes=0, weak_nodes=0
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Cluster is now split
Feb 18 12:50:26 drbd9-02 kernel: drbd r0: Committing cluster-wide state
change 583992461 (43ms)
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: conn( Connected ->
Disconnecting ) peer( Secondary -> Unknown )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-04: repl(
PausedSyncS -> Off ) resync-susp( peer -> no )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: ack_receiver terminated
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Terminating ack_recv
thread
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Connection closed
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: conn( Disconnecting ->
StandAlone )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Terminating receiver
thread
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Terminating sender thread
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: conn( Connecting ->
Disconnecting )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: Connection closed
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: conn( Disconnecting ->
StandAlone )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: Terminating receiver
thread
Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: Terminating sender thread
Feb 18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1: disk( UpToDate ->
Detaching )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1: disk( Detaching ->
Diskless )
Feb 18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1: drbd_bm_resize called
with capacity == 0
*Feb 18 12:50:26 drbd9-02 kernel: drbd r0: Terminating worker thread
 <--------------------------
----------------------------------------------------------------------------------
Last log before HANG!!!!!*

Feb 18 13:36:14 drbd9-02 rsyslogd: [origin software="rsyslogd"
swVersion="7.4.7" x-pid="899" x-info="http://www.rsyslog.com"] start
Feb 18 13:36:11 drbd9-02 journal: Runtime journal is using 6.1M (max 48.9M,
leaving 73.4M of free 483.6M, current limit 48.9M).
Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup subsys cpuset
Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup subsys cpu
Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup subsys cpuacct
Feb 18 13:36:11 drbd9-02 kernel: Linux version 3.10.0-229.7.2.el7.x86_64 (
builder@kbuilder.dev.centos.org) (gcc version 4.8.3 20140911 (Red Hat
4.8.3-9) (GCC) ) #1 SMP Tue Jun 23 22:06:11 UTC 2015
Feb 18 13:36:11 drbd9-02 kernel: Command line:
BOOT_IMAGE=/vmlinuz-3.10.0-229.7.2.el7.x86_64
root=/dev/mapper/cento-------s-root ro rd.lvm.lv=centos/root
rd.lvm.lv=centos/swap
net.ifnames=0 rhgb quiet systemd.debug LANG=ko_KR.UTF-8
Feb 18 13:36:11 drbd9-02 kernel: Disabled fast string operations
Feb 18 13:36:11 drbd9-02 kernel: e820: BIOS-provided physical RAM map:
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x0000000000000000-0x000000000009ebff] usable
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x000000000009ec00-0x000000000009ffff] reserved
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x00000000000dc000-0x00000000000fffff] reserved
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x0000000000100000-0x000000003fedffff] usable
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x000000003fee0000-0x000000003fefefff] ACPI data
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x000000003feff000-0x000000003fefffff] ACPI NVS
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x000000003ff00000-0x000000003fffffff] usable
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x00000000f0000000-0x00000000f7ffffff] reserved
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x00000000fec00000-0x00000000fec0ffff] reserved
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x00000000fee00000-0x00000000fee00fff] reserved
Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem
0x00000000fffe0000-0x00000000ffffffff] reserved
Feb 18 13:36:11 drbd9-02 kernel: NX (Execute Disable) protection: active
Feb 18 13:36:11 drbd9-02 kernel: SMBIOS 2.4 present.
[root@drbd9-02 ~]#





3) Node3

Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4148874408
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Starting ack_recv thread
(from drbd_r_r0 [27984])
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: sock was shut down by
peer
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: ack_receiver terminated
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Terminating ack_recv
thread
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Restarting receiver
thread
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: conn( Unconnected ->
Connecting )
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1700403818 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1700403818
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 27107912 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 27107912
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3704636436 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3704636436
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1124892736 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1124892736
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3041974229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3041974229
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2044263190 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2044263190
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4123278827 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4123278827
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 58309047 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 58309047
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1424319647 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1424319647
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2146390635 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2146390635
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Starting ack_recv thread
(from drbd_r_r0 [27984])
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3224851067 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3224851067
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3275921964 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3275921964
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2785425520 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2785425520
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3092566612 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3092566612
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3546571907 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3546571907
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2684586320 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2684586320
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2826388576 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2826388576
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3152419371 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3152419371
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 717442544 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 717442544
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1538773720 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1538773720
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3935479086 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3935479086
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1574758056 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1574758056
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1212157223 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1212157223
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1960346098 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1960346098
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3227317969 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3227317969
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4262478632 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4262478632
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3004867455 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3004867455
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1876684995 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1876684995
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 390087009 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 390087009
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2865628136 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2865628136
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 680960366 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 680960366
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1752965497 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1752965497
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3111596947 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3111596947
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2123586573 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2123586573
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2432880222 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2432880222
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3466823240 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3466823240
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3409262061 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3409262061
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3528423906 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3528423906
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 919401773 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 919401773
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2355827361 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2355827361
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 274217007 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 274217007
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1735994045 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1735994045
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 184247837 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 184247837
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3397010196 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3397010196
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2647943263 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2647943263
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2314118776 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2314118776
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2304216418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2304216418
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2840076212 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2840076212
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2089786251 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2089786251
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1243463540 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1243463540
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3934530318 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3934530318
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1338535718 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1338535718
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3825464252 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3825464252
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 458138564 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 458138564
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3263001224 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3263001224
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1737345562 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1737345562
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 895380100 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 895380100
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1353873222 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1353873222
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1127265602 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1127265602
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2720890274 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2720890274
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4153736246 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4153736246
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3640994784 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3640994784
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2901412307 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2901412307
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1322472363 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1322472363
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1479893692 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1479893692
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3205669847 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3205669847
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1501697909 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1501697909
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2019004256 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2019004256
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3350229455 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3350229455
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1039571066 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1039571066
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 220257880 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 220257880
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 4026895487 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 4026895487
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1721931724 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1721931724
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1033546961 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1033546961
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3092763300 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3092763300
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 770538692 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 770538692
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1354057588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1354057588
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1483793276 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1483793276
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3482039458 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3482039458
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2598992257 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2598992257
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 817000556 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 817000556
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 77974480 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 77974480
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3966174102 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3966174102
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 747047415 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 747047415
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2830150720 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2830150720
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2666597117 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2666597117
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3030671864 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3030671864
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2343253662 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2343253662
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3117955713 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3117955713
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3036692217 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3036692217
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2007453059 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2007453059
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 102602932 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 102602932
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 374656520 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 374656520
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2835460938 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2835460938
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 842771771 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 842771771
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 4190748897 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 4190748897
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2015816228 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2015816228
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1462726939 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1462726939
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2742749823 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2742749823
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1941161229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1941161229
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2962336775 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2962336775
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2584607114 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2584607114
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1687607447 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1687607447
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2414299465 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2414299465
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 918122871 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 918122871
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2674395060 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2674395060
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2939585177 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2939585177
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1994730321 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1994730321
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1533339556 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1533339556
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3763733638 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3763733638
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3413396013 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3413396013
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 965408431 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 965408431
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2712598837 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2712598837
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2723235979 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2723235979
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1267855463 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1267855463
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2472306332 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2472306332
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3364150313 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3364150313
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2682382103 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2682382103
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 772789142 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 772789142
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2291238476 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2291238476
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1516864995 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1516864995
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 8357236 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 8357236
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3503255741 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3503255741
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2689137965 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2689137965
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3319268457 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3319268457
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 278690020 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 278690020
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3600586096 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3600586096
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3511376225 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3511376225
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 63685240 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 63685240
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 4238257769 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 4238257769
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 176339051 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 176339051
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3285874930 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3285874930
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 334220901 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 334220901
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 314034843 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 314034843
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3927423460 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3927423460
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 445007464 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 445007464
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1563966627 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1563966627
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2609728281 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2609728281
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3813816936 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3813816936
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3732916591 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3732916591
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3912334398 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3912334398
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2966831417 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2966831417
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4103984360 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4103984360
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1765942052 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1765942052
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2916219381 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2916219381
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2875115170 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2875115170
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3970442788 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3970442788
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3311773748 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3311773748
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 828078891 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 828078891
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 916340848 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 916340848
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3809938960 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3809938960
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 466030330 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 466030330
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3871624072 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3871624072
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 562578872 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 562578872
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3059617914 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3059617914
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1765006974 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1765006974
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4282026993 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4282026993
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 541907284 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 541907284
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3720310948 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3720310948
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2525581650 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2525581650
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 233526968 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 233526968
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1832763483 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1832763483
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 919412360 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 919412360
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3167526743 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3167526743
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1726750051 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1726750051
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 135300592 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 135300592
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1945757685 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1945757685
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 120559031 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 120559031
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1931376741 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1931376741
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2685589933 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2685589933
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2895871033 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2895871033
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1657331205 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Committing remote state
change 1657331205
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 352665508 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 352665508
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1037382588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1037382588
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 399118927 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 399118927
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1547038261 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1547038261
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 90711453 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 90711453
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2906061427 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2906061427
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 110758586 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 110758586
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 19982401 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 19982401
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1229720926 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1229720926
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2599231352 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2599231352
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1975668868 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1975668868
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2505675278 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2505675278
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4000831140 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4000831140
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2750887982 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2750887982
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2468909229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2468909229
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2662778291 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2662778291
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4035033791 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4035033791
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1708023363 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 1066177111 because of state change 1708023363
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1708023363
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 575587423 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 575587423
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3005066576 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3005066576
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2982970747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2982970747
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1635237549 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1635237549
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3629941899 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 3986545484 because of state change 3629941899
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3629941899
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3563238485 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3563238485
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3238325029 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3238325029
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3638753626 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3638753626
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3599232118 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3599232118
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 113146377 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 113146377
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3173991607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 1425635733 because of state change 3173991607
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3173991607
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3766324938 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 3678332951 because of state change 3766324938
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3766324938
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1350394170 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 3453543298 because of state change 1350394170
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1350394170
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2874348269 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2874348269
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1961866418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1961866418
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1422080841 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 1106447724 because of state change 1422080841
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1422080841
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1935970639 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent
remote state change 1369156260 because of state change 1935970639
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1935970639
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 36989052 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 36989052
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 582050229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 582050229
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 4192500224 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 4192500224
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2039128137 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2039128137
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 821093755 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 821093755
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3518597027 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3518597027
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 452858682 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 452858682
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2321677588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2321677588
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3637280121 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3637280121
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 261689227 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 261689227
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1843385190 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1843385190
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3197178194 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3197178194
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 767463344 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 767463344
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3875723021 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3875723021
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3351946337 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3351946337
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3454915512 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3454915512
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2640937765 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2640937765
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3044822599 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3044822599
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3354987837 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3354987837
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3556374775 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3556374775
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2026795642 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2026795642
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1409529751 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1409529751
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3085364587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3085364587
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1803219856 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1803219856
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2423822761 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2423822761
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2070740492 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2070740492
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 424571609 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 424571609
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1861094959 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1861094959
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1439155988 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1439155988
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1912776257 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1912776257
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3342040311 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3342040311
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3583634975 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3583634975
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3560986460 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3560986460
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1059596388 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1059596388
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2039774846 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2039774846
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2984515839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2984515839
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2729731529 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2729731529
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3776435962 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3776435962
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1499748024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1499748024
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2633932659 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2633932659
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3420883318 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3420883318
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3805539839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3805539839
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2892821134 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2892821134
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3642844571 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3642844571
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 110768160 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 110768160
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 17859418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 17859418
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1919413000 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1919413000
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1145386916 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1145386916
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2321101024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2321101024
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3288824952 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3288824952
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2274965928 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2274965928
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3641522607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3641522607
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3926057794 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3926057794
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 128435041 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 128435041
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 620951758 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 620951758
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1067274131 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1067274131
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3401606816 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3401606816
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2464745589 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2464745589
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3575638272 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3575638272
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 289378464 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 289378464
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1793285500 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1793285500
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2159434546 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2159434546
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3776803522 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3776803522
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2020636307 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2020636307
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2574235971 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2574235971
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1115473996 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1115473996
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1681934234 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1681934234
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2926904129 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2926904129
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1651456969 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1651456969
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1578249747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1578249747
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 430284320 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 430284320
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 4168451443 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 4168451443
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3304566520 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3304566520
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2489323610 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2489323610
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2784036568 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2784036568
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2444898555 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2444898555
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2821131655 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2821131655
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 649862413 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 649862413
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1360241560 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1360241560
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 3610428486 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 3610428486
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2654692450 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2654692450
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 237694475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 237694475
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 2561046587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 2561046587
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2123728468 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2123728468
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1716193777 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1716193777
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 954801834 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 954801834
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 997680699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 997680699
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1595210697 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1595210697
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1795247459 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1795247459
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1312694431 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1312694431
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1531206635 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1531206635
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1379557998 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1379557998
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3792084596 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3792084596
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1368060281 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1368060281
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 3569716009 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 3569716009
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1393085582 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1393085582
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 4267014762 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 4267014762
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1428881181 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 1428881181
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 1718804050 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 1718804050
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 610769045 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 610769045
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 795605995 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state
change 795605995
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2783224475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2783224475
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: sock was shut down by
peer
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: conn( Connecting ->
BrokenPipe )
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: ack_receiver terminated
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Terminating ack_recv
thread
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Connection closed
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: conn( BrokenPipe ->
Unconnected )
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Restarting receiver
thread
Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: conn( Unconnected ->
Connecting )
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Starting ack_recv thread
(from drbd_r_r0 [27984])
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 444800473 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Committing remote state
change 444800473
Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1: peer does not support
WRITE_SAME
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01:
drbd_sync_handshake:
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: self
B6CAADFB7D215BC6:0000000000000000:B6CAADFB7D215BC6:0000000000000000 bits:0
flags:0
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: peer
0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:0000000000000000 bits:0
flags:24
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: uuid_compare()=3
by rule 30
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: Writing the
whole bitmap, full sync required after drbd_sync_handshake.
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: pdsk( DUnknown
-> Inconsistent ) repl( Off -> WFBitMapS )
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: send bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:30 drbd9-03 drbdadm[28024]: Don't know which config file
belongs to resource r0, trying default ones...
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: helper command:
/sbin/drbdadm before-resync-source
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: helper command:
/sbin/drbdadm before-resync-source exit code 0 (0x0)
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: repl( WFBitMapS
-> SyncSource )
Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: Began resync as
SyncSource (will sync 4998328 KB [1249582 bits set]).
Feb 18 12:49:55 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 2594601400 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:01 drbd9-03 systemd: Starting Session 296 of user root.
Feb 18 12:50:01 drbd9-03 systemd: Started Session 296 of user root.
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state
change 2594601400
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 1091225699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Committing remote state
change 1091225699
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connected ->
TearDown ) peer( Secondary -> Unknown )
Feb 18 12:50:25 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-02: pdsk( UpToDate
-> DUnknown ) repl( Established -> Off )
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-04: Rejecting concurrent
remote state change 1955398811 because of state change 1091225699
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-04: Ignoring P_TWOPC_ABORT
packet 1955398811.
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( TearDown ->
Unconnected )
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-04: Preparing remote state
change 583992461 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:26 drbd9-03 kernel: drbd r0 drbd9-04: Committing remote state
change 583992461
Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: sock_recvmsg returned -11
Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting ->
BrokenPipe )
Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: conn( BrokenPipe ->
Unconnected )
Feb 18 12:51:14 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:23 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state
change 955356902 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:23 drbd9-03 kernel: drbd r0 drbd9-01: Committing remote state
change 955356902
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [27986])
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting ->
NetworkFailure )
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: conn( NetworkFailure ->
Unconnected )
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 tcp:drbd9-02: Error receiving
initial packet
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [27986])
Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state
change 515638917 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: sock_recvmsg returned
-104
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting ->
NetworkFailure )
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( NetworkFailure ->
Unconnected )
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:26 drbd9-03 kernel: drbd r0 tcp:drbd9-02: initial packet S
crossed
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [27986])
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Wrong magic value
0x83740267 in protocol version 111
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting ->
ProtocolError )
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: conn( ProtocolError ->
Unconnected )
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-04: updated UUIDs
B6CAADFB7D215BC6:0000000000000000:B6CAADFB7D215BC6:0000000000000000
Feb 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-04: Resync done
(total 144 sec; paused 0 sec; 34708 K/sec)
Feb 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-04: pdsk(
Inconsistent -> UpToDate ) repl( SyncSource -> Established )
Feb 18 12:51:54 drbd9-03 kernel: drbd r0: Two-phase commit 515638917 timeout
Feb 18 12:51:57 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: Resync done
(total 147 sec; paused 0 sec; 34000 K/sec)
Feb 18 12:51:57 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: pdsk(
Inconsistent -> UpToDate ) repl( SyncSource -> Established )




4)  Node4

Feb 18 12:49:14 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 828078891 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:14 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 828078891
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 916340848 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 916340848
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3809938960 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3809938960
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 466030330 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 466030330
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3871624072 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3871624072
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 562578872 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 562578872
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3059617914 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3059617914
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1765006974 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1765006974
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 4282026993 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 4282026993
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Handshake successful:
Agreed network protocol version 111
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Feature flags enabled on
protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Starting ack_recv thread
(from drbd_r_r0 [21093])
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 541907284 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 541907284
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3720310948 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3720310948
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2525581650 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2525581650
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 233526968 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 233526968
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1832763483 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1832763483
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 919412360 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 919412360
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3167526743 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3167526743
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1726750051 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1726750051
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 135300592 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 135300592
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1945757685 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1945757685
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 120559031 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 120559031
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1931376741 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1931376741
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2685589933 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2685589933
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2895871033 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2895871033
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1657331205 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Committing remote state
change 1657331205
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connecting ->
Connected ) peer( Unknown -> Secondary )
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1: peer does not support
WRITE_SAME
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02:
drbd_sync_handshake:
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: self
0000000000000004:0000000000000000:0000000000000000:0000000000000000
bits:102960 flags:0
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: peer
B6CAADFB7D215BC6:B6CAADFB7D215BC6:B6CAADFB7D215BC6:0000000000000000
bits:758062 flags:120
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02:
uuid_compare()=-3 by rule 20
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: pdsk( DUnknown
-> UpToDate ) repl( Off -> WFBitMapT )
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: receive bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:15 drbd9-04 drbdadm[21216]: Don't know which config file
belongs to resource r0, trying default ones...
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: send bitmap
stats [Bytes(packets)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: helper command:
/sbin/drbdadm before-resync-target
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: helper command:
/sbin/drbdadm before-resync-target exit code 0 (0x0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: repl( WFBitMapT
-> PausedSyncT )
Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: Began resync as
PausedSyncT (will sync 4998328 KB [1249582 bits set]).
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 352665508 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 352665508
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1037382588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1037382588
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 399118927 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 399118927
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1547038261 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1547038261
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 90711453 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 90711453
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2906061427 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2906061427
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 110758586 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 110758586
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 19982401 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 19982401
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1229720926 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1229720926
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2599231352 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2599231352
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1975668868 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1975668868
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2505675278 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2505675278
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 4000831140 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 4000831140
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2750887982 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2750887982
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2468909229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2468909229
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2662778291 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2662778291
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 4035033791 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 4035033791
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1708023363 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1708023363
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 575587423 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 575587423
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3005066576 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3005066576
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2982970747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2982970747
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1635237549 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1635237549
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3629941899 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3629941899
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3563238485 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3563238485
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3238325029 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3238325029
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3638753626 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3638753626
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3599232118 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3599232118
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 113146377 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 113146377
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3173991607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3173991607
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3766324938 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3766324938
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1350394170 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1350394170
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2874348269 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2874348269
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1961866418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1961866418
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1422080841 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1422080841
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1935970639 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1935970639
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 36989052 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 36989052
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 582050229 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 582050229
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 4192500224 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 4192500224
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2039128137 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2039128137
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 821093755 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 821093755
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3518597027 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3518597027
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 452858682 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 452858682
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2321677588 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2321677588
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3637280121 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3637280121
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 261689227 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 261689227
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1843385190 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1843385190
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3197178194 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3197178194
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 767463344 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 767463344
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3875723021 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3875723021
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3351946337 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3351946337
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3454915512 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3454915512
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2640937765 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2640937765
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3044822599 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3044822599
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3354987837 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Rejecting concurrent
remote state change 3556374775 because of state change 3354987837
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3354987837
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2026795642 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2026795642
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1409529751 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1409529751
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3085364587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3085364587
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1803219856 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1803219856
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2423822761 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2423822761
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2070740492 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2070740492
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 424571609 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 424571609
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1861094959 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1861094959
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1439155988 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1439155988
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1912776257 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1912776257
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3342040311 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3342040311
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3583634975 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3583634975
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3560986460 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3560986460
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1059596388 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1059596388
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2039774846 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2039774846
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2984515839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2984515839
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2729731529 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2729731529
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3776435962 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3776435962
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1499748024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1499748024
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2633932659 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2633932659
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3420883318 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3420883318
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3805539839 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3805539839
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2892821134 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2892821134
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3642844571 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3642844571
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 110768160 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 110768160
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 17859418 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 17859418
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1919413000 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1919413000
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1145386916 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1145386916
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2321101024 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2321101024
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3288824952 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3288824952
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2274965928 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2274965928
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3641522607 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3641522607
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3926057794 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3926057794
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 128435041 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 128435041
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 620951758 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 620951758
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1067274131 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1067274131
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3401606816 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3401606816
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2464745589 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2464745589
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3575638272 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3575638272
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 289378464 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 289378464
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1793285500 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1793285500
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2159434546 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2159434546
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3776803522 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3776803522
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2020636307 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2020636307
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2574235971 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2574235971
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1115473996 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1115473996
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1681934234 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1681934234
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2926904129 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2926904129
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1651456969 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1651456969
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1578249747 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1578249747
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 430284320 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 430284320
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 4168451443 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 4168451443
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3304566520 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3304566520
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2489323610 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2489323610
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2784036568 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2784036568
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2444898555 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2444898555
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2821131655 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2821131655
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 649862413 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 649862413
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1360241560 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1360241560
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 3610428486 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 3610428486
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2654692450 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2654692450
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 237694475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 237694475
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 2561046587 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 2561046587
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2123728468 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2123728468
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1716193777 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1716193777
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 954801834 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 954801834
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 997680699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 997680699
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1595210697 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1595210697
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1795247459 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1795247459
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1312694431 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1312694431
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1531206635 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1531206635
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1379557998 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1379557998
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3792084596 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3792084596
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1368060281 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1368060281
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 3569716009 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 3569716009
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1393085582 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1393085582
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 4267014762 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 4267014762
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1428881181 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1428881181
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 1718804050 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 1718804050
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 610769045 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 610769045
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 795605995 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state
change 795605995
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2783224475 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2783224475
Feb 18 12:49:29 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:49:30 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 444800473 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:30 drbd9-04 kernel: drbd r0 drbd9-03: Committing remote state
change 444800473
Feb 18 12:49:38 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:49:49 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:49:55 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 2594601400 (primary_nodes=0, weak_nodes=0)
Feb 18 12:49:55 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:01 drbd9-04 systemd: Starting Session 139 of user root.
Feb 18 12:50:01 drbd9-04 systemd: Started Session 139 of user root.
Feb 18 12:50:07 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:16 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 2594601400
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1091225699 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Committing remote state
change 1091225699
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 1955398811 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state
change 1955398811
Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state
change 583992461 (primary_nodes=0, weak_nodes=0)
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: Committing remote state
change 583992461
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connected ->
TearDown ) peer( Secondary -> Unknown )
Feb 18 12:50:26 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: pdsk( UpToDate
-> DUnknown ) repl( PausedSyncT -> Off )
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: ack_receiver terminated
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: Terminating ack_recv
thread
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( TearDown ->
Unconnected )
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: Restarting receiver
thread
Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:50:36 drbd9-04 kernel: drbd r0 tcp:drbd9-02: Closing unexpected
connection from 100.100.10.11
Feb 18 12:50:48 drbd9-04 kernel: drbd r0 tcp:drbd9-02: Closing unexpected
connection from 100.100.10.11
Feb 18 12:51:00 drbd9-04 kernel: drbd r0 tcp:drbd9-02: Closing unexpected
connection from 100.100.10.11
Feb 18 12:51:12 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected
connection from 100.100.10.11
Feb 18 12:51:13 drbd9-04 kernel: drbd r0 drbd9-02: sock_recvmsg returned -11
Feb 18 12:51:13 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connecting ->
BrokenPipe )
Feb 18 12:51:13 drbd9-04 kernel: drbd r0/0 drbd1: ASSERTION
list_empty(&device->sync_ee) FAILED in drbd_disconnected
Feb 18 12:51:13 drbd9-04 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:13 drbd9-04 kernel: drbd r0 drbd9-02: conn( BrokenPipe ->
Unconnected )
Feb 18 12:51:14 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:20 drbd9-04 kernel: drbd r0 tcp:drbd9-02: Closing unexpected
connection from 100.100.10.11
Feb 18 12:51:23 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 955356902 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:23 drbd9-04 kernel: drbd r0 drbd9-03: Committing remote state
change 955356902
Feb 18 12:51:24 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state
change 515638917 (primary_nodes=0, weak_nodes=0)
Feb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: sock_recvmsg returned -11
Feb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connecting ->
BrokenPipe )
Feb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: Connection closed
Feb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( BrokenPipe ->
Unconnected )
Feb 18 12:51:27 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconnected ->
Connecting )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: Resync done
(total 144 sec; paused 0 sec; 34708 K/sec)
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: updated UUIDs
B6CAADFB7D215BC6:0000000000000000:0000000000000000:0000000000000000
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1: disk( Inconsistent ->
UpToDate )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-05: pdsk( DUnknown
-> Outdated ) resync-susp( connection dependency -> no )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: repl( SyncTarget
-> Established )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: resync-susp(
connection dependency -> no )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-01: pdsk( DUnknown
-> Outdated ) resync-susp( connection dependency -> no )
Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: helper command:
/sbin/drbdadm after-resync-target


4. Question
 - Could you please check HANG position at Node 2 log?




Thanks.

--001a113da7c861391b052c04c938
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>VM hung during complicat=
ed testing on 4 nodes.<br></div><div><br></div><div>1. version</div><div>=
=C2=A0- drbd-9.0.1-1</div><div>=C2=A0- drbd-utils-8.9.6</div><div>=C2=A0- C=
entOS 7</div><div><br></div><div>2. Test procedures</div><div>=C2=A0- On 4 =
nodes</div><div>=C2=A0- runs up/down,disconnect/connect randomly several ti=
mes and sometimes md-create</div><div>=C2=A0- node2 vm hung suddenly. Vm fr=
eezed.</div><div><br></div><div>3. Logs</div><div><br></div><div>1) Node1</=
div><div><br></div><div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Prep=
aring cluster-wide state change 575587423 (0-&gt;1 499/146)</div><div>Feb 1=
8 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 575=
587423 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0:=
 Preparing cluster-wide state change 3005066576 (0-&gt;2 499/146)</div><div=
>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state chan=
ge 3005066576 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: d=
rbd r0: Preparing cluster-wide state change 2982970747 (0-&gt;1 499/146)</d=
iv><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide sta=
te change 2982970747 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 ke=
rnel: drbd r0: Preparing cluster-wide state change 1635237549 (0-&gt;2 499/=
146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-w=
ide state change 1635237549 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd=
9-01 kernel: drbd r0: Preparing cluster-wide state change 3629941899 (0-&gt=
;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cl=
uster-wide state change 3629941899 (1ms) rv =3D -19</div><div>Feb 18 12:49:=
16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 3986545484=
 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Abor=
ting cluster-wide state change 3986545484 (0ms) rv =3D -19</div><div>Feb 18=
 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 356=
3238485 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r=
0: Aborting cluster-wide state change 3563238485 (1ms) rv =3D -19</div><div=
>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state cha=
nge 2815311641 (0-&gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel:=
 drbd r0: Aborting cluster-wide state change 2815311641 (0ms) rv =3D -19</d=
iv><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide st=
ate change 3238325029 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 =
kernel: drbd r0: Aborting cluster-wide state change 3238325029 (1ms) rv =3D=
 -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-=
wide state change 2126091279 (0-&gt;1 499/146)</div><div>Feb 18 12:49:16 dr=
bd9-01 kernel: drbd r0: Aborting cluster-wide state change 2126091279 (0ms)=
 rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing c=
luster-wide state change 3638753626 (0-&gt;2 499/146)</div><div>Feb 18 12:4=
9:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 363875362=
6 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Prep=
aring cluster-wide state change 3599232118 (0-&gt;1 499/146)</div><div>Feb =
18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 35=
99232118 (0ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r=
0: Preparing cluster-wide state change 113146377 (0-&gt;2 499/146)</div><di=
v>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state cha=
nge 113146377 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: d=
rbd r0: Preparing cluster-wide state change 776632002 (0-&gt;1 499/146)</di=
v><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide stat=
e change 776632002 (0ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kern=
el: drbd r0: Preparing cluster-wide state change 3173991607 (0-&gt;1 499/14=
6)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wid=
e state change 3173991607 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-=
01 kernel: drbd r0: Preparing cluster-wide state change 1425635733 (0-&gt;2=
 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting clus=
ter-wide state change 1425635733 (0ms) rv =3D -19</div><div>Feb 18 12:49:16=
 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 3766324938 (=
0-&gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborti=
ng cluster-wide state change 3766324938 (1ms) rv =3D -19</div><div>Feb 18 1=
2:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 36783=
32951 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0:=
 Aborting cluster-wide state change 3678332951 (0ms) rv =3D -19</div><div>F=
eb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chang=
e 1350394170 (0-&gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: d=
rbd r0: Aborting cluster-wide state change 1350394170 (1ms) rv =3D -19</div=
><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide stat=
e change 3453543298 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 ke=
rnel: drbd r0: Aborting cluster-wide state change 3453543298 (0ms) rv =3D -=
19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wi=
de state change 2874348269 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd=
9-01 kernel: drbd r0: Aborting cluster-wide state change 2874348269 (1ms) r=
v =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing clu=
ster-wide state change 1961866418 (0-&gt;1 499/146)</div><div>Feb 18 12:49:=
16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 1961866418 =
(0ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Prepar=
ing cluster-wide state change 1422080841 (0-&gt;1 499/146)</div><div>Feb 18=
 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 1422=
080841 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0:=
 Preparing cluster-wide state change 1106447724 (0-&gt;2 499/146)</div><div=
>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide state chan=
ge 1106447724 (0ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: d=
rbd r0: Preparing cluster-wide state change 1935970639 (0-&gt;1 499/146)</d=
iv><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-wide sta=
te change 1935970639 (1ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd9-01 ke=
rnel: drbd r0: Preparing cluster-wide state change 1369156260 (0-&gt;2 499/=
146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting cluster-w=
ide state change 1369156260 (0ms) rv =3D -19</div><div>Feb 18 12:49:16 drbd=
9-01 kernel: drbd r0: Preparing cluster-wide state change 36989052 (0-&gt;2=
 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting clus=
ter-wide state change 36989052 (0ms) rv =3D -19</div><div>Feb 18 12:49:16 d=
rbd9-01 kernel: drbd r0: Preparing cluster-wide state change 582050229 (0-&=
gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Aborting =
cluster-wide state change 582050229 (1ms) rv =3D -19</div><div>Feb 18 12:49=
:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 419250022=
4 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Abo=
rting cluster-wide state change 4192500224 (1ms) rv =3D -19</div><div>Feb 1=
8 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 20=
39128137 (0-&gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd =
r0: Aborting cluster-wide state change 2039128137 (1ms) rv =3D -19</div><di=
v>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide state ch=
ange 821093755 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd9-01 kernel:=
 drbd r0: Aborting cluster-wide state change 821093755 (0ms) rv =3D -19</di=
v><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-wide sta=
te change 3518597027 (0-&gt;1 499/146)</div><div>Feb 18 12:49:16 drbd9-01 k=
ernel: drbd r0: Aborting cluster-wide state change 3518597027 (0ms) rv =3D =
-19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing cluster-w=
ide state change 452858682 (0-&gt;2 499/146)</div><div>Feb 18 12:49:16 drbd=
9-01 kernel: drbd r0: Aborting cluster-wide state change 452858682 (0ms) rv=
 =3D -19</div><div>Feb 18 12:49:16 drbd9-01 kernel: drbd r0: Preparing clus=
ter-wide state change 2321677588 (0-&gt;1 499/146)</div><div>Feb 18 12:49:1=
6 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 2321677588 (=
0ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Prepari=
ng cluster-wide state change 3637280121 (0-&gt;2 499/146)</div><div>Feb 18 =
12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 36372=
80121 (0ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: =
Preparing cluster-wide state change 261689227 (0-&gt;1 499/146)</div><div>F=
eb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change=
 261689227 (0ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd=
 r0: Preparing cluster-wide state change 1843385190 (0-&gt;2 499/146)</div>=
<div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state =
change 1843385190 (0ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kerne=
l: drbd r0: Preparing cluster-wide state change 3197178194 (0-&gt;1 499/146=
)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide=
 state change 3197178194 (0ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-0=
1 kernel: drbd r0: Preparing cluster-wide state change 767463344 (0-&gt;2 4=
99/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluste=
r-wide state change 767463344 (0ms) rv =3D -19</div><div>Feb 18 12:49:17 dr=
bd9-01 kernel: drbd r0: Preparing cluster-wide state change 3875723021 (0-&=
gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting =
cluster-wide state change 3875723021 (1ms) rv =3D -19</div><div>Feb 18 12:4=
9:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 33519463=
37 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Ab=
orting cluster-wide state change 3351946337 (0ms) rv =3D -19</div><div>Feb =
18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 3=
454915512 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd=
 r0: Aborting cluster-wide state change 3454915512 (0ms) rv =3D -19</div><d=
iv>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state c=
hange 2640937765 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kerne=
l: drbd r0: Aborting cluster-wide state change 2640937765 (0ms) rv =3D -19<=
/div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide =
state change 3044822599 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-0=
1 kernel: drbd r0: Aborting cluster-wide state change 3044822599 (0ms) rv =
=3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing clust=
er-wide state change 3354987837 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17=
 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 3354987837 (1=
ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparin=
g cluster-wide state change 3556374775 (0-&gt;1 499/146)</div><div>Feb 18 1=
2:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 355637=
4775 (4ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: P=
reparing cluster-wide state change 2026795642 (0-&gt;2 499/146)</div><div>F=
eb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change=
 2026795642 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drb=
d r0: Preparing cluster-wide state change 1409529751 (0-&gt;1 499/146)</div=
><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state=
 change 1409529751 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kern=
el: drbd r0: Preparing cluster-wide state change 3085364587 (0-&gt;2 499/14=
6)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wid=
e state change 3085364587 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-=
01 kernel: drbd r0: Preparing cluster-wide state change 1803219856 (0-&gt;1=
 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting clus=
ter-wide state change 1803219856 (0ms) rv =3D -19</div><div>Feb 18 12:49:17=
 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 2423822761 (=
0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborti=
ng cluster-wide state change 2423822761 (0ms) rv =3D -19</div><div>Feb 18 1=
2:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 20707=
40492 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0:=
 Aborting cluster-wide state change 2070740492 (1ms) rv =3D -19</div><div>F=
eb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chang=
e 424571609 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: dr=
bd r0: Aborting cluster-wide state change 424571609 (0ms) rv =3D -19</div><=
div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state =
change 1861094959 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kern=
el: drbd r0: Aborting cluster-wide state change 1861094959 (1ms) rv =3D -19=
</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide=
 state change 1439155988 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-=
01 kernel: drbd r0: Aborting cluster-wide state change 1439155988 (1ms) rv =
=3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing clust=
er-wide state change 1912776257 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17=
 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 1912776257 (1=
ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparin=
g cluster-wide state change 3342040311 (0-&gt;2 499/146)</div><div>Feb 18 1=
2:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 334204=
0311 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: P=
reparing cluster-wide state change 3583634975 (0-&gt;1 499/146)</div><div>F=
eb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change=
 3583634975 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drb=
d r0: Preparing cluster-wide state change 3560986460 (0-&gt;2 499/146)</div=
><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state=
 change 3560986460 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kern=
el: drbd r0: Preparing cluster-wide state change 1059596388 (0-&gt;1 499/14=
6)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wid=
e state change 1059596388 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-=
01 kernel: drbd r0: Preparing cluster-wide state change 2039774846 (0-&gt;2=
 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting clus=
ter-wide state change 2039774846 (1ms) rv =3D -19</div><div>Feb 18 12:49:17=
 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 2984515839 (=
0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborti=
ng cluster-wide state change 2984515839 (1ms) rv =3D -19</div><div>Feb 18 1=
2:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 27297=
31529 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0:=
 Aborting cluster-wide state change 2729731529 (1ms) rv =3D -19</div><div>F=
eb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chang=
e 3776435962 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: d=
rbd r0: Aborting cluster-wide state change 3776435962 (1ms) rv =3D -19</div=
><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wide stat=
e change 1499748024 (0-&gt;2 499/146)</div><div>Feb 18 12:49:17 drbd9-01 ke=
rnel: drbd r0: Aborting cluster-wide state change 1499748024 (1ms) rv =3D -=
19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing cluster-wi=
de state change 2633932659 (0-&gt;1 499/146)</div><div>Feb 18 12:49:17 drbd=
9-01 kernel: drbd r0: Aborting cluster-wide state change 2633932659 (1ms) r=
v =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Preparing clu=
ster-wide state change 3420883318 (0-&gt;2 499/146)</div><div>Feb 18 12:49:=
17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 3420883318 =
(1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Prepar=
ing cluster-wide state change 3805539839 (0-&gt;1 499/146)</div><div>Feb 18=
 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 3805=
539839 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0:=
 Preparing cluster-wide state change 2892821134 (0-&gt;2 499/146)</div><div=
>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide state chan=
ge 2892821134 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 kernel: d=
rbd r0: Preparing cluster-wide state change 3642844571 (0-&gt;1 499/146)</d=
iv><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wide sta=
te change 3642844571 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-01 ke=
rnel: drbd r0: Preparing cluster-wide state change 110768160 (0-&gt;2 499/1=
46)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluster-wi=
de state change 110768160 (1ms) rv =3D -19</div><div>Feb 18 12:49:17 drbd9-=
01 kernel: drbd r0: Preparing cluster-wide state change 17859418 (0-&gt;1 4=
99/146)</div><div>Feb 18 12:49:17 drbd9-01 kernel: drbd r0: Aborting cluste=
r-wide state change 17859418 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drb=
d9-01 kernel: drbd r0: Preparing cluster-wide state change 1919413000 (0-&g=
t;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting c=
luster-wide state change 1919413000 (1ms) rv =3D -19</div><div>Feb 18 12:49=
:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 114538691=
6 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Abo=
rting cluster-wide state change 1145386916 (1ms) rv =3D -19</div><div>Feb 1=
8 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 23=
21101024 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd =
r0: Aborting cluster-wide state change 2321101024 (1ms) rv =3D -19</div><di=
v>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state ch=
ange 3288824952 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel=
: drbd r0: Aborting cluster-wide state change 3288824952 (1ms) rv =3D -19</=
div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide s=
tate change 2274965928 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01=
 kernel: drbd r0: Aborting cluster-wide state change 2274965928 (1ms) rv =
=3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing clust=
er-wide state change 3641522607 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18=
 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 3641522607 (1=
ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparin=
g cluster-wide state change 3926057794 (0-&gt;2 499/146)</div><div>Feb 18 1=
2:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 392605=
7794 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: P=
reparing cluster-wide state change 128435041 (0-&gt;1 499/146)</div><div>Fe=
b 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change =
128435041 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd =
r0: Preparing cluster-wide state change 620951758 (0-&gt;2 499/146)</div><d=
iv>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state ch=
ange 620951758 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: =
drbd r0: Preparing cluster-wide state change 1067274131 (0-&gt;1 499/146)</=
div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide st=
ate change 1067274131 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 k=
ernel: drbd r0: Preparing cluster-wide state change 3401606816 (0-&gt;2 499=
/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-=
wide state change 3401606816 (2ms) rv =3D -19</div><div>Feb 18 12:49:18 drb=
d9-01 kernel: drbd r0: Preparing cluster-wide state change 2464745589 (0-&g=
t;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting c=
luster-wide state change 2464745589 (0ms) rv =3D -19</div><div>Feb 18 12:49=
:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 357563827=
2 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Abo=
rting cluster-wide state change 3575638272 (2ms) rv =3D -19</div><div>Feb 1=
8 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 28=
9378464 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r=
0: Aborting cluster-wide state change 289378464 (0ms) rv =3D -19</div><div>=
Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chan=
ge 1793285500 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: =
drbd r0: Aborting cluster-wide state change 1793285500 (0ms) rv =3D -19</di=
v><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide sta=
te change 2159434546 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 k=
ernel: drbd r0: Aborting cluster-wide state change 2159434546 (1ms) rv =3D =
-19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-w=
ide state change 3776803522 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drb=
d9-01 kernel: drbd r0: Aborting cluster-wide state change 3776803522 (1ms) =
rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cl=
uster-wide state change 2020636307 (0-&gt;1 499/146)</div><div>Feb 18 12:49=
:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 2020636307=
 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Prepa=
ring cluster-wide state change 2574235971 (0-&gt;2 499/146)</div><div>Feb 1=
8 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 257=
4235971 (0ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0=
: Preparing cluster-wide state change 1115473996 (0-&gt;1 499/146)</div><di=
v>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state cha=
nge 1115473996 (13ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel:=
 drbd r0: Preparing cluster-wide state change 1681934234 (0-&gt;2 499/146)<=
/div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide s=
tate change 1681934234 (0ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 =
kernel: drbd r0: Preparing cluster-wide state change 2926904129 (0-&gt;1 49=
9/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster=
-wide state change 2926904129 (0ms) rv =3D -19</div><div>Feb 18 12:49:18 dr=
bd9-01 kernel: drbd r0: Preparing cluster-wide state change 1651456969 (0-&=
gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting =
cluster-wide state change 1651456969 (0ms) rv =3D -19</div><div>Feb 18 12:4=
9:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 15782497=
47 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Ab=
orting cluster-wide state change 1578249747 (0ms) rv =3D -19</div><div>Feb =
18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 4=
30284320 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd =
r0: Aborting cluster-wide state change 430284320 (0ms) rv =3D -19</div><div=
>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state cha=
nge 4168451443 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel:=
 drbd r0: Aborting cluster-wide state change 4168451443 (0ms) rv =3D -19</d=
iv><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide st=
ate change 3304566520 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 =
kernel: drbd r0: Aborting cluster-wide state change 3304566520 (0ms) rv =3D=
 -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-=
wide state change 2489323610 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 dr=
bd9-01 kernel: drbd r0: Aborting cluster-wide state change 2489323610 (0ms)=
 rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing c=
luster-wide state change 2784036568 (0-&gt;2 499/146)</div><div>Feb 18 12:4=
9:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 278403656=
8 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Prep=
aring cluster-wide state change 2444898555 (0-&gt;1 499/146)</div><div>Feb =
18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 24=
44898555 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r=
0: Preparing cluster-wide state change 2821131655 (0-&gt;2 499/146)</div><d=
iv>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide state ch=
ange 2821131655 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 kernel:=
 drbd r0: Preparing cluster-wide state change 649862413 (0-&gt;1 499/146)</=
div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-wide st=
ate change 649862413 (0ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd9-01 ke=
rnel: drbd r0: Preparing cluster-wide state change 1360241560 (0-&gt;2 499/=
146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cluster-w=
ide state change 1360241560 (1ms) rv =3D -19</div><div>Feb 18 12:49:18 drbd=
9-01 kernel: drbd r0: Preparing cluster-wide state change 3610428486 (0-&gt=
;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Aborting cl=
uster-wide state change 3610428486 (0ms) rv =3D -19</div><div>Feb 18 12:49:=
18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 2654692450=
 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Abor=
ting cluster-wide state change 2654692450 (0ms) rv =3D -19</div><div>Feb 18=
 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 237=
694475 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0=
: Aborting cluster-wide state change 237694475 (0ms) rv =3D -19</div><div>F=
eb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide state chang=
e 2561046587 (0-&gt;2 499/146)</div><div>Feb 18 12:49:18 drbd9-01 kernel: d=
rbd r0: Aborting cluster-wide state change 2561046587 (0ms) rv =3D -19</div=
><div>Feb 18 12:49:18 drbd9-01 kernel: drbd r0: Preparing cluster-wide stat=
e change 2123728468 (0-&gt;1 499/146)</div><div>Feb 18 12:49:18 drbd9-01 ke=
rnel: drbd r0: Aborting cluster-wide state change 2123728468 (0ms) rv =3D -=
19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wi=
de state change 1716193777 (0-&gt;2 499/146)</div><div>Feb 18 12:49:19 drbd=
9-01 kernel: drbd r0: Aborting cluster-wide state change 1716193777 (1ms) r=
v =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing clu=
ster-wide state change 954801834 (0-&gt;1 499/146)</div><div>Feb 18 12:49:1=
9 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 954801834 (1=
ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparin=
g cluster-wide state change 997680699 (0-&gt;2 499/146)</div><div>Feb 18 12=
:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 9976806=
99 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Pre=
paring cluster-wide state change 1595210697 (0-&gt;1 499/146)</div><div>Feb=
 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 1=
595210697 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd =
r0: Preparing cluster-wide state change 1795247459 (0-&gt;2 499/146)</div><=
div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state c=
hange 1795247459 (7ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel=
: drbd r0: Preparing cluster-wide state change 1312694431 (0-&gt;1 499/146)=
</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide =
state change 1312694431 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01=
 kernel: drbd r0: Preparing cluster-wide state change 1531206635 (0-&gt;2 4=
99/146)</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluste=
r-wide state change 1531206635 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 d=
rbd9-01 kernel: drbd r0: Preparing cluster-wide state change 1379557998 (0-=
&gt;1 499/146)</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting=
 cluster-wide state change 1379557998 (1ms) rv =3D -19</div><div>Feb 18 12:=
49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 3792084=
596 (0-&gt;2 499/146)</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: A=
borting cluster-wide state change 3792084596 (1ms) rv =3D -19</div><div>Feb=
 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change =
1368060281 (0-&gt;1 499/146)</div><div>Feb 18 12:49:19 drbd9-01 kernel: drb=
d r0: Aborting cluster-wide state change 1368060281 (1ms) rv =3D -19</div><=
div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide state =
change 3569716009 (0-&gt;2 499/146)</div><div>Feb 18 12:49:19 drbd9-01 kern=
el: drbd r0: Aborting cluster-wide state change 3569716009 (1ms) rv =3D -19=
</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing cluster-wide=
 state change 1393085582 (0-&gt;1 499/146)</div><div>Feb 18 12:49:19 drbd9-=
01 kernel: drbd r0: Aborting cluster-wide state change 1393085582 (1ms) rv =
=3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparing clust=
er-wide state change 4267014762 (0-&gt;2 499/146)</div><div>Feb 18 12:49:19=
 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 4267014762 (1=
ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Preparin=
g cluster-wide state change 1428881181 (0-&gt;1 499/146)</div><div>Feb 18 1=
2:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change 142888=
1181 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: P=
reparing cluster-wide state change 1718804050 (0-&gt;2 499/146)</div><div>F=
eb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state change=
 1718804050 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel: drb=
d r0: Preparing cluster-wide state change 610769045 (0-&gt;1 499/146)</div>=
<div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide state =
change 610769045 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 kernel=
: drbd r0: Preparing cluster-wide state change 795605995 (0-&gt;2 499/146)<=
/div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-wide s=
tate change 795605995 (2ms) rv =3D -19</div><div>Feb 18 12:49:19 drbd9-01 k=
ernel: drbd r0: Preparing cluster-wide state change 2783224475 (0-&gt;1 499=
/146)</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0: Aborting cluster-=
wide state change 2783224475 (1ms) rv =3D -19</div><div>Feb 18 12:49:19 drb=
d9-01 kernel: drbd r0 drbd9-02: conn( Connecting -&gt; Disconnecting )</div=
><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: ack_receiver termi=
nated</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Terminat=
ing ack_recv thread</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd=
9-02: Connection closed</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 =
drbd9-02: conn( Disconnecting -&gt; StandAlone )</div><div>Feb 18 12:49:19 =
drbd9-01 kernel: drbd r0 drbd9-02: Terminating receiver thread</div><div>Fe=
b 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-02: Terminating sender thread<=
/div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: conn( Connecti=
ng -&gt; Disconnecting )</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0=
 drbd9-03: ack_receiver terminated</div><div>Feb 18 12:49:19 drbd9-01 kerne=
l: drbd r0 drbd9-03: Terminating ack_recv thread</div><div>Feb 18 12:49:19 =
drbd9-01 kernel: drbd r0 drbd9-03: Connection closed</div><div>Feb 18 12:49=
:19 drbd9-01 kernel: drbd r0 drbd9-03: conn( Disconnecting -&gt; StandAlone=
 )</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-03: Terminating=
 receiver thread</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-0=
3: Terminating sender thread</div><div>Feb 18 12:49:19 drbd9-01 kernel: drb=
d r0 drbd9-04: conn( Connecting -&gt; Disconnecting )</div><div>Feb 18 12:4=
9:19 drbd9-01 kernel: drbd r0 drbd9-04: Connection closed</div><div>Feb 18 =
12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: conn( Disconnecting -&gt; Stand=
Alone )</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-04: Termin=
ating receiver thread</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 dr=
bd9-04: Terminating sender thread</div><div>Feb 18 12:49:19 drbd9-01 kernel=
: drbd r0 drbd9-05: conn( Connecting -&gt; Disconnecting )</div><div>Feb 18=
 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: Connection closed</div><div>Fe=
b 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: conn( Disconnecting -&gt; =
StandAlone )</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0 drbd9-05: T=
erminating receiver thread</div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd =
r0 drbd9-05: Terminating sender thread</div><div>Feb 18 12:49:19 drbd9-01 k=
ernel: drbd r0/0 drbd1: disk( UpToDate -&gt; Detaching )</div><div>Feb 18 1=
2:49:19 drbd9-01 kernel: drbd r0/0 drbd1: disk( Detaching -&gt; Diskless )<=
/div><div>Feb 18 12:49:19 drbd9-01 kernel: drbd r0/0 drbd1: drbd_bm_resize =
called with capacity =3D=3D 0</div><div>Feb 18 12:49:19 drbd9-01 kernel: dr=
bd r0: Terminating worker thread</div><div>Feb 18 12:49:29 drbd9-01 kernel:=
 drbd r0: Starting worker thread (from drbdsetup [32709])</div><div>Feb 18 =
12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: disk( Diskless -&gt; Attaching )=
</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: Maximum number=
 of peer devices =3D 4</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0: =
Method to ensure write ordering: flush</div><div>Feb 18 12:49:29 drbd9-01 k=
ernel: drbd r0/0 drbd1: peer does not support WRITE_SAME</div><div>Feb 18 1=
2:49:29 drbd9-01 kernel: drbd r0/0 drbd1: Adjusting my ra_pages to backing =
device&#39;s (32 -&gt; 1024)</div><div>Feb 18 12:49:29 drbd9-01 kernel: drb=
d r0/0 drbd1: drbd_bm_resize called with capacity =3D=3D 9996656</div><div>=
Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: resync bitmap: bits=3D124=
9582 words=3D78100 pages=3D153</div><div>Feb 18 12:49:29 drbd9-01 kernel: d=
rbd r0/0 drbd1: recounting of set bits took additional 0ms</div><div>Feb 18=
 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: disk( Attaching -&gt; Inconsist=
ent )</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0/0 drbd1: attached =
to current UUID: 0000000000000004</div><div>Feb 18 12:49:29 drbd9-01 kernel=
: drbd r0 drbd9-02: Starting sender thread (from drbdsetup [32719])</div><d=
iv>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: Starting sender threa=
d (from drbdsetup [32723])</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd =
r0 drbd9-04: Starting sender thread (from drbdsetup [32726])</div><div>Feb =
18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-05: Starting sender thread (from=
 drbdsetup [32729])</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd=
9-02: conn( StandAlone -&gt; Unconnected )</div><div>Feb 18 12:49:29 drbd9-=
01 kernel: drbd r0 drbd9-02: Starting receiver thread (from drbd_w_r0 [3271=
0])</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: conn( Stan=
dAlone -&gt; Unconnected )</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd =
r0 drbd9-03: Starting receiver thread (from drbd_w_r0 [32710])</div><div>Fe=
b 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-02: conn( Unconnected -&gt; Co=
nnecting )</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: con=
n( StandAlone -&gt; Unconnected )</div><div>Feb 18 12:49:29 drbd9-01 kernel=
: drbd r0 drbd9-04: Starting receiver thread (from drbd_w_r0 [32710])</div>=
<div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-03: conn( Unconnected -=
&gt; Connecting )</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-=
05: conn( StandAlone -&gt; Unconnected )</div><div>Feb 18 12:49:29 drbd9-01=
 kernel: drbd r0 drbd9-05: Starting receiver thread (from drbd_w_r0 [32710]=
)</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0 drbd9-04: conn( Unconn=
ected -&gt; Connecting )</div><div>Feb 18 12:49:29 drbd9-01 kernel: drbd r0=
 drbd9-05: conn( Unconnected -&gt; Connecting )</div><div>Feb 18 12:49:30 d=
rbd9-01 kernel: drbd r0 drbd9-03: Handshake successful: Agreed network prot=
ocol version 111</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-0=
3: Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME=
.</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: Starting ack=
_recv thread (from drbd_r_r0 [32736])</div><div>Feb 18 12:49:30 drbd9-01 ke=
rnel: drbd r0: Preparing cluster-wide state change 444800473 (0-&gt;2 499/1=
46)</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0: State change 444800=
473: primary_nodes=3D0, weak_nodes=3D0</div><div>Feb 18 12:49:30 drbd9-01 k=
ernel: drbd r0: Committing cluster-wide state change 444800473 (0ms)</div><=
div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0 drbd9-03: conn( Connecting -&g=
t; Connected ) peer( Unknown -&gt; Secondary )</div><div>Feb 18 12:49:30 dr=
bd9-01 kernel: drbd r0/0 drbd1: peer does not support WRITE_SAME</div><div>=
Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: drbd_sync_handsh=
ake:</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: s=
elf 0000000000000004:0000000000000000:0000000000000000:0000000000000000 bit=
s:0 flags:0</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd=
9-03: peer B6CAADFB7D215BC6:FFFFFFFFFFFFFFFF:B6CAADFB7D215BC6:0000000000000=
000 bits:0 flags:20</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 dr=
bd1 drbd9-03: uuid_compare()=3D-3 by rule 20</div><div>Feb 18 12:49:30 drbd=
9-01 kernel: drbd r0/0 drbd1 drbd9-03: Writing the whole bitmap, full sync =
required after drbd_sync_handshake.</div><div>Feb 18 12:49:30 drbd9-01 kern=
el: drbd r0/0 drbd1 drbd9-03: pdsk( DUnknown -&gt; UpToDate ) repl( Off -&g=
t; WFBitMapT )</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1: =
size =3D 4881 MB (4998328 KB)</div><div>Feb 18 12:49:30 drbd9-01 kernel: dr=
bd r0/0 drbd1 drbd9-03: receive bitmap stats [Bytes(packets)]: plain 0(0), =
RLE 21(1), total 21; compression: 100.0%</div><div>Feb 18 12:49:30 drbd9-01=
 kernel: drbd r0/0 drbd1 drbd9-03: send bitmap stats [Bytes(packets)]: plai=
n 0(0), RLE 21(1), total 21; compression: 100.0%</div><div>Feb 18 12:49:30 =
drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper command: /sbin/drbdadm be=
fore-resync-target</div><div>Feb 18 12:49:30 drbd9-01 drbdadm[32746]: Don&#=
39;t know which config file belongs to resource r0, trying default ones...<=
/div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper=
 command: /sbin/drbdadm before-resync-target exit code 0 (0x0)</div><div>Fe=
b 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-05: resync-susp( no -&=
gt; connection dependency )</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd=
 r0/0 drbd1 drbd9-04: resync-susp( no -&gt; connection dependency )</div><d=
iv>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: repl( WFBitMa=
pT -&gt; SyncTarget )</div><div>Feb 18 12:49:30 drbd9-01 kernel: drbd r0/0 =
drbd1 drbd9-02: resync-susp( no -&gt; connection dependency )</div><div>Feb=
 18 12:49:30 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: Began resync as Syn=
cTarget (will sync 4998328 KB [1249582 bits set]).</div><div>Feb 18 12:49:3=
3 drbd9-01 kernel: drbd r0 tcp:drbd9-02: Receiver busy; rejecting incoming =
connection</div><div>Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Han=
dshake successful: Agreed network protocol version 111</div><div>Feb 18 12:=
49:41 drbd9-01 kernel: drbd r0 drbd9-02: Feature flags enabled on protocol =
level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Feb 18 12:49:41 drbd9-01 =
kernel: drbd r0 drbd9-02: Starting ack_recv thread (from drbd_r_r0 [32734])=
</div><div>Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: sock was shut=
 down by peer</div><div>Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: =
conn( Connecting -&gt; BrokenPipe )</div><div>Feb 18 12:49:41 drbd9-01 kern=
el: drbd r0 drbd9-02: ack_receiver terminated</div><div>Feb 18 12:49:41 drb=
d9-01 kernel: drbd r0 drbd9-02: Terminating ack_recv thread</div><div>Feb 1=
8 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Connection closed</div><div>F=
eb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: conn( BrokenPipe -&gt; Un=
connected )</div><div>Feb 18 12:49:41 drbd9-01 kernel: drbd r0 drbd9-02: Re=
starting receiver thread</div><div>Feb 18 12:49:41 drbd9-01 kernel: drbd r0=
 drbd9-02: conn( Unconnected -&gt; Connecting )</div><div>Feb 18 12:49:42 d=
rbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet S crossed</div><div>Fe=
b 18 12:49:54 drbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet M cross=
ed</div><div>Feb 18 12:49:55 drbd9-01 kernel: drbd r0 drbd9-03: Preparing r=
emote state change 2594601400 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:50:01 drbd9-01 systemd: Starting Session 295 of user root.</div>=
<div>Feb 18 12:50:01 drbd9-01 systemd: Started Session 295 of user root.</d=
iv><div>Feb 18 12:50:25 drbd9-01 kernel: drbd r0 drbd9-03: Aborting remote =
state change 2594601400</div><div>Feb 18 12:50:25 drbd9-01 kernel: drbd r0 =
drbd9-03: Preparing remote state change 1091225699 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:50:25 drbd9-01 kernel: drbd r0 drbd9-03: Co=
mmitting remote state change 1091225699</div><div>Feb 18 12:50:26 drbd9-01 =
kernel: drbd r0 drbd9-03: Preparing remote state change 583992461 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:50:26 drbd9-01 kernel: drbd =
r0 drbd9-03: Committing remote state change 583992461</div><div>Feb 18 12:5=
1:11 drbd9-01 kernel: drbd r0 tcp:drbd9-02: initial packet S crossed</div><=
div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02: Handshake successful=
: Agreed network protocol version 111</div><div>Feb 18 12:51:23 drbd9-01 ke=
rnel: drbd r0 drbd9-02: Feature flags enabled on protocol level: 0x7 TRIM T=
HIN_RESYNC WRITE_SAME.</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0 d=
rbd9-02: Starting ack_recv thread (from drbd_r_r0 [32734])</div><div>Feb 18=
 12:51:23 drbd9-01 kernel: drbd r0: Preparing cluster-wide state change 955=
356902 (0-&gt;1 499/146)</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0=
: State change 955356902: primary_nodes=3D0, weak_nodes=3D0</div><div>Feb 1=
8 12:51:23 drbd9-01 kernel: drbd r0: Committing cluster-wide state change 9=
55356902 (1ms)</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0 drbd9-02:=
 conn( Connecting -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><d=
iv>Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1: peer does not support =
WRITE_SAME</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1 drbd9=
-02: drbd_sync_handshake:</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r=
0/0 drbd1 drbd9-02: self 0000000000000004:0000000000000000:0000000000000000=
:0000000000000000 bits:570368 flags:0</div><div>Feb 18 12:51:23 drbd9-01 ke=
rnel: drbd r0/0 drbd1 drbd9-02: peer 0000000000000004:FFFFFFFFFFFFFFFF:0000=
000000000000:0000000000000000 bits:0 flags:24</div><div>Feb 18 12:51:23 drb=
d9-01 kernel: drbd r0/0 drbd1 drbd9-02: uuid_compare()=3D0 by rule 10</div>=
<div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd1: No resync, but 57036=
8 bits in bitmap!</div><div>Feb 18 12:51:23 drbd9-01 kernel: drbd r0/0 drbd=
1 drbd9-02: pdsk( DUnknown -&gt; Inconsistent ) repl( Off -&gt; Established=
 )</div><div>Feb 18 12:51:24 drbd9-01 kernel: drbd r0 drbd9-02: Preparing r=
emote state change 515638917 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state ch=
ange 515638917</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 137570080 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 137570080</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd =
r0 drbd9-02: Preparing remote state change 997229091 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: =
Aborting remote state change 997229091</div><div>Feb 18 12:51:25 drbd9-01 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 82178736 (primary_no=
des=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0=
 drbd9-02: Aborting remote state change 82178736</div><div>Feb 18 12:51:25 =
drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state change 3821653145=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:25 drbd9-01 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 3821653145</div><div>Fe=
b 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state cha=
nge 2763345815 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:2=
5 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state change 276334581=
5</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Preparing re=
mote state change 2378645705 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state ch=
ange 2378645705</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02=
: Preparing remote state change 1701376328 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:51:25 drbd9-01 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 1701376328</div><div>Feb 18 12:51:26 drbd9-01 kernel: =
drbd r0 drbd9-02: Preparing remote state change 404563979 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9=
-02: Aborting remote state change 404563979</div><div>Feb 18 12:51:26 drbd9=
-01 kernel: drbd r0 drbd9-02: Preparing remote state change 2322165605 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: =
drbd r0 drbd9-02: Aborting remote state change 2322165605</div><div>Feb 18 =
12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state change 3=
116638354 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drb=
d9-01 kernel: drbd r0 drbd9-02: Aborting remote state change 3116638354</di=
v><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote =
state change 4171949499 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 1=
8 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state change =
4171949499</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Pre=
paring remote state change 4153763848 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote=
 state change 4153763848</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0=
 drbd9-02: Preparing remote state change 1547352803 (primary_nodes=3D0, wea=
k_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: A=
borting remote state change 1547352803</div><div>Feb 18 12:51:26 drbd9-01 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 1194426093 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd =
r0 drbd9-02: Aborting remote state change 1194426093</div><div>Feb 18 12:51=
:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state change 314178=
0427 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01=
 kernel: drbd r0 drbd9-02: Aborting remote state change 3141780427</div><di=
v>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state=
 change 2111985163 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state change 21119=
85163</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 3255414054 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote stat=
e change 3255414054</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd=
9-02: Preparing remote state change 993220877 (primary_nodes=3D0, weak_node=
s=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Abortin=
g remote state change 993220877</div><div>Feb 18 12:51:26 drbd9-01 kernel: =
drbd r0 drbd9-02: Preparing remote state change 2752612106 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 2752612106</div><div>Feb 18 12:51:26 d=
rbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state change 1639712018 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kern=
el: drbd r0 drbd9-02: Aborting remote state change 1639712018</div><div>Feb=
 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 793028279 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 =
drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state change 793028279</=
div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remot=
e state change 1975781053 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remote state chang=
e 1975781053</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: P=
reparing remote state change 402090143 (primary_nodes=3D0, weak_nodes=3D0)<=
/div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: Aborting remot=
e state change 402090143</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0=
 drbd9-02: Preparing remote state change 1357840858 (primary_nodes=3D0, wea=
k_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd r0 drbd9-02: A=
borting remote state change 1357840858</div><div>Feb 18 12:51:26 drbd9-01 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 4293365755 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:26 drbd9-01 kernel: drbd =
r0 drbd9-02: Aborting remote state change 4293365755</div><div>Feb 18 12:51=
:27 drbd9-01 kernel: drbd r0 drbd9-02: Preparing remote state change 329652=
6104 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:27 drbd9-01=
 kernel: drbd r0 drbd9-02: Aborting remote state change 3296526104</div><di=
v>Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: PingAck did not arrive=
 in time.</div><div>Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: conn=
( Connected -&gt; NetworkFailure ) peer( Secondary -&gt; Unknown )</div><di=
v>Feb 18 12:51:44 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: repl( Establis=
hed -&gt; Off )</div><div>Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02=
: ack_receiver terminated</div><div>Feb 18 12:51:44 drbd9-01 kernel: drbd r=
0 drbd9-02: Terminating ack_recv thread</div><div>Feb 18 12:51:44 drbd9-01 =
kernel: drbd r0/0 drbd1: ASSERTION list_empty(&amp;device-&gt;done_ee) FAIL=
ED in drbd_disconnected</div><div>Feb 18 12:51:44 drbd9-01 kernel: drbd r0 =
drbd9-02: Connection closed</div><div>Feb 18 12:51:44 drbd9-01 kernel: drbd=
 r0 drbd9-02: conn( NetworkFailure -&gt; Unconnected )</div><div>Feb 18 12:=
51:44 drbd9-01 kernel: drbd r0 drbd9-02: Restarting receiver thread</div><d=
iv>Feb 18 12:51:44 drbd9-01 kernel: drbd r0 drbd9-02: conn( Unconnected -&g=
t; Connecting )</div><div>Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 =
drbd9-03: Resync done (total 147 sec; paused 0 sec; 34000 K/sec)</div><div>=
Feb 18 12:51:57 drbd9-01 drbdadm[32809]: Don&#39;t know which config file b=
elongs to resource r0, trying default ones...</div><div>Feb 18 12:51:57 drb=
d9-01 kernel: drbd r0/0 drbd1 drbd9-03: updated UUIDs B6CAADFB7D215BC6:0000=
000000000000:0000000000000000:0000000000000000</div><div>Feb 18 12:51:57 dr=
bd9-01 kernel: drbd r0/0 drbd1: disk( Inconsistent -&gt; UpToDate )</div><d=
iv>Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-05: pdsk( DUnknow=
n -&gt; Outdated ) resync-susp( connection dependency -&gt; no )</div><div>=
Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-04: resync-susp( con=
nection dependency -&gt; no )</div><div>Feb 18 12:51:57 drbd9-01 kernel: dr=
bd r0/0 drbd1 drbd9-03: repl( SyncTarget -&gt; Established )</div><div>Feb =
18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-02: resync-susp( connect=
ion dependency -&gt; no )</div><div>Feb 18 12:51:57 drbd9-01 kernel: drbd r=
0/0 drbd1 drbd9-03: helper command: /sbin/drbdadm after-resync-target</div>=
<div>Feb 18 12:51:57 drbd9-01 kernel: drbd r0/0 drbd1 drbd9-03: helper comm=
and: /sbin/drbdadm after-resync-target exit code 0 (0x0)</div></div><div><b=
r></div><div><br></div><div><br></div><div><br></div>2) Node2<div><br>Feb 1=
8 12:49:15 drbd9-02 drbdadm[17377]: Don&#39;t know which config file belong=
s to resource r0, trying default ones...<br>Feb 18 12:49:15 drbd9-02 kernel=
: drbd r0/0 drbd1 drbd9-04: helper command: /sbin/drbdadm before-resync-sou=
rce exit code 0 (0x0)<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0/0 drbd1 d=
rbd9-04: repl( WFBitMapS -&gt; PausedSyncS )<br>Feb 18 12:49:15 drbd9-02 ke=
rnel: drbd r0/0 drbd1 drbd9-04: Began resync as PausedSyncS (will sync 4998=
328 KB [1249582 bits set]).<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drb=
d9-03: Preparing remote state change 352665508 (primary_nodes=3D0, weak_nod=
es=3D0)<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting con=
current remote state change 3171251231 because of state change 352665508<br=
>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state c=
hange 352665508<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Prepa=
ring remote state change 1037382588 (primary_nodes=3D0, weak_nodes=3D0)<br>=
Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent rem=
ote state change 141488321 because of state change 1037382588<br>Feb 18 12:=
49:15 drbd9-02 kernel: drbd r0 drbd9-01: Ignoring P_TWOPC_ABORT packet 1414=
88321.<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remot=
e state change 1037382588<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9=
-03: Preparing remote state change 399118927 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concu=
rrent remote state change 1396949391 because of state change 399118927<br>F=
eb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state cha=
nge 399118927<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Prepari=
ng remote state change 1547038261 (primary_nodes=3D0, weak_nodes=3D0)<br>Fe=
b 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state chan=
ge 1547038261<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Prepari=
ng remote state change 90711453 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb =
18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change=
 90711453<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing r=
emote state change 2906061427 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18=
 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 2=
906061427<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing r=
emote state change 110758586 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 =
12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 11=
0758586<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing rem=
ote state change 19982401 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:=
49:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 19982=
401<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 1229720926 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 1229720=
926<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote =
state change 2599231352 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 2599231=
352<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 1975668868 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 1975668=
868<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote =
state change 2505675278 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:15 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 2505675=
278<br>Feb 18 12:49:15 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 4000831140 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:15 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 4000831=
140<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote =
state change 2750887982 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 2750887=
982<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 2468909229 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 2468909=
229<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote =
state change 2662778291 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:16 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 2662778=
291<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 4035033791 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 4035033=
791<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 1708023363 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49=
:16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 1708023=
363<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote =
state change 575587423 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:=
16 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 57558742=
3<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote st=
ate change 3005066576 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:1=
6 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 300506657=
6<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote st=
ate change 2982970747 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:1=
6 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 298297074=
7<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote st=
ate change 1635237549 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:1=
6 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote state change 163523754=
9<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote st=
ate change 3629941899 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:1=
6 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote state change 362994189=
9<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote st=
ate change 3563238485 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:1=
6 drbd9-02 kernel: drbd r0 drbd9-01: Rejecting concurrent remote state chan=
ge 2815311641 because of state change 3563238485<br>Feb 18 12:49:16 drbd9-0=
2 kernel: drbd r0 drbd9-03: Aborting remote state change 3563238485<br>Feb =
18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state chang=
e 3238325029 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-0=
2 kernel: drbd r0 drbd9-01: Rejecting concurrent remote state change 212609=
1279 because of state change 3238325029<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-03: Aborting remote state change 3238325029<br>Feb 18 12:49:=
16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state change 3638753=
626 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-03: Aborting remote state change 3638753626<br>Feb 18 12:49:=
16 drbd9-02 kernel: drbd r0 drbd9-01: Preparing remote state change 3599232=
118 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-01: Aborting remote state change 3599232118<br>Feb 18 12:49:=
16 drbd9-02 kernel: drbd r0 drbd9-03: Preparing remote state change 1131463=
77 (primary_nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: =
drbd r0 drbd9-01: Rejecting concurrent remote state change 776632002 becaus=
e of state change 113146377<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drb=
d9-03: Aborting remote state change 113146377<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 3173991607 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 3173991607<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 3766324938 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 3766324938<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 1350394170 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 1350394170<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-03: Preparing remote state change 2874348269 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-03: Aborting remote state change 2874348269<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 1961866418 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 1961866418<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 1422080841 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 1422080841<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 1935970639 (primary_=
nodes=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd=
9-01: Aborting remote state change 1935970639<br>Feb 18 12:49:16 drbd9-02 k=
ernel: drbd r0 drbd9-03: Preparing remote state change 36989052 (primary_no=
des=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-=
03: Aborting remote state change 36989052<br>Feb 18 12:49:16 drbd9-02 kerne=
l: drbd r0 drbd9-01: Preparing remote state change 582050229 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 582050229<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-03: Preparing remote state change 4192500224 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 4192500224<br>Feb 18 12:49:16 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2039128137 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2039128137<br>Feb 18 12:49:16 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 821093755 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 821093755<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-01: Preparing remote state change 3518597027 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3518597027<br>Feb 18 12:49:16 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 452858682 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 452858682<br>Feb 18 12:49:16 drbd9-02 kernel:=
 drbd r0 drbd9-01: Preparing remote state change 2321677588 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:16 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2321677588<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3637280121 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3637280121<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 261689227 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 261689227<br>Feb 18 12:49:17 drbd9-02 kernel:=
 drbd r0 drbd9-03: Preparing remote state change 1843385190 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 1843385190<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3197178194 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3197178194<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 767463344 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 767463344<br>Feb 18 12:49:17 drbd9-02 kernel:=
 drbd r0 drbd9-01: Preparing remote state change 3875723021 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3875723021<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3351946337 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3351946337<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3454915512 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3454915512<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2640937765 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2640937765<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3044822599 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3044822599<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3354987837 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3354987837<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3556374775 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3556374775<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2026795642 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2026795642<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 1409529751 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 1409529751<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3085364587 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3085364587<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 1803219856 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 1803219856<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2423822761 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2423822761<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2070740492 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2070740492<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 424571609 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 424571609<br>Feb 18 12:49:17 drbd9-02 kernel:=
 drbd r0 drbd9-01: Preparing remote state change 1861094959 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 1861094959<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 1439155988 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 1439155988<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 1912776257 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 1912776257<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3342040311 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3342040311<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3583634975 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3583634975<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3560986460 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3560986460<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 1059596388 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 1059596388<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2039774846 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2039774846<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2984515839 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2984515839<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2729731529 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2729731529<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3776435962 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3776435962<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 1499748024 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 1499748024<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2633932659 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2633932659<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 3420883318 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 3420883318<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3805539839 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3805539839<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 2892821134 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 2892821134<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-01: Preparing remote state change 3642844571 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 3642844571<br>Feb 18 12:49:17 drbd9-02 kernel=
: drbd r0 drbd9-03: Preparing remote state change 110768160 (primary_nodes=
=3D0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 110768160<br>Feb 18 12:49:17 drbd9-02 kernel:=
 drbd r0 drbd9-01: Preparing remote state change 17859418 (primary_nodes=3D=
0, weak_nodes=3D0)<br>Feb 18 12:49:17 drbd9-02 kernel: drbd r0 drbd9-01: Ab=
orting remote state change 17859418<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-03: Preparing remote state change 1919413000 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Abor=
ting remote state change 1919413000<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-01: Preparing remote state change 1145386916 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Abor=
ting remote state change 1145386916<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-03: Preparing remote state change 2321101024 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Abor=
ting remote state change 2321101024<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-01: Preparing remote state change 3288824952 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Abor=
ting remote state change 3288824952<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-03: Preparing remote state change 2274965928 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Abor=
ting remote state change 2274965928<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-01: Preparing remote state change 3641522607 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Abor=
ting remote state change 3641522607<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-03: Preparing remote state change 3926057794 (primary_nodes=3D0,=
 weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Abor=
ting remote state change 3926057794<br>Feb 18 12:49:18 drbd9-02 kernel: drb=
d r0 drbd9-01: Preparing remote state change 128435041 (primary_nodes=3D0, =
weak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Abort=
ing remote state change 128435041<br>Feb 18 12:49:18 drbd9-02 kernel: drbd =
r0 drbd9-03: Preparing remote state change 620951758 (primary_nodes=3D0, we=
ak_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Abortin=
g remote state change 620951758<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0=
 drbd9-01: Preparing remote state change 1067274131 (primary_nodes=3D0, wea=
k_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 1067274131<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0=
 drbd9-03: Preparing remote state change 3401606816 (primary_nodes=3D0, wea=
k_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 3401606816<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0=
 drbd9-01: Preparing remote state change 2464745589 (primary_nodes=3D0, wea=
k_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 2464745589<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0=
 drbd9-03: Preparing remote state change 3575638272 (primary_nodes=3D0, wea=
k_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 3575638272<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0=
 drbd9-01: Preparing remote state change 289378464 (primary_nodes=3D0, weak=
_nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting =
remote state change 289378464<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 1793285500 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting r=
emote state change 1793285500<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 2159434546 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting r=
emote state change 2159434546<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 3776803522 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting r=
emote state change 3776803522<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 2020636307 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting r=
emote state change 2020636307<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 2574235971 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting r=
emote state change 2574235971<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 1115473996 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting r=
emote state change 1115473996<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 1681934234 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting r=
emote state change 1681934234<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 2926904129 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting r=
emote state change 2926904129<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 1651456969 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting r=
emote state change 1651456969<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 1578249747 (primary_nodes=3D0, weak_=
nodes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting r=
emote state change 1578249747<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 430284320 (primary_nodes=3D0, weak_n=
odes=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting re=
mote state change 430284320<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-01: Preparing remote state change 4168451443 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting rem=
ote state change 4168451443<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-03: Preparing remote state change 3304566520 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting rem=
ote state change 3304566520<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-01: Preparing remote state change 2489323610 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting rem=
ote state change 2489323610<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-03: Preparing remote state change 2784036568 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting rem=
ote state change 2784036568<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-01: Preparing remote state change 2444898555 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting rem=
ote state change 2444898555<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-03: Preparing remote state change 2821131655 (primary_nodes=3D0, weak_no=
des=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting rem=
ote state change 2821131655<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drb=
d9-01: Preparing remote state change 649862413 (primary_nodes=3D0, weak_nod=
es=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remo=
te state change 649862413<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9=
-03: Preparing remote state change 1360241560 (primary_nodes=3D0, weak_node=
s=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remot=
e state change 1360241560<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9=
-01: Preparing remote state change 3610428486 (primary_nodes=3D0, weak_node=
s=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remot=
e state change 3610428486<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9=
-03: Preparing remote state change 2654692450 (primary_nodes=3D0, weak_node=
s=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remot=
e state change 2654692450<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9=
-01: Preparing remote state change 237694475 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 237694475<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 2561046587 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 2561046587<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 2123728468 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 2123728468<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 1716193777 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:18 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 1716193777<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 954801834 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 954801834<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 997680699 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 997680699<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-0=
1: Preparing remote state change 1595210697 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1595210697<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 1795247459 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 1795247459<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 1312694431 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1312694431<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 1531206635 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 1531206635<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 1379557998 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1379557998<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 3792084596 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 3792084596<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 1368060281 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1368060281<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 3569716009 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 3569716009<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 1393085582 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1393085582<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 4267014762 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 4267014762<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 1428881181 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1428881181<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
03: Preparing remote state change 1718804050 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 1718804050<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: Preparing remote state change 610769045 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 610769045<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 795605995 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 795605995<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-0=
1: Preparing remote state change 2783224475 (primary_nodes=3D0, weak_nodes=
=3D0)<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 2783224475<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-=
01: sock was shut down by peer<br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 =
drbd9-01: conn( Connecting -&gt; BrokenPipe )<br>Feb 18 12:49:19 drbd9-02 k=
ernel: drbd r0 drbd9-01: ack_receiver terminated<br>Feb 18 12:49:19 drbd9-0=
2 kernel: drbd r0 drbd9-01: Terminating ack_recv thread<br>Feb 18 12:49:19 =
drbd9-02 kernel: drbd r0 drbd9-01: Connection closed<br>Feb 18 12:49:19 drb=
d9-02 kernel: drbd r0 drbd9-01: conn( BrokenPipe -&gt; Unconnected )<br>Feb=
 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: Restarting receiver thread<=
br>Feb 18 12:49:19 drbd9-02 kernel: drbd r0 drbd9-01: conn( Unconnected -&g=
t; Connecting )<br>Feb 18 12:49:30 drbd9-02 kernel: drbd r0 drbd9-03: Prepa=
ring remote state change 444800473 (primary_nodes=3D0, weak_nodes=3D0)<br>F=
eb 18 12:49:30 drbd9-02 kernel: drbd r0 drbd9-03: Committing remote state c=
hange 444800473<br>Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: sock_=
recvmsg returned -11<br>Feb 18 12:49:32 drbd9-02 kernel: drbd r0 drbd9-01: =
conn( Connecting -&gt; BrokenPipe )<br>Feb 18 12:49:32 drbd9-02 kernel: drb=
d r0 drbd9-01: Connection closed<br>Feb 18 12:49:32 drbd9-02 kernel: drbd r=
0 drbd9-01: conn( BrokenPipe -&gt; Unconnected )<br>Feb 18 12:49:33 drbd9-0=
2 kernel: drbd r0 drbd9-01: conn( Unconnected -&gt; Connecting )<br>Feb 18 =
12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: sock was shut down by peer<br>F=
eb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting -&gt; Br=
okenPipe )<br>Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: Connection=
 closed<br>Feb 18 12:49:41 drbd9-02 kernel: drbd r0 drbd9-01: conn( BrokenP=
ipe -&gt; Unconnected )<br>Feb 18 12:49:42 drbd9-02 kernel: drbd r0 drbd9-0=
1: conn( Unconnected -&gt; Connecting )<br>Feb 18 12:49:42 drbd9-02 kernel:=
 drbd r0 tcp:drbd9-01: initial packet S crossed<br>Feb 18 12:49:54 drbd9-02=
 kernel: drbd r0 tcp:drbd9-01: initial packet M crossed<br>Feb 18 12:49:55 =
drbd9-02 kernel: drbd r0 drbd9-01: conn( Connecting -&gt; Disconnecting )<b=
r>Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: sock_recvmsg returned =
-4<br>Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Connection closed<=
br>Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: conn( Disconnecting -=
&gt; StandAlone )<br>Feb 18 12:49:55 drbd9-02 kernel: drbd r0: State change=
 failed: Need a connection to start verify or resync<br>Feb 18 12:49:55 drb=
d9-02 kernel: drbd r0 drbd9-01: Failed: conn( StandAlone -&gt; Connecting )=
<br>Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Terminating receiver=
 thread<br>Feb 18 12:49:55 drbd9-02 kernel: drbd r0 drbd9-01: Terminating s=
ender thread<br>Feb 18 12:49:56 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Clos=
ing unexpected connection from 100.100.10.11<br>Feb 18 12:50:01 drbd9-02 sy=
stemd: Starting Session 171 of user root.<br>Feb 18 12:50:01 drbd9-02 syste=
md: Started Session 171 of user root.<br>Feb 18 12:50:04 drbd9-02 kernel: d=
rbd r0 tcp:drbd9-05: Closing unexpected connection from 100.100.10.11<br>Fe=
b 18 12:50:16 drbd9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected con=
nection from 100.100.10.11<br>Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Pre=
paring cluster-wide state change 2594601400 (1-&gt;2 496/16)<br>Feb 18 12:5=
0:25 drbd9-02 kernel: drbd r0: Retrying cluster-wide state change after 332=
ms<br>Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Preparing cluster-wide stat=
e change 1091225699 (1-&gt;2 496/16)<br>Feb 18 12:50:25 drbd9-02 kernel: dr=
bd r0: State change 1091225699: primary_nodes=3D0, weak_nodes=3D0<br>Feb 18=
 12:50:25 drbd9-02 kernel: drbd r0: Committing cluster-wide state change 10=
91225699 (10ms)<br>Feb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: conn(=
 Connected -&gt; Disconnecting ) peer( Secondary -&gt; Unknown )<br>Feb 18 =
12:50:25 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-03: pdsk( UpToDate -&gt; DU=
nknown ) repl( Established -&gt; Off )<br>Feb 18 12:50:25 drbd9-02 kernel: =
drbd r0 drbd9-03: ack_receiver terminated<br>Feb 18 12:50:25 drbd9-02 kerne=
l: drbd r0 drbd9-03: Terminating ack_recv thread<br>Feb 18 12:50:25 drbd9-0=
2 kernel: drbd r0 drbd9-03: Connection closed<br>Feb 18 12:50:25 drbd9-02 k=
ernel: drbd r0 drbd9-03: conn( Disconnecting -&gt; StandAlone )<br>Feb 18 1=
2:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Terminating receiver thread<br>F=
eb 18 12:50:25 drbd9-02 kernel: drbd r0 drbd9-03: Terminating sender thread=
<br>Feb 18 12:50:25 drbd9-02 kernel: drbd r0: Preparing cluster-wide state =
change 1955398811 (1-&gt;3 496/16)<br>Feb 18 12:50:25 drbd9-02 kernel: drbd=
 r0: Retrying cluster-wide state change after 193ms<br>Feb 18 12:50:25 drbd=
9-02 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from 100.1=
00.10.31<br>Feb 18 12:50:26 drbd9-02 kernel: drbd r0: Preparing cluster-wid=
e state change 583992461 (1-&gt;3 496/16)<br>Feb 18 12:50:26 drbd9-02 kerne=
l: drbd r0: State change 583992461: primary_nodes=3D0, weak_nodes=3D0<br>Fe=
b 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Cluster is now split<br>Fe=
b 18 12:50:26 drbd9-02 kernel: drbd r0: Committing cluster-wide state chang=
e 583992461 (43ms)<br>Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: co=
nn( Connected -&gt; Disconnecting ) peer( Secondary -&gt; Unknown )<br>Feb =
18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1 drbd9-04: repl( PausedSyncS -&=
gt; Off ) resync-susp( peer -&gt; no )<br>Feb 18 12:50:26 drbd9-02 kernel: =
drbd r0 drbd9-04: ack_receiver terminated<br>Feb 18 12:50:26 drbd9-02 kerne=
l: drbd r0 drbd9-04: Terminating ack_recv thread<br>Feb 18 12:50:26 drbd9-0=
2 kernel: drbd r0 drbd9-04: Connection closed<br>Feb 18 12:50:26 drbd9-02 k=
ernel: drbd r0 drbd9-04: conn( Disconnecting -&gt; StandAlone )<br>Feb 18 1=
2:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Terminating receiver thread<br>F=
eb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-04: Terminating sender thread=
<br>Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: conn( Connecting -&g=
t; Disconnecting )<br>Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: Co=
nnection closed<br>Feb 18 12:50:26 drbd9-02 kernel: drbd r0 drbd9-05: conn(=
 Disconnecting -&gt; StandAlone )<br>Feb 18 12:50:26 drbd9-02 kernel: drbd =
r0 drbd9-05: Terminating receiver thread<br>Feb 18 12:50:26 drbd9-02 kernel=
: drbd r0 drbd9-05: Terminating sender thread<br>Feb 18 12:50:26 drbd9-02 k=
ernel: drbd r0/0 drbd1: disk( UpToDate -&gt; Detaching )<br>Feb 18 12:50:26=
 drbd9-02 kernel: drbd r0/0 drbd1: disk( Detaching -&gt; Diskless )<br>Feb =
18 12:50:26 drbd9-02 kernel: drbd r0/0 drbd1: drbd_bm_resize called with ca=
pacity =3D=3D 0<br><b><font color=3D"#ff0000">Feb 18 12:50:26 drbd9-02 kern=
el: drbd r0: Terminating worker thread =C2=A0&lt;--------------------------=
 --------------------------------------------------------------------------=
-------- Last log before HANG!!!!!</font></b></div><div><font color=3D"#ff0=
000"><b><br></b></font>Feb 18 13:36:14 drbd9-02 rsyslogd: [origin software=
=3D&quot;rsyslogd&quot; swVersion=3D&quot;7.4.7&quot; x-pid=3D&quot;899&quo=
t; x-info=3D&quot;<a href=3D"http://www.rsyslog.com" target=3D"_blank">http=
://www.rsyslog.com</a>&quot;] start<br>Feb 18 13:36:11 drbd9-02 journal: Ru=
ntime journal is using 6.1M (max 48.9M, leaving 73.4M of free 483.6M, curre=
nt limit 48.9M).<br>Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup su=
bsys cpuset<br>Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup subsys =
cpu<br>Feb 18 13:36:11 drbd9-02 kernel: Initializing cgroup subsys cpuacct<=
br>Feb 18 13:36:11 drbd9-02 kernel: Linux version 3.10.0-229.7.2.el7.x86_64=
 (<a href=3D"mailto:builder@kbuilder.dev.centos.org" target=3D"_blank">buil=
der@kbuilder.dev.centos.org</a>) (gcc version 4.8.3 20140911 (Red Hat 4.8.3=
-9) (GCC) ) #1 SMP Tue Jun 23 22:06:11 UTC 2015<br>Feb 18 13:36:11 drbd9-02=
 kernel: Command line: BOOT_IMAGE=3D/vmlinuz-3.10.0-229.7.2.el7.x86_64 root=
=3D/dev/mapper/cento-------s-root ro <a href=3D"http://rd.lvm.lv" target=3D=
"_blank">rd.lvm.lv</a>=3Dcentos/root <a href=3D"http://rd.lvm.lv" target=3D=
"_blank">rd.lvm.lv</a>=3Dcentos/swap net.ifnames=3D0 rhgb quiet systemd.deb=
ug LANG=3Dko_KR.UTF-8<br>Feb 18 13:36:11 drbd9-02 kernel: Disabled fast str=
ing operations<br>Feb 18 13:36:11 drbd9-02 kernel: e820: BIOS-provided phys=
ical RAM map:<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem 0x0000000=
000000000-0x000000000009ebff] usable<br>Feb 18 13:36:11 drbd9-02 kernel: BI=
OS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved<br>Feb 18 13:=
36:11 drbd9-02 kernel: BIOS-e820: [mem 0x00000000000dc000-0x00000000000ffff=
f] reserved<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem 0x000000000=
0100000-0x000000003fedffff] usable<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS=
-e820: [mem 0x000000003fee0000-0x000000003fefefff] ACPI data<br>Feb 18 13:3=
6:11 drbd9-02 kernel: BIOS-e820: [mem 0x000000003feff000-0x000000003fefffff=
] ACPI NVS<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem 0x000000003f=
f00000-0x000000003fffffff] usable<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-=
e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved<br>Feb 18 13:36:=
11 drbd9-02 kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] =
reserved<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-e820: [mem 0x00000000fee0=
0000-0x00000000fee00fff] reserved<br>Feb 18 13:36:11 drbd9-02 kernel: BIOS-=
e820: [mem 0x00000000fffe0000-0x00000000ffffffff] reserved<br>Feb 18 13:36:=
11 drbd9-02 kernel: NX (Execute Disable) protection: active<br>Feb 18 13:36=
:11 drbd9-02 kernel: SMBIOS 2.4 present.<br>[root@drbd9-02 ~]# <br><br clea=
r=3D"all"><br><br></div><div><br></div><div><br></div><div>3) Node3</div><d=
iv><br></div><div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: A=
borting remote state change 4148874408</div><div>Feb 18 12:49:10 drbd9-03 k=
ernel: drbd r0 drbd9-01: Handshake successful: Agreed network protocol vers=
ion 111</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Featur=
e flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><d=
iv>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Starting ack_recv thr=
ead (from drbd_r_r0 [27984])</div><div>Feb 18 12:49:10 drbd9-03 kernel: drb=
d r0 drbd9-01: sock was shut down by peer</div><div>Feb 18 12:49:10 drbd9-0=
3 kernel: drbd r0 drbd9-01: conn( Connecting -&gt; BrokenPipe )</div><div>F=
eb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: ack_receiver terminated</=
div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Terminating ack=
_recv thread</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 tcp:drbd9-0=
5: Closing unexpected connection from 100.100.10.11</div><div>Feb 18 12:49:=
10 drbd9-03 kernel: drbd r0 drbd9-01: Connection closed</div><div>Feb 18 12=
:49:10 drbd9-03 kernel: drbd r0 drbd9-01: conn( BrokenPipe -&gt; Unconnecte=
d )</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-01: Restarting=
 receiver thread</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-0=
1: conn( Unconnected -&gt; Connecting )</div><div>Feb 18 12:49:10 drbd9-03 =
kernel: drbd r0 drbd9-02: Preparing remote state change 1700403818 (primary=
_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd=
 r0 drbd9-02: Aborting remote state change 1700403818</div><div>Feb 18 12:4=
9:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 27107=
912 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:10 drbd9-03 =
kernel: drbd r0 drbd9-02: Aborting remote state change 27107912</div><div>F=
eb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state ch=
ange 3704636436 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 37046364=
36</div><div>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Preparing r=
emote state change 1124892736 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:49:10 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state c=
hange 1124892736</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-0=
2: Preparing remote state change 3041974229 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 3041974229</div><div>Feb 18 12:49:11 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 2044263190 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 2044263190</div><div>Feb 18 12:49:11 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 4123278827 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 4123278827</div><div>Feb=
 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 58309047 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 d=
rbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 58309047</di=
v><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote =
state change 1424319647 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 1=
8 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change =
1424319647</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Pre=
paring remote state change 2146390635 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote=
 state change 2146390635</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0=
 drbd9-01: Handshake successful: Agreed network protocol version 111</div><=
div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Feature flags enable=
d on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Feb 18 12:4=
9:11 drbd9-03 kernel: drbd r0 drbd9-01: Starting ack_recv thread (from drbd=
_r_r0 [27984])</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 3224851067 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 3224851067</div><div>Feb 18 12:49:11 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 3275921964 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-0=
2: Aborting remote state change 3275921964</div><div>Feb 18 12:49:11 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 2785425520 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 2785425520</div><div>Feb 18 1=
2:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 30=
92566612 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd=
9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 3092566612</div=
><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote s=
tate change 3546571907 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 3=
546571907</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Prep=
aring remote state change 2684586320 (primary_nodes=3D0, weak_nodes=3D0)</d=
iv><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote =
state change 2684586320</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 =
drbd9-01: Preparing remote state change 2826388576 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Ab=
orting remote state change 2826388576</div><div>Feb 18 12:49:11 drbd9-03 ke=
rnel: drbd r0 drbd9-02: Preparing remote state change 3152419371 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r=
0 drbd9-02: Aborting remote state change 3152419371</div><div>Feb 18 12:49:=
11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 7174425=
44 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 k=
ernel: drbd r0 drbd9-01: Aborting remote state change 717442544</div><div>F=
eb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state ch=
ange 1538773720 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 15387737=
20</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing r=
emote state change 3935479086 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state c=
hange 3935479086</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-0=
2: Preparing remote state change 1574758056 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 1574758056</div><div>Feb 18 12:49:11 drbd9-03 kernel: =
drbd r0 drbd9-01: Preparing remote state change 1212157223 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 1212157223</div><div>Feb 18 12:49:11 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 1960346098 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 1960346098</div><div>Feb=
 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 3227317969 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 3227317969=
</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 4262478632 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 4262478632</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 3004867455 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 3004867455</div><div>Feb 18 12:49:11 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 1876684995 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-0=
2: Aborting remote state change 1876684995</div><div>Feb 18 12:49:11 drbd9-=
03 kernel: drbd r0 drbd9-01: Preparing remote state change 390087009 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-03 kernel: dr=
bd r0 drbd9-01: Aborting remote state change 390087009</div><div>Feb 18 12:=
49:11 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 2865=
628136 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:11 drbd9-=
03 kernel: drbd r0 drbd9-01: Aborting remote state change 2865628136</div><=
div>Feb 18 12:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote sta=
te change 680960366 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12=
:49:11 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 6809=
60366</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparin=
g remote state change 1752965497 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote stat=
e change 1752965497</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd=
9-02: Preparing remote state change 3111596947 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborti=
ng remote state change 3111596947</div><div>Feb 18 12:49:12 drbd9-03 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2123586573 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 2123586573</div><div>Feb 18 12:49:12 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 2432880222 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 2432880222</div><div>Feb=
 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 3466823240 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 3466823240=
</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 3409262061 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 3409262061</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 3528423906 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 3528423906</div><div>Feb 18 12:49:12 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 919401773 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02=
: Aborting remote state change 919401773</div><div>Feb 18 12:49:12 drbd9-03=
 kernel: drbd r0 drbd9-01: Preparing remote state change 2355827361 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drb=
d r0 drbd9-01: Aborting remote state change 2355827361</div><div>Feb 18 12:=
49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 2742=
17007 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-0=
3 kernel: drbd r0 drbd9-02: Aborting remote state change 274217007</div><di=
v>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 1735994045 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 17359=
94045</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 184247837 (primary_nodes=3D0, weak_nodes=3D0)</div><d=
iv>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state=
 change 184247837</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-=
01: Preparing remote state change 3397010196 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 3397010196</div><div>Feb 18 12:49:12 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 2647943263 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 2647943263</div><div>Feb 18 12:49:12 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 2314118776 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 2314118776</div><div>Feb=
 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2304216418 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2304216418=
</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 2840076212 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state cha=
nge 2840076212</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 2089786251 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 2089786251</div><div>Feb 18 12:49:12 drbd9-03 kernel: drb=
d r0 drbd9-01: Preparing remote state change 1243463540 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-0=
1: Aborting remote state change 1243463540</div><div>Feb 18 12:49:12 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 3934530318 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 3934530318</div><div>Feb 18 1=
2:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 13=
38535718 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd=
9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1338535718</div=
><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote s=
tate change 3825464252 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 3=
825464252</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Prep=
aring remote state change 458138564 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote s=
tate change 458138564</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 3263001224 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 3263001224</div><div>Feb 18 12:49:12 drbd9-03 kern=
el: drbd r0 drbd9-01: Preparing remote state change 1737345562 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 =
drbd9-01: Aborting remote state change 1737345562</div><div>Feb 18 12:49:12=
 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 895380100=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 895380100</div><div>Feb=
 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 1353873222 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1353873222=
</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 1127265602 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 1127265602</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 2720890274 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 2720890274</div><div>Feb 18 12:49:12 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 4153736246 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-0=
2: Aborting remote state change 4153736246</div><div>Feb 18 12:49:12 drbd9-=
03 kernel: drbd r0 drbd9-01: Preparing remote state change 3640994784 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: d=
rbd r0 drbd9-01: Aborting remote state change 3640994784</div><div>Feb 18 1=
2:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 29=
01412307 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd=
9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2901412307</div=
><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote s=
tate change 1322472363 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1=
322472363</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Prep=
aring remote state change 1479893692 (primary_nodes=3D0, weak_nodes=3D0)</d=
iv><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote =
state change 1479893692</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 =
drbd9-01: Preparing remote state change 3205669847 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Ab=
orting remote state change 3205669847</div><div>Feb 18 12:49:12 drbd9-03 ke=
rnel: drbd r0 drbd9-02: Preparing remote state change 1501697909 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r=
0 drbd9-02: Aborting remote state change 1501697909</div><div>Feb 18 12:49:=
12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 2019004=
256 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:12 drbd9-03 =
kernel: drbd r0 drbd9-01: Aborting remote state change 2019004256</div><div=
>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state =
change 3350229455 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 335022=
9455</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Preparing=
 remote state change 1039571066 (primary_nodes=3D0, weak_nodes=3D0)</div><d=
iv>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state=
 change 1039571066</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9=
-02: Preparing remote state change 220257880 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:12 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 220257880</div><div>Feb 18 12:49:13 drbd9-03 kernel: d=
rbd r0 drbd9-01: Preparing remote state change 4026895487 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9=
-01: Aborting remote state change 4026895487</div><div>Feb 18 12:49:13 drbd=
9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 1721931724 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel:=
 drbd r0 drbd9-02: Aborting remote state change 1721931724</div><div>Feb 18=
 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change =
1033546961 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 dr=
bd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1033546961</d=
iv><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote=
 state change 3092763300 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb =
18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change=
 3092763300</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Pr=
eparing remote state change 770538692 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 770538692</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 =
drbd9-02: Preparing remote state change 1354057588 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Ab=
orting remote state change 1354057588</div><div>Feb 18 12:49:13 drbd9-03 ke=
rnel: drbd r0 drbd9-01: Preparing remote state change 1483793276 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r=
0 drbd9-01: Aborting remote state change 1483793276</div><div>Feb 18 12:49:=
13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3482039=
458 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 =
kernel: drbd r0 drbd9-02: Aborting remote state change 3482039458</div><div=
>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state =
change 2598992257 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 259899=
2257</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing=
 remote state change 817000556 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state =
change 817000556</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-0=
1: Preparing remote state change 77974480 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 77974480</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd =
r0 drbd9-02: Preparing remote state change 3966174102 (primary_nodes=3D0, w=
eak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02:=
 Aborting remote state change 3966174102</div><div>Feb 18 12:49:13 drbd9-03=
 kernel: drbd r0 drbd9-01: Preparing remote state change 747047415 (primary=
_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd=
 r0 drbd9-01: Aborting remote state change 747047415</div><div>Feb 18 12:49=
:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 283015=
0720 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03=
 kernel: drbd r0 drbd9-02: Aborting remote state change 2830150720</div><di=
v>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 2666597117 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 26665=
97117</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 3030671864 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote stat=
e change 3030671864</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd=
9-01: Preparing remote state change 2343253662 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborti=
ng remote state change 2343253662</div><div>Feb 18 12:49:13 drbd9-03 kernel=
: drbd r0 drbd9-02: Preparing remote state change 3117955713 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 3117955713</div><div>Feb 18 12:49:13 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 3036692217 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 3036692217</div><div>Feb=
 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2007453059 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2007453059=
</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 102602932 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chan=
ge 102602932</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: P=
reparing remote state change 374656520 (primary_nodes=3D0, weak_nodes=3D0)<=
/div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remot=
e state change 374656520</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0=
 drbd9-01: Preparing remote state change 2835460938 (primary_nodes=3D0, wea=
k_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: A=
borting remote state change 2835460938</div><div>Feb 18 12:49:13 drbd9-03 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 842771771 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r=
0 drbd9-02: Aborting remote state change 842771771</div><div>Feb 18 12:49:1=
3 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 41907488=
97 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 k=
ernel: drbd r0 drbd9-01: Aborting remote state change 4190748897</div><div>=
Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state c=
hange 2015816228 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49=
:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2015816=
228</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing =
remote state change 1462726939 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state =
change 1462726939</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-=
02: Preparing remote state change 2742749823 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 2742749823</div><div>Feb 18 12:49:13 drbd9-03 kernel: =
drbd r0 drbd9-01: Preparing remote state change 1941161229 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 1941161229</div><div>Feb 18 12:49:13 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 2962336775 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 2962336775</div><div>Feb=
 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 2584607114 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2584607114=
</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 1687607447 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 1687607447</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 2414299465 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 2414299465</div><div>Feb 18 12:49:13 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 918122871 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02=
: Aborting remote state change 918122871</div><div>Feb 18 12:49:13 drbd9-03=
 kernel: drbd r0 drbd9-01: Preparing remote state change 2674395060 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drb=
d r0 drbd9-01: Aborting remote state change 2674395060</div><div>Feb 18 12:=
49:13 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 2939=
585177 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:13 drbd9-=
03 kernel: drbd r0 drbd9-02: Aborting remote state change 2939585177</div><=
div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote sta=
te change 1994730321 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 199=
4730321</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Prepar=
ing remote state change 1533339556 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote st=
ate change 1533339556</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 dr=
bd9-01: Preparing remote state change 3763733638 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:13 drbd9-03 kernel: drbd r0 drbd9-01: Abor=
ting remote state change 3763733638</div><div>Feb 18 12:49:14 drbd9-03 kern=
el: drbd r0 drbd9-02: Preparing remote state change 3413396013 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 =
drbd9-02: Aborting remote state change 3413396013</div><div>Feb 18 12:49:14=
 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 965408431=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 ker=
nel: drbd r0 drbd9-01: Aborting remote state change 965408431</div><div>Feb=
 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2712598837 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2712598837=
</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 2723235979 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state cha=
nge 2723235979</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 1267855463 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 1267855463</div><div>Feb 18 12:49:14 drbd9-03 kernel: drb=
d r0 drbd9-01: Preparing remote state change 2472306332 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-0=
1: Aborting remote state change 2472306332</div><div>Feb 18 12:49:14 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 3364150313 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 3364150313</div><div>Feb 18 1=
2:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 26=
82382103 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd=
9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2682382103</div=
><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote s=
tate change 772789142 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 77=
2789142</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Prepar=
ing remote state change 2291238476 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote st=
ate change 2291238476</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 1516864995 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 1516864995</div><div>Feb 18 12:49:14 drbd9-03 kern=
el: drbd r0 drbd9-01: Preparing remote state change 8357236 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 8357236</div><div>Feb 18 12:49:14 drbd=
9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3503255741 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel:=
 drbd r0 drbd9-02: Aborting remote state change 3503255741</div><div>Feb 18=
 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change =
2689137965 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 dr=
bd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2689137965</d=
iv><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote=
 state change 3319268457 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb =
18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change=
 3319268457</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Pr=
eparing remote state change 278690020 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 278690020</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 =
drbd9-02: Preparing remote state change 3600586096 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Ab=
orting remote state change 3600586096</div><div>Feb 18 12:49:14 drbd9-03 ke=
rnel: drbd r0 drbd9-01: Preparing remote state change 3511376225 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r=
0 drbd9-01: Aborting remote state change 3511376225</div><div>Feb 18 12:49:=
14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 6368524=
0 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 ke=
rnel: drbd r0 drbd9-02: Aborting remote state change 63685240</div><div>Feb=
 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 4238257769 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 4238257769=
</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 176339051 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state chan=
ge 176339051</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: P=
reparing remote state change 3285874930 (primary_nodes=3D0, weak_nodes=3D0)=
</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remo=
te state change 3285874930</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd =
r0 drbd9-02: Preparing remote state change 334220901 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: =
Aborting remote state change 334220901</div><div>Feb 18 12:49:14 drbd9-03 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 314034843 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r=
0 drbd9-01: Aborting remote state change 314034843</div><div>Feb 18 12:49:1=
4 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 39274234=
60 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 k=
ernel: drbd r0 drbd9-02: Aborting remote state change 3927423460</div><div>=
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state c=
hange 445007464 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 44500746=
4</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing re=
mote state change 1563966627 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state ch=
ange 1563966627</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01=
: Preparing remote state change 2609728281 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 2609728281</div><div>Feb 18 12:49:14 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 3813816936 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 3813816936</div><div>Feb 18 12:49:14 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 3732916591 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 3732916591</div><div>Feb=
 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 3912334398 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 3912334398=
</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 2966831417 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state cha=
nge 2966831417</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 4103984360 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 4103984360</div><div>Feb 18 12:49:14 drbd9-03 kernel: drb=
d r0 drbd9-01: Preparing remote state change 1765942052 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-0=
1: Aborting remote state change 1765942052</div><div>Feb 18 12:49:14 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 2916219381 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 2916219381</div><div>Feb 18 1=
2:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 28=
75115170 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:14 drbd=
9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2875115170</div=
><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote s=
tate change 3970442788 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 3=
970442788</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Prep=
aring remote state change 3311773748 (primary_nodes=3D0, weak_nodes=3D0)</d=
iv><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote =
state change 3311773748</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 =
drbd9-02: Preparing remote state change 828078891 (primary_nodes=3D0, weak_=
nodes=3D0)</div><div>Feb 18 12:49:14 drbd9-03 kernel: drbd r0 drbd9-02: Abo=
rting remote state change 828078891</div><div>Feb 18 12:49:15 drbd9-03 kern=
el: drbd r0 drbd9-01: Preparing remote state change 916340848 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 d=
rbd9-01: Aborting remote state change 916340848</div><div>Feb 18 12:49:15 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3809938960 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 3809938960</div><div>Feb=
 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 466030330 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 =
drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 466030330</=
div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remot=
e state change 3871624072 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state chang=
e 3871624072</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: P=
reparing remote state change 562578872 (primary_nodes=3D0, weak_nodes=3D0)<=
/div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remot=
e state change 562578872</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0=
 drbd9-02: Preparing remote state change 3059617914 (primary_nodes=3D0, wea=
k_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: A=
borting remote state change 3059617914</div><div>Feb 18 12:49:15 drbd9-03 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 1765006974 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd =
r0 drbd9-01: Aborting remote state change 1765006974</div><div>Feb 18 12:49=
:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 428202=
6993 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03=
 kernel: drbd r0 drbd9-02: Aborting remote state change 4282026993</div><di=
v>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 541907284 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 541907=
284</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing =
remote state change 3720310948 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state =
change 3720310948</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-=
01: Preparing remote state change 2525581650 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 2525581650</div><div>Feb 18 12:49:15 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 233526968 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9=
-02: Aborting remote state change 233526968</div><div>Feb 18 12:49:15 drbd9=
-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1832763483 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: =
drbd r0 drbd9-01: Aborting remote state change 1832763483</div><div>Feb 18 =
12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 9=
19412360 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd=
9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 919412360</div>=
<div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote st=
ate change 3167526743 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 31=
67526743</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Prepa=
ring remote state change 1726750051 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote s=
tate change 1726750051</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 d=
rbd9-01: Preparing remote state change 135300592 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Abor=
ting remote state change 135300592</div><div>Feb 18 12:49:15 drbd9-03 kerne=
l: drbd r0 drbd9-02: Preparing remote state change 1945757685 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 d=
rbd9-02: Aborting remote state change 1945757685</div><div>Feb 18 12:49:15 =
drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 120559031 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 120559031</div><div>Feb =
18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chang=
e 1931376741 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 1931376741<=
/div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remo=
te state change 2685589933 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chan=
ge 2685589933</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: =
Preparing remote state change 2895871033 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 2895871033</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd=
 r0 drbd9-02: Preparing remote state change 1657331205 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02=
: Committing remote state change 1657331205</div><div>Feb 18 12:49:15 drbd9=
-03 kernel: drbd r0 drbd9-01: Preparing remote state change 352665508 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: d=
rbd r0 drbd9-01: Aborting remote state change 352665508</div><div>Feb 18 12=
:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 103=
7382588 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9=
-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1037382588</div>=
<div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote st=
ate change 399118927 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 399=
118927</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Prepari=
ng remote state change 1547038261 (primary_nodes=3D0, weak_nodes=3D0)</div>=
<div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote sta=
te change 1547038261</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drb=
d9-02: Preparing remote state change 90711453 (primary_nodes=3D0, weak_node=
s=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Abortin=
g remote state change 90711453</div><div>Feb 18 12:49:15 drbd9-03 kernel: d=
rbd r0 drbd9-01: Preparing remote state change 2906061427 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9=
-01: Aborting remote state change 2906061427</div><div>Feb 18 12:49:15 drbd=
9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 110758586 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: =
drbd r0 drbd9-02: Aborting remote state change 110758586</div><div>Feb 18 1=
2:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 19=
982401 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-=
03 kernel: drbd r0 drbd9-01: Aborting remote state change 19982401</div><di=
v>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state=
 change 1229720926 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 12297=
20926</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Preparin=
g remote state change 2599231352 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote stat=
e change 2599231352</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd=
9-02: Preparing remote state change 1975668868 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 drbd9-02: Aborti=
ng remote state change 1975668868</div><div>Feb 18 12:49:15 drbd9-03 kernel=
: drbd r0 drbd9-01: Preparing remote state change 2505675278 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 2505675278</div><div>Feb 18 12:49:15 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 4000831140 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 4000831140</div><div>Feb=
 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 2750887982 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2750887982=
</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 2468909229 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 2468909229</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 2662778291 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 2662778291</div><div>Feb 18 12:49:16 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 4035033791 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-0=
2: Aborting remote state change 4035033791</div><div>Feb 18 12:49:16 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 1708023363 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: d=
rbd r0 drbd9-01: Rejecting concurrent remote state change 1066177111 becaus=
e of state change 1708023363</div><div>Feb 18 12:49:16 drbd9-03 kernel: drb=
d r0 drbd9-02: Aborting remote state change 1708023363</div><div>Feb 18 12:=
49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 5755=
87423 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-0=
3 kernel: drbd r0 drbd9-02: Aborting remote state change 575587423</div><di=
v>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 3005066576 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 30050=
66576</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 2982970747 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote stat=
e change 2982970747</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd=
9-01: Preparing remote state change 1635237549 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborti=
ng remote state change 1635237549</div><div>Feb 18 12:49:16 drbd9-03 kernel=
: drbd r0 drbd9-02: Preparing remote state change 3629941899 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 dr=
bd9-01: Rejecting concurrent remote state change 3986545484 because of stat=
e change 3629941899</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd=
9-02: Aborting remote state change 3629941899</div><div>Feb 18 12:49:16 drb=
d9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 3563238485 (p=
rimary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel=
: drbd r0 drbd9-01: Aborting remote state change 3563238485</div><div>Feb 1=
8 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change=
 3238325029 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 d=
rbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 3238325029</=
div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remot=
e state change 3638753626 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chang=
e 3638753626</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: P=
reparing remote state change 3599232118 (primary_nodes=3D0, weak_nodes=3D0)=
</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remo=
te state change 3599232118</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd =
r0 drbd9-01: Preparing remote state change 113146377 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: =
Aborting remote state change 113146377</div><div>Feb 18 12:49:16 drbd9-03 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 3173991607 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd =
r0 drbd9-01: Rejecting concurrent remote state change 1425635733 because of=
 state change 3173991607</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0=
 drbd9-02: Aborting remote state change 3173991607</div><div>Feb 18 12:49:1=
6 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 37663249=
38 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 k=
ernel: drbd r0 drbd9-01: Rejecting concurrent remote state change 367833295=
1 because of state change 3766324938</div><div>Feb 18 12:49:16 drbd9-03 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 3766324938</div><div>Fe=
b 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state cha=
nge 1350394170 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
6 drbd9-03 kernel: drbd r0 drbd9-01: Rejecting concurrent remote state chan=
ge 3453543298 because of state change 1350394170</div><div>Feb 18 12:49:16 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 1350394170<=
/div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remo=
te state change 2874348269 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chan=
ge 2874348269</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: =
Preparing remote state change 1961866418 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 1961866418</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd=
 r0 drbd9-02: Preparing remote state change 1422080841 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01=
: Rejecting concurrent remote state change 1106447724 because of state chan=
ge 1422080841</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: =
Aborting remote state change 1422080841</div><div>Feb 18 12:49:16 drbd9-03 =
kernel: drbd r0 drbd9-02: Preparing remote state change 1935970639 (primary=
_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd=
 r0 drbd9-01: Rejecting concurrent remote state change 1369156260 because o=
f state change 1935970639</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r=
0 drbd9-02: Aborting remote state change 1935970639</div><div>Feb 18 12:49:=
16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 3698905=
2 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 ke=
rnel: drbd r0 drbd9-01: Aborting remote state change 36989052</div><div>Feb=
 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 582050229 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 582050229</=
div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remot=
e state change 4192500224 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chang=
e 4192500224</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: P=
reparing remote state change 2039128137 (primary_nodes=3D0, weak_nodes=3D0)=
</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remo=
te state change 2039128137</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd =
r0 drbd9-01: Preparing remote state change 821093755 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-01: =
Aborting remote state change 821093755</div><div>Feb 18 12:49:16 drbd9-03 k=
ernel: drbd r0 drbd9-02: Preparing remote state change 3518597027 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 kernel: drbd =
r0 drbd9-02: Aborting remote state change 3518597027</div><div>Feb 18 12:49=
:16 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 452858=
682 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-03 =
kernel: drbd r0 drbd9-01: Aborting remote state change 452858682</div><div>=
Feb 18 12:49:16 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state c=
hange 2321677588 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49=
:16 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2321677=
588</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing =
remote state change 3637280121 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state =
change 3637280121</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-=
02: Preparing remote state change 261689227 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 261689227</div><div>Feb 18 12:49:17 drbd9-03 kernel: d=
rbd r0 drbd9-01: Preparing remote state change 1843385190 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9=
-01: Aborting remote state change 1843385190</div><div>Feb 18 12:49:17 drbd=
9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3197178194 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel:=
 drbd r0 drbd9-02: Aborting remote state change 3197178194</div><div>Feb 18=
 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change =
767463344 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drb=
d9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 767463344</div=
><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote s=
tate change 3875723021 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 3=
875723021</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Prep=
aring remote state change 3351946337 (primary_nodes=3D0, weak_nodes=3D0)</d=
iv><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote =
state change 3351946337</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 =
drbd9-02: Preparing remote state change 3454915512 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Ab=
orting remote state change 3454915512</div><div>Feb 18 12:49:17 drbd9-03 ke=
rnel: drbd r0 drbd9-01: Preparing remote state change 2640937765 (primary_n=
odes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r=
0 drbd9-01: Aborting remote state change 2640937765</div><div>Feb 18 12:49:=
17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3044822=
599 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 =
kernel: drbd r0 drbd9-02: Aborting remote state change 3044822599</div><div=
>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state =
change 3354987837 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 335498=
7837</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing=
 remote state change 3556374775 (primary_nodes=3D0, weak_nodes=3D0)</div><d=
iv>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state=
 change 3556374775</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9=
-01: Preparing remote state change 2026795642 (primary_nodes=3D0, weak_node=
s=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Abortin=
g remote state change 2026795642</div><div>Feb 18 12:49:17 drbd9-03 kernel:=
 drbd r0 drbd9-02: Preparing remote state change 1409529751 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 1409529751</div><div>Feb 18 12:49:17 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 3085364587 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 3085364587</div><div>Feb=
 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 1803219856 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 1803219856=
</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 2423822761 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state cha=
nge 2423822761</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 2070740492 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 2070740492</div><div>Feb 18 12:49:17 drbd9-03 kernel: drb=
d r0 drbd9-01: Preparing remote state change 424571609 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01=
: Aborting remote state change 424571609</div><div>Feb 18 12:49:17 drbd9-03=
 kernel: drbd r0 drbd9-02: Preparing remote state change 1861094959 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drb=
d r0 drbd9-02: Aborting remote state change 1861094959</div><div>Feb 18 12:=
49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1439=
155988 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-=
03 kernel: drbd r0 drbd9-01: Aborting remote state change 1439155988</div><=
div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote sta=
te change 1912776257 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 191=
2776257</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Prepar=
ing remote state change 3342040311 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote st=
ate change 3342040311</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 3583634975 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 3583634975</div><div>Feb 18 12:49:17 drbd9-03 kern=
el: drbd r0 drbd9-01: Preparing remote state change 3560986460 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 =
drbd9-01: Aborting remote state change 3560986460</div><div>Feb 18 12:49:17=
 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 105959638=
8 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 ke=
rnel: drbd r0 drbd9-02: Aborting remote state change 1059596388</div><div>F=
eb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state ch=
ange 2039774846 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 20397748=
46</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing r=
emote state change 2984515839 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state c=
hange 2984515839</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-0=
1: Preparing remote state change 2729731529 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 2729731529</div><div>Feb 18 12:49:17 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 3776435962 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 3776435962</div><div>Feb 18 12:49:17 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1499748024 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 1499748024</div><div>Feb=
 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2633932659 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17=
 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2633932659=
</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing rem=
ote state change 3420883318 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state cha=
nge 3420883318</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 3805539839 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 3805539839</div><div>Feb 18 12:49:17 drbd9-03 kernel: drb=
d r0 drbd9-01: Preparing remote state change 2892821134 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-0=
1: Aborting remote state change 2892821134</div><div>Feb 18 12:49:17 drbd9-=
03 kernel: drbd r0 drbd9-02: Preparing remote state change 3642844571 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-03 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 3642844571</div><div>Feb 18 1=
2:49:17 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 11=
0768160 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9=
-03 kernel: drbd r0 drbd9-01: Aborting remote state change 110768160</div><=
div>Feb 18 12:49:17 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote sta=
te change 17859418 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:17 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 17859=
418</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing =
remote state change 1919413000 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state =
change 1919413000</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-=
02: Preparing remote state change 1145386916 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 1145386916</div><div>Feb 18 12:49:18 drbd9-03 kernel: =
drbd r0 drbd9-01: Preparing remote state change 2321101024 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 dr=
bd9-01: Aborting remote state change 2321101024</div><div>Feb 18 12:49:18 d=
rbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 3288824952 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kern=
el: drbd r0 drbd9-02: Aborting remote state change 3288824952</div><div>Feb=
 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 2274965928 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18=
 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 2274965928=
</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 3641522607 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 3641522607</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01:=
 Preparing remote state change 3926057794 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting re=
mote state change 3926057794</div><div>Feb 18 12:49:18 drbd9-03 kernel: drb=
d r0 drbd9-02: Preparing remote state change 128435041 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02=
: Aborting remote state change 128435041</div><div>Feb 18 12:49:18 drbd9-03=
 kernel: drbd r0 drbd9-01: Preparing remote state change 620951758 (primary=
_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd=
 r0 drbd9-01: Aborting remote state change 620951758</div><div>Feb 18 12:49=
:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 106727=
4131 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03=
 kernel: drbd r0 drbd9-02: Aborting remote state change 1067274131</div><di=
v>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 3401606816 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 34016=
06816</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 2464745589 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote stat=
e change 2464745589</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd=
9-01: Preparing remote state change 3575638272 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborti=
ng remote state change 3575638272</div><div>Feb 18 12:49:18 drbd9-03 kernel=
: drbd r0 drbd9-02: Preparing remote state change 289378464 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 289378464</div><div>Feb 18 12:49:18 dr=
bd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1793285500 (=
primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kerne=
l: drbd r0 drbd9-01: Aborting remote state change 1793285500</div><div>Feb =
18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chang=
e 2159434546 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 2159434546<=
/div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remo=
te state change 3776803522 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chan=
ge 3776803522</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: =
Preparing remote state change 2020636307 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 2020636307</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd=
 r0 drbd9-01: Preparing remote state change 2574235971 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01=
: Aborting remote state change 2574235971</div><div>Feb 18 12:49:18 drbd9-0=
3 kernel: drbd r0 drbd9-02: Preparing remote state change 1115473996 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: dr=
bd r0 drbd9-02: Aborting remote state change 1115473996</div><div>Feb 18 12=
:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 168=
1934234 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9=
-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1681934234</div>=
<div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote st=
ate change 2926904129 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 29=
26904129</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Prepa=
ring remote state change 1651456969 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote s=
tate change 1651456969</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 d=
rbd9-02: Preparing remote state change 1578249747 (primary_nodes=3D0, weak_=
nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Abo=
rting remote state change 1578249747</div><div>Feb 18 12:49:18 drbd9-03 ker=
nel: drbd r0 drbd9-01: Preparing remote state change 430284320 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 =
drbd9-01: Aborting remote state change 430284320</div><div>Feb 18 12:49:18 =
drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 4168451443=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 4168451443</div><div>Fe=
b 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state cha=
nge 3304566520 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
8 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 330456652=
0</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing re=
mote state change 2489323610 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state ch=
ange 2489323610</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01=
: Preparing remote state change 2784036568 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting=
 remote state change 2784036568</div><div>Feb 18 12:49:18 drbd9-03 kernel: =
drbd r0 drbd9-02: Preparing remote state change 2444898555 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 2444898555</div><div>Feb 18 12:49:18 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 2821131655 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 2821131655</div><div>Feb=
 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 649862413 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 649862413</=
div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remot=
e state change 1360241560 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state chang=
e 1360241560</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: P=
reparing remote state change 3610428486 (primary_nodes=3D0, weak_nodes=3D0)=
</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remo=
te state change 3610428486</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd =
r0 drbd9-01: Preparing remote state change 2654692450 (primary_nodes=3D0, w=
eak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01:=
 Aborting remote state change 2654692450</div><div>Feb 18 12:49:18 drbd9-03=
 kernel: drbd r0 drbd9-02: Preparing remote state change 237694475 (primary=
_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd=
 r0 drbd9-02: Aborting remote state change 237694475</div><div>Feb 18 12:49=
:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 256104=
6587 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-03=
 kernel: drbd r0 drbd9-01: Aborting remote state change 2561046587</div><di=
v>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state=
 change 2123728468 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:18 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 21237=
28468</div><div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Preparin=
g remote state change 1716193777 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:18 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote stat=
e change 1716193777</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd=
9-02: Preparing remote state change 954801834 (primary_nodes=3D0, weak_node=
s=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Abortin=
g remote state change 954801834</div><div>Feb 18 12:49:19 drbd9-03 kernel: =
drbd r0 drbd9-01: Preparing remote state change 997680699 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9=
-01: Aborting remote state change 997680699</div><div>Feb 18 12:49:19 drbd9=
-03 kernel: drbd r0 drbd9-02: Preparing remote state change 1595210697 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: =
drbd r0 drbd9-02: Aborting remote state change 1595210697</div><div>Feb 18 =
12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1=
795247459 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drb=
d9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 1795247459</di=
v><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote =
state change 1312694431 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 1=
8 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change =
1312694431</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Pre=
paring remote state change 1531206635 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote=
 state change 1531206635</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0=
 drbd9-02: Preparing remote state change 1379557998 (primary_nodes=3D0, wea=
k_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: A=
borting remote state change 1379557998</div><div>Feb 18 12:49:19 drbd9-03 k=
ernel: drbd r0 drbd9-01: Preparing remote state change 3792084596 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd =
r0 drbd9-01: Aborting remote state change 3792084596</div><div>Feb 18 12:49=
:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state change 136806=
0281 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03=
 kernel: drbd r0 drbd9-02: Aborting remote state change 1368060281</div><di=
v>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state=
 change 3569716009 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change 35697=
16009</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparin=
g remote state change 1393085582 (primary_nodes=3D0, weak_nodes=3D0)</div><=
div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote stat=
e change 1393085582</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd=
9-01: Preparing remote state change 4267014762 (primary_nodes=3D0, weak_nod=
es=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborti=
ng remote state change 4267014762</div><div>Feb 18 12:49:19 drbd9-03 kernel=
: drbd r0 drbd9-02: Preparing remote state change 1428881181 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 1428881181</div><div>Feb 18 12:49:19 d=
rbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 1718804050 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-03 kern=
el: drbd r0 drbd9-01: Aborting remote state change 1718804050</div><div>Feb=
 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 610769045 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 =
drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote state change 610769045</=
div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remot=
e state change 795605995 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb =
18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Aborting remote state change=
 795605995</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Pre=
paring remote state change 2783224475 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote=
 state change 2783224475</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0=
 drbd9-01: sock was shut down by peer</div><div>Feb 18 12:49:19 drbd9-03 ke=
rnel: drbd r0 drbd9-01: conn( Connecting -&gt; BrokenPipe )</div><div>Feb 1=
8 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: ack_receiver terminated</div>=
<div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Terminating ack_rec=
v thread</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: Conne=
ction closed</div><div>Feb 18 12:49:19 drbd9-03 kernel: drbd r0 drbd9-01: c=
onn( BrokenPipe -&gt; Unconnected )</div><div>Feb 18 12:49:19 drbd9-03 kern=
el: drbd r0 drbd9-01: Restarting receiver thread</div><div>Feb 18 12:49:19 =
drbd9-03 kernel: drbd r0 drbd9-01: conn( Unconnected -&gt; Connecting )</di=
v><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Handshake success=
ful: Agreed network protocol version 111</div><div>Feb 18 12:49:30 drbd9-03=
 kernel: drbd r0 drbd9-01: Feature flags enabled on protocol level: 0x7 TRI=
M THIN_RESYNC WRITE_SAME.</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r=
0 drbd9-01: Starting ack_recv thread (from drbd_r_r0 [27984])</div><div>Feb=
 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state chan=
ge 444800473 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:30 =
drbd9-03 kernel: drbd r0 drbd9-01: Committing remote state change 444800473=
</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0 drbd9-01: conn( Connect=
ing -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Feb 18 12:4=
9:30 drbd9-03 kernel: drbd r0/0 drbd1: peer does not support WRITE_SAME</di=
v><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: drbd_sync=
_handshake:</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd=
9-01: self B6CAADFB7D215BC6:0000000000000000:B6CAADFB7D215BC6:0000000000000=
000 bits:0 flags:0</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drb=
d1 drbd9-01: peer 0000000000000004:FFFFFFFFFFFFFFFF:0000000000000000:000000=
0000000000 bits:0 flags:24</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd =
r0/0 drbd1 drbd9-01: uuid_compare()=3D3 by rule 30</div><div>Feb 18 12:49:3=
0 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: Writing the whole bitmap, full=
 sync required after drbd_sync_handshake.</div><div>Feb 18 12:49:30 drbd9-0=
3 kernel: drbd r0/0 drbd1 drbd9-01: pdsk( DUnknown -&gt; Inconsistent ) rep=
l( Off -&gt; WFBitMapS )</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0=
/0 drbd1 drbd9-01: send bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1=
), total 21; compression: 100.0%</div><div>Feb 18 12:49:30 drbd9-03 drbdadm=
[28024]: Don&#39;t know which config file belongs to resource r0, trying de=
fault ones...</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 dr=
bd9-01: receive bitmap stats [Bytes(packets)]: plain 0(0), RLE 21(1), total=
 21; compression: 100.0%</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0=
/0 drbd1 drbd9-01: helper command: /sbin/drbdadm before-resync-source</div>=
<div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: helper comm=
and: /sbin/drbdadm before-resync-source exit code 0 (0x0)</div><div>Feb 18 =
12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: repl( WFBitMapS -&gt; S=
yncSource )</div><div>Feb 18 12:49:30 drbd9-03 kernel: drbd r0/0 drbd1 drbd=
9-01: Began resync as SyncSource (will sync 4998328 KB [1249582 bits set]).=
</div><div>Feb 18 12:49:55 drbd9-03 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 2594601400 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:50:01 drbd9-03 systemd: Starting Session 296 of user root.</div><d=
iv>Feb 18 12:50:01 drbd9-03 systemd: Started Session 296 of user root.</div=
><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Aborting remote st=
ate change 2594601400</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 1091225699 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Comm=
itting remote state change 1091225699</div><div>Feb 18 12:50:25 drbd9-03 ke=
rnel: drbd r0 drbd9-02: conn( Connected -&gt; TearDown ) peer( Secondary -&=
gt; Unknown )</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0/0 drbd1 dr=
bd9-02: pdsk( UpToDate -&gt; DUnknown ) repl( Established -&gt; Off )</div>=
<div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver termin=
ated</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Terminati=
ng ack_recv thread</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9=
-04: Rejecting concurrent remote state change 1955398811 because of state c=
hange 1091225699</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-0=
4: Ignoring P_TWOPC_ABORT packet 1955398811.</div><div>Feb 18 12:50:25 drbd=
9-03 kernel: drbd r0 drbd9-02: Connection closed</div><div>Feb 18 12:50:25 =
drbd9-03 kernel: drbd r0 drbd9-02: conn( TearDown -&gt; Unconnected )</div>=
<div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver=
 thread</div><div>Feb 18 12:50:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( =
Unconnected -&gt; Connecting )</div><div>Feb 18 12:50:25 drbd9-03 kernel: d=
rbd r0 drbd9-04: Preparing remote state change 583992461 (primary_nodes=3D0=
, weak_nodes=3D0)</div><div>Feb 18 12:50:26 drbd9-03 kernel: drbd r0 drbd9-=
04: Committing remote state change 583992461</div><div>Feb 18 12:51:13 drbd=
9-03 kernel: drbd r0 drbd9-02: sock_recvmsg returned -11</div><div>Feb 18 1=
2:51:13 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting -&gt; BrokenPip=
e )</div><div>Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: Connection=
 closed</div><div>Feb 18 12:51:13 drbd9-03 kernel: drbd r0 drbd9-02: conn( =
BrokenPipe -&gt; Unconnected )</div><div>Feb 18 12:51:14 drbd9-03 kernel: d=
rbd r0 drbd9-02: conn( Unconnected -&gt; Connecting )</div><div>Feb 18 12:5=
1:23 drbd9-03 kernel: drbd r0 drbd9-01: Preparing remote state change 95535=
6902 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:23 drbd9-03=
 kernel: drbd r0 drbd9-01: Committing remote state change 955356902</div><d=
iv>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Handshake successful:=
 Agreed network protocol version 111</div><div>Feb 18 12:51:24 drbd9-03 ker=
nel: drbd r0 drbd9-02: Feature flags enabled on protocol level: 0x7 TRIM TH=
IN_RESYNC WRITE_SAME.</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 dr=
bd9-02: Starting ack_recv thread (from drbd_r_r0 [27986])</div><div>Feb 18 =
12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: conn( Connecting -&gt; NetworkF=
ailure )</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: ack_r=
eceiver terminated</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9=
-02: Terminating ack_recv thread</div><div>Feb 18 12:51:24 drbd9-03 kernel:=
 drbd r0 drbd9-02: Connection closed</div><div>Feb 18 12:51:24 drbd9-03 ker=
nel: drbd r0 drbd9-02: conn( NetworkFailure -&gt; Unconnected )</div><div>F=
eb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver threa=
d</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconn=
ected -&gt; Connecting )</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0=
 tcp:drbd9-02: Error receiving initial packet</div><div>Feb 18 12:51:24 drb=
d9-03 kernel: drbd r0 drbd9-02: Handshake successful: Agreed network protoc=
ol version 111</div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02:=
 Feature flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.<=
/div><div>Feb 18 12:51:24 drbd9-03 kernel: drbd r0 drbd9-02: Starting ack_r=
ecv thread (from drbd_r_r0 [27986])</div><div>Feb 18 12:51:24 drbd9-03 kern=
el: drbd r0 drbd9-02: Preparing remote state change 515638917 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:25 drbd9-03 kernel: drbd r0 d=
rbd9-02: sock_recvmsg returned -104</div><div>Feb 18 12:51:25 drbd9-03 kern=
el: drbd r0 drbd9-02: conn( Connecting -&gt; NetworkFailure )</div><div>Feb=
 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver terminated</di=
v><div>Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: Terminating ack_r=
ecv thread</div><div>Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02: Con=
nection closed</div><div>Feb 18 12:51:25 drbd9-03 kernel: drbd r0 drbd9-02:=
 conn( NetworkFailure -&gt; Unconnected )</div><div>Feb 18 12:51:25 drbd9-0=
3 kernel: drbd r0 drbd9-02: Restarting receiver thread</div><div>Feb 18 12:=
51:25 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected -&gt; Connecting=
 )</div><div>Feb 18 12:51:26 drbd9-03 kernel: drbd r0 tcp:drbd9-02: initial=
 packet S crossed</div><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-=
02: Handshake successful: Agreed network protocol version 111</div><div>Feb=
 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Feature flags enabled on pr=
otocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div>Feb 18 12:51:27 dr=
bd9-03 kernel: drbd r0 drbd9-02: Starting ack_recv thread (from drbd_r_r0 [=
27986])</div><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Wrong =
magic value 0x83740267 in protocol version 111</div><div>Feb 18 12:51:27 dr=
bd9-03 kernel: drbd r0 drbd9-02: conn( Connecting -&gt; ProtocolError )</di=
v><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: ack_receiver term=
inated</div><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: Termina=
ting ack_recv thread</div><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0 drb=
d9-02: Connection closed</div><div>Feb 18 12:51:27 drbd9-03 kernel: drbd r0=
 drbd9-02: conn( ProtocolError -&gt; Unconnected )</div><div>Feb 18 12:51:2=
7 drbd9-03 kernel: drbd r0 drbd9-02: Restarting receiver thread</div><div>F=
eb 18 12:51:27 drbd9-03 kernel: drbd r0 drbd9-02: conn( Unconnected -&gt; C=
onnecting )</div><div>Feb 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drbd=
9-04: updated UUIDs B6CAADFB7D215BC6:0000000000000000:B6CAADFB7D215BC6:0000=
000000000000</div><div>Feb 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drb=
d9-04: Resync done (total 144 sec; paused 0 sec; 34708 K/sec)</div><div>Feb=
 18 12:51:32 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-04: pdsk( Inconsistent =
-&gt; UpToDate ) repl( SyncSource -&gt; Established )</div><div>Feb 18 12:5=
1:54 drbd9-03 kernel: drbd r0: Two-phase commit 515638917 timeout</div><div=
>Feb 18 12:51:57 drbd9-03 kernel: drbd r0/0 drbd1 drbd9-01: Resync done (to=
tal 147 sec; paused 0 sec; 34000 K/sec)</div><div>Feb 18 12:51:57 drbd9-03 =
kernel: drbd r0/0 drbd1 drbd9-01: pdsk( Inconsistent -&gt; UpToDate ) repl(=
 SyncSource -&gt; Established )</div></div><div><br></div><div><br></div><d=
iv><br></div><div><br></div><div>4) =C2=A0Node4</div><div><br></div><div><d=
iv>Feb 18 12:49:14 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote stat=
e change 828078891 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:14 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 82807=
8891</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing=
 remote state change 916340848 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state =
change 916340848</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 3809938960 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 3809938960</div><div>Feb 18 12:49:15 drbd9-04 kernel: =
drbd r0 drbd9-03: Preparing remote state change 466030330 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9=
-03: Aborting remote state change 466030330</div><div>Feb 18 12:49:15 drbd9=
-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3871624072 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: =
drbd r0 drbd9-03: Aborting remote state change 3871624072</div><div>Feb 18 =
12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 5=
62578872 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd=
9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 562578872</div>=
<div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote st=
ate change 3059617914 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 30=
59617914</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Prepa=
ring remote state change 1765006974 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote s=
tate change 1765006974</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 d=
rbd9-03: Preparing remote state change 4282026993 (primary_nodes=3D0, weak_=
nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Abo=
rting remote state change 4282026993</div><div>Feb 18 12:49:15 drbd9-04 ker=
nel: drbd r0 drbd9-02: Handshake successful: Agreed network protocol versio=
n 111</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Feature =
flags enabled on protocol level: 0x7 TRIM THIN_RESYNC WRITE_SAME.</div><div=
>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Starting ack_recv threa=
d (from drbd_r_r0 [21093])</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd =
r0 drbd9-03: Preparing remote state change 541907284 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: =
Aborting remote state change 541907284</div><div>Feb 18 12:49:15 drbd9-04 k=
ernel: drbd r0 drbd9-03: Preparing remote state change 3720310948 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd =
r0 drbd9-03: Aborting remote state change 3720310948</div><div>Feb 18 12:49=
:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 252558=
1650 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04=
 kernel: drbd r0 drbd9-03: Aborting remote state change 2525581650</div><di=
v>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state=
 change 233526968 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 233526=
968</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing =
remote state change 1832763483 (primary_nodes=3D0, weak_nodes=3D0)</div><di=
v>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state =
change 1832763483</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-=
03: Preparing remote state change 919412360 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 919412360</div><div>Feb 18 12:49:15 drbd9-04 kernel: d=
rbd r0 drbd9-03: Preparing remote state change 3167526743 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9=
-03: Aborting remote state change 3167526743</div><div>Feb 18 12:49:15 drbd=
9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 1726750051 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel:=
 drbd r0 drbd9-03: Aborting remote state change 1726750051</div><div>Feb 18=
 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change =
135300592 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drb=
d9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 135300592</div=
><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote s=
tate change 1945757685 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 1=
945757685</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Prep=
aring remote state change 120559031 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote s=
tate change 120559031</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 dr=
bd9-03: Preparing remote state change 1931376741 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Abor=
ting remote state change 1931376741</div><div>Feb 18 12:49:15 drbd9-04 kern=
el: drbd r0 drbd9-03: Preparing remote state change 2685589933 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 =
drbd9-03: Aborting remote state change 2685589933</div><div>Feb 18 12:49:15=
 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 289587103=
3 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 ke=
rnel: drbd r0 drbd9-03: Aborting remote state change 2895871033</div><div>F=
eb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state ch=
ange 1657331205 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
15 drbd9-04 kernel: drbd r0 drbd9-02: Committing remote state change 165733=
1205</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: conn( Con=
necting -&gt; Connected ) peer( Unknown -&gt; Secondary )</div><div>Feb 18 =
12:49:15 drbd9-04 kernel: drbd r0/0 drbd1: peer does not support WRITE_SAME=
</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: drbd_=
sync_handshake:</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 =
drbd9-02: self 0000000000000004:0000000000000000:0000000000000000:000000000=
0000000 bits:102960 flags:0</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd=
 r0/0 drbd1 drbd9-02: peer B6CAADFB7D215BC6:B6CAADFB7D215BC6:B6CAADFB7D215B=
C6:0000000000000000 bits:758062 flags:120</div><div>Feb 18 12:49:15 drbd9-0=
4 kernel: drbd r0/0 drbd1 drbd9-02: uuid_compare()=3D-3 by rule 20</div><di=
v>Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: pdsk( DUnknown=
 -&gt; UpToDate ) repl( Off -&gt; WFBitMapT )</div><div>Feb 18 12:49:15 drb=
d9-04 kernel: drbd r0/0 drbd1 drbd9-02: receive bitmap stats [Bytes(packets=
)]: plain 0(0), RLE 21(1), total 21; compression: 100.0%</div><div>Feb 18 1=
2:49:15 drbd9-04 drbdadm[21216]: Don&#39;t know which config file belongs t=
o resource r0, trying default ones...</div><div>Feb 18 12:49:15 drbd9-04 ke=
rnel: drbd r0/0 drbd1 drbd9-02: send bitmap stats [Bytes(packets)]: plain 0=
(0), RLE 21(1), total 21; compression: 100.0%</div><div>Feb 18 12:49:15 drb=
d9-04 kernel: drbd r0/0 drbd1 drbd9-02: helper command: /sbin/drbdadm befor=
e-resync-target</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 =
drbd9-02: helper command: /sbin/drbdadm before-resync-target exit code 0 (0=
x0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-02: re=
pl( WFBitMapT -&gt; PausedSyncT )</div><div>Feb 18 12:49:15 drbd9-04 kernel=
: drbd r0/0 drbd1 drbd9-02: Began resync as PausedSyncT (will sync 4998328 =
KB [1249582 bits set]).</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 =
drbd9-03: Preparing remote state change 352665508 (primary_nodes=3D0, weak_=
nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Abo=
rting remote state change 352665508</div><div>Feb 18 12:49:15 drbd9-04 kern=
el: drbd r0 drbd9-03: Preparing remote state change 1037382588 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 =
drbd9-03: Aborting remote state change 1037382588</div><div>Feb 18 12:49:15=
 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 399118927=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 ker=
nel: drbd r0 drbd9-03: Aborting remote state change 399118927</div><div>Feb=
 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state chan=
ge 1547038261 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15=
 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 1547038261=
</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 90711453 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state chang=
e 90711453</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Pre=
paring remote state change 2906061427 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote=
 state change 2906061427</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0=
 drbd9-02: Preparing remote state change 110758586 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Ab=
orting remote state change 110758586</div><div>Feb 18 12:49:15 drbd9-04 ker=
nel: drbd r0 drbd9-03: Preparing remote state change 19982401 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 d=
rbd9-03: Aborting remote state change 19982401</div><div>Feb 18 12:49:15 dr=
bd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 1229720926 (=
primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kerne=
l: drbd r0 drbd9-02: Aborting remote state change 1229720926</div><div>Feb =
18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state chang=
e 2599231352 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:15 =
drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 2599231352<=
/div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remo=
te state change 1975668868 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state chan=
ge 1975668868</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: =
Preparing remote state change 2505675278 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-03: Aborting rem=
ote state change 2505675278</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd=
 r0 drbd9-02: Preparing remote state change 4000831140 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:15 drbd9-04 kernel: drbd r0 drbd9-02=
: Aborting remote state change 4000831140</div><div>Feb 18 12:49:16 drbd9-0=
4 kernel: drbd r0 drbd9-03: Preparing remote state change 2750887982 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: dr=
bd r0 drbd9-03: Aborting remote state change 2750887982</div><div>Feb 18 12=
:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 246=
8909229 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9=
-04 kernel: drbd r0 drbd9-02: Aborting remote state change 2468909229</div>=
<div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote st=
ate change 2662778291 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 26=
62778291</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Prepa=
ring remote state change 4035033791 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote s=
tate change 4035033791</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 d=
rbd9-02: Preparing remote state change 1708023363 (primary_nodes=3D0, weak_=
nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Abo=
rting remote state change 1708023363</div><div>Feb 18 12:49:16 drbd9-04 ker=
nel: drbd r0 drbd9-02: Preparing remote state change 575587423 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 =
drbd9-02: Aborting remote state change 575587423</div><div>Feb 18 12:49:16 =
drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3005066576=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 ker=
nel: drbd r0 drbd9-03: Aborting remote state change 3005066576</div><div>Fe=
b 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state cha=
nge 2982970747 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
6 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 298297074=
7</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing re=
mote state change 1635237549 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state ch=
ange 1635237549</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02=
: Preparing remote state change 3629941899 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 3629941899</div><div>Feb 18 12:49:16 drbd9-04 kernel: =
drbd r0 drbd9-03: Preparing remote state change 3563238485 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 dr=
bd9-03: Aborting remote state change 3563238485</div><div>Feb 18 12:49:16 d=
rbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3238325029 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kern=
el: drbd r0 drbd9-03: Aborting remote state change 3238325029</div><div>Feb=
 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state chan=
ge 3638753626 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16=
 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 3638753626=
</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing rem=
ote state change 3599232118 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state cha=
nge 3599232118</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03:=
 Preparing remote state change 113146377 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting rem=
ote state change 113146377</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd =
r0 drbd9-02: Preparing remote state change 3173991607 (primary_nodes=3D0, w=
eak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02:=
 Aborting remote state change 3173991607</div><div>Feb 18 12:49:16 drbd9-04=
 kernel: drbd r0 drbd9-02: Preparing remote state change 3766324938 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drb=
d r0 drbd9-02: Aborting remote state change 3766324938</div><div>Feb 18 12:=
49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 1350=
394170 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-=
04 kernel: drbd r0 drbd9-02: Aborting remote state change 1350394170</div><=
div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote sta=
te change 2874348269 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 287=
4348269</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Prepar=
ing remote state change 1961866418 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote st=
ate change 1961866418</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 1422080841 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 1422080841</div><div>Feb 18 12:49:16 drbd9-04 kern=
el: drbd r0 drbd9-02: Preparing remote state change 1935970639 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 =
drbd9-02: Aborting remote state change 1935970639</div><div>Feb 18 12:49:16=
 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 36989052 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kern=
el: drbd r0 drbd9-03: Aborting remote state change 36989052</div><div>Feb 1=
8 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change=
 582050229 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 dr=
bd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 582050229</di=
v><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote =
state change 4192500224 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 1=
8 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change =
4192500224</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Pre=
paring remote state change 2039128137 (primary_nodes=3D0, weak_nodes=3D0)</=
div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote=
 state change 2039128137</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0=
 drbd9-03: Preparing remote state change 821093755 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-03: Ab=
orting remote state change 821093755</div><div>Feb 18 12:49:16 drbd9-04 ker=
nel: drbd r0 drbd9-02: Preparing remote state change 3518597027 (primary_no=
des=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 kernel: drbd r0=
 drbd9-02: Aborting remote state change 3518597027</div><div>Feb 18 12:49:1=
6 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 45285868=
2 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:16 drbd9-04 ke=
rnel: drbd r0 drbd9-03: Aborting remote state change 452858682</div><div>Fe=
b 18 12:49:16 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state cha=
nge 2321677588 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
6 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 232167758=
8</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing re=
mote state change 3637280121 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state ch=
ange 3637280121</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02=
: Preparing remote state change 261689227 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 261689227</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd=
 r0 drbd9-03: Preparing remote state change 1843385190 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03=
: Aborting remote state change 1843385190</div><div>Feb 18 12:49:17 drbd9-0=
4 kernel: drbd r0 drbd9-02: Preparing remote state change 3197178194 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: dr=
bd r0 drbd9-02: Aborting remote state change 3197178194</div><div>Feb 18 12=
:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 767=
463344 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-=
04 kernel: drbd r0 drbd9-03: Aborting remote state change 767463344</div><d=
iv>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote stat=
e change 3875723021 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12=
:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 3875=
723021</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Prepari=
ng remote state change 3351946337 (primary_nodes=3D0, weak_nodes=3D0)</div>=
<div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote sta=
te change 3351946337</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drb=
d9-02: Preparing remote state change 3454915512 (primary_nodes=3D0, weak_no=
des=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Abort=
ing remote state change 3454915512</div><div>Feb 18 12:49:17 drbd9-04 kerne=
l: drbd r0 drbd9-03: Preparing remote state change 2640937765 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 d=
rbd9-03: Aborting remote state change 2640937765</div><div>Feb 18 12:49:17 =
drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 3044822599=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 3044822599</div><div>Fe=
b 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state cha=
nge 3354987837 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
7 drbd9-04 kernel: drbd r0 drbd9-02: Rejecting concurrent remote state chan=
ge 3556374775 because of state change 3354987837</div><div>Feb 18 12:49:17 =
drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 3354987837<=
/div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remo=
te state change 2026795642 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Fe=
b 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state chan=
ge 2026795642</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: =
Preparing remote state change 1409529751 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 1409529751</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd=
 r0 drbd9-03: Preparing remote state change 3085364587 (primary_nodes=3D0, =
weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03=
: Aborting remote state change 3085364587</div><div>Feb 18 12:49:17 drbd9-0=
4 kernel: drbd r0 drbd9-02: Preparing remote state change 1803219856 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: dr=
bd r0 drbd9-02: Aborting remote state change 1803219856</div><div>Feb 18 12=
:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 242=
3822761 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9=
-04 kernel: drbd r0 drbd9-03: Aborting remote state change 2423822761</div>=
<div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote st=
ate change 2070740492 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 =
12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 20=
70740492</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Prepa=
ring remote state change 424571609 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote st=
ate change 424571609</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drb=
d9-02: Preparing remote state change 1861094959 (primary_nodes=3D0, weak_no=
des=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Abort=
ing remote state change 1861094959</div><div>Feb 18 12:49:17 drbd9-04 kerne=
l: drbd r0 drbd9-03: Preparing remote state change 1439155988 (primary_node=
s=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 d=
rbd9-03: Aborting remote state change 1439155988</div><div>Feb 18 12:49:17 =
drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 1912776257=
 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 ker=
nel: drbd r0 drbd9-02: Aborting remote state change 1912776257</div><div>Fe=
b 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state cha=
nge 3342040311 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:1=
7 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 334204031=
1</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing re=
mote state change 3583634975 (primary_nodes=3D0, weak_nodes=3D0)</div><div>=
Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state ch=
ange 3583634975</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03=
: Preparing remote state change 3560986460 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 3560986460</div><div>Feb 18 12:49:17 drbd9-04 kernel: =
drbd r0 drbd9-02: Preparing remote state change 1059596388 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 1059596388</div><div>Feb 18 12:49:17 d=
rbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 2039774846 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kern=
el: drbd r0 drbd9-03: Aborting remote state change 2039774846</div><div>Feb=
 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2984515839 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17=
 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 2984515839=
</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing rem=
ote state change 2729731529 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state cha=
nge 2729731529</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 3776435962 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 3776435962</div><div>Feb 18 12:49:17 drbd9-04 kernel: drb=
d r0 drbd9-03: Preparing remote state change 1499748024 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-0=
3: Aborting remote state change 1499748024</div><div>Feb 18 12:49:17 drbd9-=
04 kernel: drbd r0 drbd9-02: Preparing remote state change 2633932659 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: d=
rbd r0 drbd9-02: Aborting remote state change 2633932659</div><div>Feb 18 1=
2:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 34=
20883318 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd=
9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 3420883318</div=
><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote s=
tate change 3805539839 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18=
 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 3=
805539839</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Prep=
aring remote state change 2892821134 (primary_nodes=3D0, weak_nodes=3D0)</d=
iv><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote =
state change 2892821134</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 =
drbd9-02: Preparing remote state change 3642844571 (primary_nodes=3D0, weak=
_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0 drbd9-02: Ab=
orting remote state change 3642844571</div><div>Feb 18 12:49:17 drbd9-04 ke=
rnel: drbd r0 drbd9-03: Preparing remote state change 110768160 (primary_no=
des=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kernel: drbd r0=
 drbd9-03: Aborting remote state change 110768160</div><div>Feb 18 12:49:17=
 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 17859418 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:17 drbd9-04 kern=
el: drbd r0 drbd9-02: Aborting remote state change 17859418</div><div>Feb 1=
8 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change=
 1919413000 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 d=
rbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 1919413000</=
div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remot=
e state change 1145386916 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb=
 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state chang=
e 1145386916</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: P=
reparing remote state change 2321101024 (primary_nodes=3D0, weak_nodes=3D0)=
</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remo=
te state change 2321101024</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd =
r0 drbd9-02: Preparing remote state change 3288824952 (primary_nodes=3D0, w=
eak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02:=
 Aborting remote state change 3288824952</div><div>Feb 18 12:49:18 drbd9-04=
 kernel: drbd r0 drbd9-03: Preparing remote state change 2274965928 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drb=
d r0 drbd9-03: Aborting remote state change 2274965928</div><div>Feb 18 12:=
49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 3641=
522607 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-=
04 kernel: drbd r0 drbd9-02: Aborting remote state change 3641522607</div><=
div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote sta=
te change 3926057794 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 392=
6057794</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Prepar=
ing remote state change 128435041 (primary_nodes=3D0, weak_nodes=3D0)</div>=
<div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote sta=
te change 128435041</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd=
9-03: Preparing remote state change 620951758 (primary_nodes=3D0, weak_node=
s=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Abortin=
g remote state change 620951758</div><div>Feb 18 12:49:18 drbd9-04 kernel: =
drbd r0 drbd9-02: Preparing remote state change 1067274131 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 1067274131</div><div>Feb 18 12:49:18 d=
rbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3401606816 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kern=
el: drbd r0 drbd9-03: Aborting remote state change 3401606816</div><div>Feb=
 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2464745589 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18=
 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 2464745589=
</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing rem=
ote state change 3575638272 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state cha=
nge 3575638272</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 289378464 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting rem=
ote state change 289378464</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd =
r0 drbd9-03: Preparing remote state change 1793285500 (primary_nodes=3D0, w=
eak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03:=
 Aborting remote state change 1793285500</div><div>Feb 18 12:49:18 drbd9-04=
 kernel: drbd r0 drbd9-02: Preparing remote state change 2159434546 (primar=
y_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drb=
d r0 drbd9-02: Aborting remote state change 2159434546</div><div>Feb 18 12:=
49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3776=
803522 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-=
04 kernel: drbd r0 drbd9-03: Aborting remote state change 3776803522</div><=
div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote sta=
te change 2020636307 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 1=
2:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 202=
0636307</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Prepar=
ing remote state change 2574235971 (primary_nodes=3D0, weak_nodes=3D0)</div=
><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote st=
ate change 2574235971</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 1115473996 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 1115473996</div><div>Feb 18 12:49:18 drbd9-04 kern=
el: drbd r0 drbd9-03: Preparing remote state change 1681934234 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 =
drbd9-03: Aborting remote state change 1681934234</div><div>Feb 18 12:49:18=
 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 292690412=
9 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 ke=
rnel: drbd r0 drbd9-02: Aborting remote state change 2926904129</div><div>F=
eb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state ch=
ange 1651456969 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 16514569=
69</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing r=
emote state change 1578249747 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state c=
hange 1578249747</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 430284320 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 430284320</div><div>Feb 18 12:49:18 drbd9-04 kernel: d=
rbd r0 drbd9-02: Preparing remote state change 4168451443 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9=
-02: Aborting remote state change 4168451443</div><div>Feb 18 12:49:18 drbd=
9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3304566520 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel:=
 drbd r0 drbd9-03: Aborting remote state change 3304566520</div><div>Feb 18=
 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change =
2489323610 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 dr=
bd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 2489323610</d=
iv><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote=
 state change 2784036568 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb =
18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change=
 2784036568</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Pr=
eparing remote state change 2444898555 (primary_nodes=3D0, weak_nodes=3D0)<=
/div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remot=
e state change 2444898555</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r=
0 drbd9-03: Preparing remote state change 2821131655 (primary_nodes=3D0, we=
ak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: =
Aborting remote state change 2821131655</div><div>Feb 18 12:49:18 drbd9-04 =
kernel: drbd r0 drbd9-02: Preparing remote state change 649862413 (primary_=
nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd =
r0 drbd9-02: Aborting remote state change 649862413</div><div>Feb 18 12:49:=
18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 1360241=
560 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 =
kernel: drbd r0 drbd9-03: Aborting remote state change 1360241560</div><div=
>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state =
change 3610428486 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:4=
9:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 361042=
8486</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing=
 remote state change 2654692450 (primary_nodes=3D0, weak_nodes=3D0)</div><d=
iv>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state=
 change 2654692450</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9=
-02: Preparing remote state change 237694475 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9-02: Aborting=
 remote state change 237694475</div><div>Feb 18 12:49:18 drbd9-04 kernel: d=
rbd r0 drbd9-03: Preparing remote state change 2561046587 (primary_nodes=3D=
0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel: drbd r0 drbd9=
-03: Aborting remote state change 2561046587</div><div>Feb 18 12:49:18 drbd=
9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 2123728468 (pr=
imary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 drbd9-04 kernel:=
 drbd r0 drbd9-02: Aborting remote state change 2123728468</div><div>Feb 18=
 12:49:18 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change =
1716193777 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:18 dr=
bd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 1716193777</d=
iv><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote=
 state change 954801834 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 1=
8 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change =
954801834</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Prep=
aring remote state change 997680699 (primary_nodes=3D0, weak_nodes=3D0)</di=
v><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote s=
tate change 997680699</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 dr=
bd9-02: Preparing remote state change 1595210697 (primary_nodes=3D0, weak_n=
odes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Abor=
ting remote state change 1595210697</div><div>Feb 18 12:49:19 drbd9-04 kern=
el: drbd r0 drbd9-03: Preparing remote state change 1795247459 (primary_nod=
es=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 =
drbd9-03: Aborting remote state change 1795247459</div><div>Feb 18 12:49:19=
 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state change 131269443=
1 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 ke=
rnel: drbd r0 drbd9-02: Aborting remote state change 1312694431</div><div>F=
eb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state ch=
ange 1531206635 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:=
19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state change 15312066=
35</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing r=
emote state change 1379557998 (primary_nodes=3D0, weak_nodes=3D0)</div><div=
>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state c=
hange 1379557998</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-0=
3: Preparing remote state change 3792084596 (primary_nodes=3D0, weak_nodes=
=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting=
 remote state change 3792084596</div><div>Feb 18 12:49:19 drbd9-04 kernel: =
drbd r0 drbd9-02: Preparing remote state change 1368060281 (primary_nodes=
=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 dr=
bd9-02: Aborting remote state change 1368060281</div><div>Feb 18 12:49:19 d=
rbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 3569716009 =
(primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kern=
el: drbd r0 drbd9-03: Aborting remote state change 3569716009</div><div>Feb=
 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 1393085582 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19=
 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 1393085582=
</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing rem=
ote state change 4267014762 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-03: Aborting remote state cha=
nge 4267014762</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02:=
 Preparing remote state change 1428881181 (primary_nodes=3D0, weak_nodes=3D=
0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting re=
mote state change 1428881181</div><div>Feb 18 12:49:19 drbd9-04 kernel: drb=
d r0 drbd9-03: Preparing remote state change 1718804050 (primary_nodes=3D0,=
 weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-0=
3: Aborting remote state change 1718804050</div><div>Feb 18 12:49:19 drbd9-=
04 kernel: drbd r0 drbd9-02: Preparing remote state change 610769045 (prima=
ry_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-04 kernel: dr=
bd r0 drbd9-02: Aborting remote state change 610769045</div><div>Feb 18 12:=
49:19 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 7956=
05995 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:19 drbd9-0=
4 kernel: drbd r0 drbd9-03: Aborting remote state change 795605995</div><di=
v>Feb 18 12:49:19 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state=
 change 2783224475 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:=
49:19 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state change 27832=
24475</div><div>Feb 18 12:49:29 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Clos=
ing unexpected connection from 100.100.10.11</div><div>Feb 18 12:49:30 drbd=
9-04 kernel: drbd r0 drbd9-03: Preparing remote state change 444800473 (pri=
mary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:30 drbd9-04 kernel: =
drbd r0 drbd9-03: Committing remote state change 444800473</div><div>Feb 18=
 12:49:38 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connect=
ion from 100.100.10.11</div><div>Feb 18 12:49:49 drbd9-04 kernel: drbd r0 t=
cp:drbd9-05: Closing unexpected connection from 100.100.10.11</div><div>Feb=
 18 12:49:55 drbd9-04 kernel: drbd r0 drbd9-02: Preparing remote state chan=
ge 2594601400 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:49:55=
 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connection from =
100.100.10.11</div><div>Feb 18 12:50:01 drbd9-04 systemd: Starting Session =
139 of user root.</div><div>Feb 18 12:50:01 drbd9-04 systemd: Started Sessi=
on 139 of user root.</div><div>Feb 18 12:50:07 drbd9-04 kernel: drbd r0 tcp=
:drbd9-05: Closing unexpected connection from 100.100.10.11</div><div>Feb 1=
8 12:50:16 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected connec=
tion from 100.100.10.11</div><div>Feb 18 12:50:25 drbd9-04 kernel: drbd r0 =
tcp:drbd9-05: Closing unexpected connection from 100.100.10.11</div><div>Fe=
b 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Aborting remote state chan=
ge 2594601400</div><div>Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: =
Preparing remote state change 1091225699 (primary_nodes=3D0, weak_nodes=3D0=
)</div><div>Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-02: Committing r=
emote state change 1091225699</div><div>Feb 18 12:50:25 drbd9-04 kernel: dr=
bd r0 drbd9-02: Preparing remote state change 1955398811 (primary_nodes=3D0=
, weak_nodes=3D0)</div><div>Feb 18 12:50:25 drbd9-04 kernel: drbd r0 drbd9-=
02: Aborting remote state change 1955398811</div><div>Feb 18 12:50:25 drbd9=
-04 kernel: drbd r0 drbd9-02: Preparing remote state change 583992461 (prim=
ary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:50:26 drbd9-04 kernel: d=
rbd r0 drbd9-02: Committing remote state change 583992461</div><div>Feb 18 =
12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connected -&gt; TearDown =
) peer( Secondary -&gt; Unknown )</div><div>Feb 18 12:50:26 drbd9-04 kernel=
: drbd r0/0 drbd1 drbd9-02: pdsk( UpToDate -&gt; DUnknown ) repl( PausedSyn=
cT -&gt; Off )</div><div>Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02:=
 ack_receiver terminated</div><div>Feb 18 12:50:26 drbd9-04 kernel: drbd r0=
 drbd9-02: Terminating ack_recv thread</div><div>Feb 18 12:50:26 drbd9-04 k=
ernel: drbd r0 drbd9-02: Connection closed</div><div>Feb 18 12:50:26 drbd9-=
04 kernel: drbd r0 drbd9-02: conn( TearDown -&gt; Unconnected )</div><div>F=
eb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: Restarting receiver threa=
d</div><div>Feb 18 12:50:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconn=
ected -&gt; Connecting )</div><div>Feb 18 12:50:36 drbd9-04 kernel: drbd r0=
 tcp:drbd9-02: Closing unexpected connection from 100.100.10.11</div><div>F=
eb 18 12:50:48 drbd9-04 kernel: drbd r0 tcp:drbd9-02: Closing unexpected co=
nnection from 100.100.10.11</div><div>Feb 18 12:51:00 drbd9-04 kernel: drbd=
 r0 tcp:drbd9-02: Closing unexpected connection from 100.100.10.11</div><di=
v>Feb 18 12:51:12 drbd9-04 kernel: drbd r0 tcp:drbd9-05: Closing unexpected=
 connection from 100.100.10.11</div><div>Feb 18 12:51:13 drbd9-04 kernel: d=
rbd r0 drbd9-02: sock_recvmsg returned -11</div><div>Feb 18 12:51:13 drbd9-=
04 kernel: drbd r0 drbd9-02: conn( Connecting -&gt; BrokenPipe )</div><div>=
Feb 18 12:51:13 drbd9-04 kernel: drbd r0/0 drbd1: ASSERTION list_empty(&amp=
;device-&gt;sync_ee) FAILED in drbd_disconnected</div><div>Feb 18 12:51:13 =
drbd9-04 kernel: drbd r0 drbd9-02: Connection closed</div><div>Feb 18 12:51=
:13 drbd9-04 kernel: drbd r0 drbd9-02: conn( BrokenPipe -&gt; Unconnected )=
</div><div>Feb 18 12:51:14 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconne=
cted -&gt; Connecting )</div><div>Feb 18 12:51:20 drbd9-04 kernel: drbd r0 =
tcp:drbd9-02: Closing unexpected connection from 100.100.10.11</div><div>Fe=
b 18 12:51:23 drbd9-04 kernel: drbd r0 drbd9-03: Preparing remote state cha=
nge 955356902 (primary_nodes=3D0, weak_nodes=3D0)</div><div>Feb 18 12:51:23=
 drbd9-04 kernel: drbd r0 drbd9-03: Committing remote state change 95535690=
2</div><div>Feb 18 12:51:24 drbd9-04 kernel: drbd r0 drbd9-03: Preparing re=
mote state change 515638917 (primary_nodes=3D0, weak_nodes=3D0)</div><div>F=
eb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: sock_recvmsg returned -11=
</div><div>Feb 18 12:51:26 drbd9-04 kernel: drbd r0 drbd9-02: conn( Connect=
ing -&gt; BrokenPipe )</div><div>Feb 18 12:51:26 drbd9-04 kernel: drbd r0 d=
rbd9-02: Connection closed</div><div>Feb 18 12:51:26 drbd9-04 kernel: drbd =
r0 drbd9-02: conn( BrokenPipe -&gt; Unconnected )</div><div>Feb 18 12:51:27=
 drbd9-04 kernel: drbd r0 drbd9-02: conn( Unconnected -&gt; Connecting )</d=
iv><div>Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: Resync d=
one (total 144 sec; paused 0 sec; 34708 K/sec)</div><div>Feb 18 12:51:32 dr=
bd9-04 kernel: drbd r0/0 drbd1 drbd9-03: updated UUIDs B6CAADFB7D215BC6:000=
0000000000000:0000000000000000:0000000000000000</div><div>Feb 18 12:51:32 d=
rbd9-04 kernel: drbd r0/0 drbd1: disk( Inconsistent -&gt; UpToDate )</div><=
div>Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-05: pdsk( DUnkno=
wn -&gt; Outdated ) resync-susp( connection dependency -&gt; no )</div><div=
>Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: repl( SyncTarge=
t -&gt; Established )</div><div>Feb 18 12:51:32 drbd9-04 kernel: drbd r0/0 =
drbd1 drbd9-02: resync-susp( connection dependency -&gt; no )</div><div>Feb=
 18 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-01: pdsk( DUnknown -&gt=
; Outdated ) resync-susp( connection dependency -&gt; no )</div><div>Feb 18=
 12:51:32 drbd9-04 kernel: drbd r0/0 drbd1 drbd9-03: helper command: /sbin/=
drbdadm after-resync-target</div></div><div><br></div><div><br></div><div>4=
. Question</div><div>=C2=A0- Could you please check HANG position at Node 2=
 log?<br><div><div dir=3D"ltr"><div dir=3D"ltr"><p style=3D"margin:0cm 0cm =
0pt"><br></p><p style=3D"margin:0cm 0cm 0pt"><br></p><p style=3D"margin:0cm=
 0cm 0pt"><br></p><p style=3D"margin:0cm 0cm 0pt">Thanks.</p><p style=3D"ma=
rgin:0cm 0cm 0pt"><br></p><p style=3D"margin:0cm 0cm 0pt"><br></p><p style=
=3D"margin:0cm 0cm 0pt"><br></p></div></div></div>
</div></div>

--001a113da7c861391b052c04c938--
