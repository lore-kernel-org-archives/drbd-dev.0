Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 1177F14332
	for <drbd-dev@lists.linbit.com>; Tue, 21 Sep 2004 14:58:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] Handling of internal split-brain in multiple
	state resources
Date: Tue, 21 Sep 2004 14:58:28 +0200
References: <20040910185553.GU7359@marowsky-bree.de>
	<bssllma/59fU4MzbzTYqnts=lge@web.de>
In-Reply-To: <bssllma/59fU4MzbzTYqnts=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409211458.28093.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> the algorithm within the CRM is
>  res = some replicating resource which no longer sees its peer
>  if res is in master state
>     fence the peer (by marking it outdated or stonithing it)
>     tell res about that, and to continue
>  if res is in passive state
>     trigger immediate monitoring of the peer(s),
>     but otherwise do nothing

Seems that we have exactly the same imagination about this...

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
