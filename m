Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 9FAEF1055706
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2011 11:52:50 +0100 (CET)
Resent-Message-ID: <20111114105249.GC11469@barkeeper1-xen.linbit>
Received: from mail-yx0-f182.google.com (mail-yx0-f182.google.com
	[209.85.213.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 6C56110556A0
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 23:51:48 +0100 (CET)
Received: by yenl11 with SMTP id l11so776290yen.27
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 14:51:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EBF8022.6020202@hastexo.com>
References: <4EBF8022.6020202@hastexo.com>
Date: Mon, 14 Nov 2011 09:51:46 +1100
Message-ID: <CAEDLWG14f=WRw+NQ8gtVAd=Vs0QRgpZxxbxnE06MttCQ5iLGGg@mail.gmail.com>
From: Andrew Beekhof <andrew@beekhof.net>
To: The Pacemaker cluster resource manager <pacemaker@oss.clusterlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: "Robinson, Eric" <eric.robinson@psmnv.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [Pacemaker] crm_attribute --quiet (was Fwd:
 [Linux-HA] Should This Worry Me?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sun, Nov 13, 2011 at 7:30 PM, Florian Haas <florian@hastexo.com> wrote:
> Lars/Andrew,
>
> While Eric is evidently on a DRBD version whose ocf:linbit:drbd does not
> invoke crm_attribute with the flag to suppress logging, I'm mildly
> confused as to what the correct flag actually is. ocf:linbit:drbd (in
> both 8.3 and 8.4) uses "-Q" whereas Pacemaker expects "-q" as of this
> commit:
>
> commit c11ce5e9b0b13ead02b5fc4add928d7e7f95092e
> Author: Andrew Beekhof <andrew@beekhof.net>
> Date: =A0 Tue Sep 22 17:29:38 2009 +0200
>
> =A0 =A0Medium: Tools: Use -q as the short form for --quiet (for consisten=
cy)
>
> =A0 =A0Mercurial revision: 7289e661e4923beee4b7b45bc85592564ccdc438
>
> Should ocf:linbit:drbd be using "-q"?

Correct.  Sorry about that.

>
> Cheers,
> Florian
>
> -------- Original Message --------
> Subject: [Linux-HA] Should This Worry =A0Me?
> Date: Sat, 12 Nov 2011 18:02:51 -0800
> From: Robinson, Eric <eric.robinson@psmnv.com>
> Reply-To: General Linux-HA mailing list <linux-ha@lists.linux-ha.org>
> To: <linux-ha@lists.linux-ha.org>
>
> Should I be concerned that the standby node of a 2-node cluster is
> logging these messages about every 15 seconds? This cluster has been up
> and running apparently fine for a year.
>
> Nov 12 17:53:59 ha05 crm_attribute: [2420]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:54:14 ha05 crm_attribute: [2455]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:54:29 ha05 crm_attribute: [2482]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:54:44 ha05 crm_attribute: [2510]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:54:59 ha05 crm_attribute: [2537]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:55:14 ha05 crm_attribute: [2574]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:55:29 ha05 crm_attribute: [2603]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
> Nov 12 17:55:44 ha05 crm_attribute: [2633]: info: Invoked: crm_attribute
> -N ha05.mycharts.md -n master-p_DRBD:1 -l reboot -v 100
>
> --
> Eric Robinson
>
> _______________________________________________
> Pacemaker mailing list: Pacemaker@oss.clusterlabs.org
> http://oss.clusterlabs.org/mailman/listinfo/pacemaker
>
> Project Home: http://www.clusterlabs.org
> Getting started: http://www.clusterlabs.org/doc/Cluster_from_Scratch.pdf
> Bugs: http://developerbugs.linux-foundation.org/enter_bug.cgi?product=3DP=
acemaker
>
