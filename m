Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EB4311013806
	for <drbd-dev@lists.linbit.com>; Tue, 24 Jul 2018 01:26:58 +0200 (CEST)
Received: from pulsar.alteeve.com (ip-104-193-58-76.user.start.ca
	[104.193.58.76])
	by mail.alteeve.ca (Postfix) with ESMTPSA id 5985EE011B
	for <drbd-dev@lists.linbit.com>; Mon, 23 Jul 2018 19:19:38 -0400 (EDT)
To: drbd-dev@lists.linbit.com
From: Digimer <lists@alteeve.ca>
Message-ID: <225e8fd1-fc2e-287a-63cb-00ce31fa79b5@alteeve.ca>
Date: Mon, 23 Jul 2018 19:19:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] BuildRequires for drbd-utils
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

  I'm working on RPMs for Fedora, and noticed two missing build
dependencies in drbd-utils-9.5.0;

BuildRequires: automake
BuildRequires: libxslt

Cheers

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
