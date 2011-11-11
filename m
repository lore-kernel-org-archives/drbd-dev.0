Return-Path: <florian@hastexo.com>
Received: from mail-fx0-f54.google.com (mail-fx0-f54.google.com
	[209.85.161.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 7DE5F1055705
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2011 16:26:38 +0100 (CET)
Received: by faar19 with SMTP id r19so7750745faa.27
	for <drbd-dev@lists.linbit.com>; Fri, 11 Nov 2011 07:26:38 -0800 (PST)
Message-ID: <4EBD3EAC.2020803@hastexo.com>
Date: Fri, 11 Nov 2011 16:26:36 +0100
From: Florian Haas <florian@hastexo.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <4EBD3BF7.9020406@hastexo.com>
In-Reply-To: <4EBD3BF7.9020406@hastexo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] User's Guide fix for variable-rate sync;
	missing doc in man pages
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2011-11-11 16:15, Florian Haas wrote:
> Phil/Lars,

Actually, please pull the following two minor changes as well (been
meaning to do this for a while; never got around to doing it):

Florian Haas (2):
      User's Guide: add joint copyright notice for hastexo
      User's Guide: update blog links in "more info" section

 users-guide/drbd-users-guide-docinfo.xml |    4 ++++
 users-guide/more-info.txt                |    7 +++----
 2 files changed, 7 insertions(+), 4 deletions(-)

All available from the same location,
git://github.com/fghaas/drbd-documentation master

Thanks!

Cheers,
Florian
