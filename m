Return-Path: <mrten+drbd@ii.nl>
Received: from mail2.ii.nl (mail2.ii.nl [82.94.191.121])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 99D14105627A
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2011 15:12:02 +0200 (CEST)
Received: from s529c1e11.adsl.wanadoo.nl ([82.156.30.17]:65518 helo=kyra.ii.nl)
	by mail2.ii.nl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mrten+drbd@ii.nl>) id 1QrV3K-000142-80
	for drbd-dev@lists.linbit.com; Thu, 11 Aug 2011 15:12:02 +0200
Received: from droopy.i.mrten ([192.168.27.2]:62891)
	by kyra.ii.nl with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <mrten+drbd@ii.nl>) id 1QrV3J-0002Us-F2
	for drbd-dev@lists.linbit.com; Thu, 11 Aug 2011 15:12:01 +0200
Message-ID: <4E43D510.205@ii.nl>
Date: Thu, 11 Aug 2011 15:11:44 +0200
From: Mrten <mrten+drbd@ii.nl>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] documentation per release suggestion
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Probably this has been suggested before, but, couldn't the docs be
tagged and released to the website with the version number in the path?

That way, one could always look at the docs that are most relevant for
the versions one is using. Once written, you'd never have to touch them
again.

The latest docs could be in a symlinked directory 'latest' or 'current'.

Exim, the mailer, does this (always has), and it is really a joy to use
(the docs for Exim are very thoroughly written, too).

http://docs.exim.org/current/spec_html/index.html
http://docs.exim.org/4.69/spec_html/index.html


This would prevent questions and emails like

http://lists.linbit.com/pipermail/drbd-user/2011-August/016658.html

, assuming people read the docs before asking questions, of course.

Just an idea,
Mrten.
