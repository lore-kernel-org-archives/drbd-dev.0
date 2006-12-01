Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda.linbit (unknown [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 11D2D2D9E1E5
	for <drbd-dev@lists.linbit.com>; Fri,  1 Dec 2006 19:36:31 +0100 (CET)
Date: Fri, 1 Dec 2006 19:36:32 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: drbdadm can't stat drbdsetup/drbdmeta
Message-ID: <20061201183632.GE7942@soda.linbit>
References: <BD7042533C2F8943A6A4257A9E31C45439C852@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C852@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-01 09:17:36 -0500
\ Montrose, Ernest:
> Hi all,
> Looks like a bug was introduced where unless drbdadm is invoqued with
> the full path, it complains this way:
> "stat() of drbdsetup/drbmeta failed: no such file or directory."
> I am not sure why we don't just let the exec fail instead of verifying
> ahead.
> See sanity_check_cmd() and sanity_check_perm() in user/drbdadm_main.c.

reason is: we want to verify the validity of the configuration.
if you configure an outdate peer handler (and use our heartbeat plugin
implementation dopd), you must have the permissions set like that,
otherwise the configuration won't work as expected.

we probably should add "--check-perms" to both drbdmeta and drbdsetup,
and let drbdadm _call_ them via exec, instead of iterating over $PATH
ourselves...

and I think it should not exit(10) if stat does not work, anyways,
since the other thing is a warning only, too.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
