Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [213.46.255.17])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 5ECC31432F
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 18:35:36 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148]) by viefep16-int.chello.at
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20040921163536.BKES22611.viefep16-int.chello.at@wollmersdorfer.at>
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 18:35:36 +0200
Message-ID: <41505858.5080909@wollmersdorfer.at>
Date: Tue, 21 Sep 2004 18:35:36 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <97851D36-08AC-11D9-9842-000A95E071BA@multimap.com>	<414B12E9.3040408@unix.sh>
	<cig3mt$71s$1@sea.gmane.org>
	<200409211627.19567.philipp.reisner@linbit.com>
In-Reply-To: <200409211627.19567.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] docs reworking (was: Does DRDB do 'intelligent'
	mirroring?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp Reisner wrote:
> On Saturday 18 September 2004 03:40, Helmut Wollmersdorfer wrote:

>> From the middle of next week I should have time to do some dozens of
>>hours docu work.

> Are you going to work on the docs only ?
> Could you imagine to go over the web-pages ?

Yeah, everything should be done.

It's just a matter of time;-)

Personally I do not like CMS' or wikis, but I can live with it. Content 
should be brought to an actual state, but I will not touch the structure.

Priorities:
- man pages (very high)
- HOWTO (high)
- web (medium - high)
- docbook.sgml -> docbook.xml (low)
- german translation (low)

Problems to discuss:
1) The pt and jp versions are outdated.
    We should either remove them from 0.7.x or include a "NOTE: This
    translation is outdated. Feel free to improve it."
2) Can I take some useful parts of text from Linbit, LGE and LMB?
    Appropriate references would be included.

Helmut


