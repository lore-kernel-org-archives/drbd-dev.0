Return-Path: <bwiedemann@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 1CB9F1057FD4
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 14:47:57 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 6BB5AACA7
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2017 12:47:54 +0000 (UTC)
To: drbd-dev@lists.linbit.com
References: <20170718083536.13668-1-bwiedemann@suse.de>
	<20170718091350.16310-1-bwiedemann@suse.de>
	<20170718123532.GD1453@rck.sh>
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Message-ID: <ce35732f-d0c4-cd8d-66f9-e5785d0bdbe2@suse.de>
Date: Tue, 18 Jul 2017 14:47:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170718123532.GD1453@rck.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Drbd-dev] [PATCH] drbd: Allow to override build date (v2)
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


> No. What if setting SOURCE_DATE_EPOCH becomes the default in the future?
> Maybe it already is for some of the distributions we as LINBIT build
> packages for. Sorry for being the spoilsport here, but as it stands I
> only see the potential of breaking the way we want it .

It already _is_ the default for openSUSE Tumbleweed (aka Factory)... but
then the preferred way of finding out which version it is, is using
version numbers and/or git hashes.
Once you can create the same binaries anywhere and anytime, it does not
matter anymore where and when they were created.

If you are that reliant/insistent on this date, we could add another
[ -z "${WANT_DRBD_REPRODUCIBLE_BUILD}" ] ||

that is only explicity set in our .spec file(s) (drbd-utils has the same
issue).

Ciao
Bernhard M.
