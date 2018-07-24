Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 664571019AC6
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 06:40:46 +0200 (CEST)
Received: from pulsar.alteeve.com (ip-104-193-58-76.user.start.ca
	[104.193.58.76])
	by mail.alteeve.ca (Postfix) with ESMTPSA id 22FE8E011B
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 00:40:45 -0400 (EDT)
To: drbd-dev@lists.linbit.com
From: Digimer <lists@alteeve.ca>
Message-ID: <cb6d86c4-acbb-f299-00fe-e83f6c4e69ba@alteeve.ca>
Date: Tue, 24 Jul 2018 00:40:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] DRBD 9 on Fedora 28
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

Hi all,

  I'm trying to get DRBD 9 on Fedora 28 (which I'm using as a dev
platform ahead of RHEL 8 beta). The DRBD that ships with the kernel is
8.4.10.

  I've been struggling to build the 9.0.15rc1 RPM without luck. I've
made a few progressions (ie: added kernel-rpm-macros, kernel-devel and
elfutils-devel to BuildRequires).

  Has anyone managed to build DRBD9 on Fedora 27+? If so, would you mind
sharing the src.rpm or .spec?

Thanks!

digimer

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
