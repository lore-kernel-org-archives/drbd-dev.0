Return-Path: <gld-drbd-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 52DCC2E051C1
	for <drbd-dev@lists.linbit.com>; Fri, 17 Aug 2007 08:11:20 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILuiw-0008SA-PT
	for drbd-dev@lists.linbit.com; Fri, 17 Aug 2007 07:50:18 +0200
Received: from ns.flora.lv ([83.223.142.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 17 Aug 2007 07:50:18 +0200
Received: from Daliv by ns.flora.lv with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <drbd-dev@lists.linbit.com>; Fri, 17 Aug 2007 07:50:18 +0200
To: drbd-dev@lists.linbit.com
From: DaLiV <Daliv@apollo.lv>
Date: Fri, 17 Aug 2007 08:49:46 +0300
Message-ID: <fa3ctq$1fl$1@sea.gmane.org>
References: <BD7042533C2F8943A6A4257A9E31C45439C8D3@EXNA.corp.stratus.com>
	<200701301646.55342.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200701301646.55342.philipp.reisner@linbit.com>
Sender: news <news@sea.gmane.org>
Subject: [Drbd-dev] Re: Make doc complains about
	/usr/share/xml/schema/dtd/3/docbookx.dtd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp Reisner wrote:
> Am Dienstag, 30. Januar 2007 16:10 schrieb Montrose, Ernest:
>   
>> Hi all,
>> I do not have that file on my build machine so I canno make "doc" now.
>> Should I install something?
>>     
solution :
remove nex part of line
"/usr/share/xml/docbook/schema/dtd/3/docbookx.dtd"
from
<drbd source folder>/documentation/*.sgml



