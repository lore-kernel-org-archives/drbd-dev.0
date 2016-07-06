Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1A8D41051881
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jul 2016 05:34:27 +0200 (CEST)
Message-Id: <577CED1402000070000948D5@prv-mh.provo.novell.com>
Date: Tue, 05 Jul 2016 21:35:48 -0600
From: "Nick Wang" <nwang@suse.com>
To: "Roland Kammerer" <roland.kammerer@linbit.com>, <drbd-dev@lists.linbit.com>
References: <1467109471-16112-1-git-send-email-nwang@suse.com>
	<20160704093004.GK1324@rck.sh>
In-Reply-To: <20160704093004.GK1324@rck.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Drbd-dev] [PATCH] drbdadm: Fix segfault while starting stacked
 resource in DRBD9
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

Hi Roland,

>>> On 2016-7-4 at 17:30, in message <20160704093004.GK1324@rck.sh>, =
Roland
Kammerer <roland.kammerer@linbit.com> wrote:
> The segfault happens because conn->peer is NULL? It could still be NULL
> with your patch. I need a real/complete configuration and please provide
> more information how and why you think this fixes anything. As is, I can
> not apply this patch, the intention is unclear to me and it looks =
broken.

Sorry for didn't describe clearly, information is list below:
# DRBD version:
drbd: 9.0.1-1 (GIT-hash: 86e443973082570aeb651848db89e0c7b995c306)
drbd-utils: 8.9.6

# Steps to reproduce this issue:
Launch "drbdadm up r0-U" on node "siteB-node1"(can be reproduced as long =
as the peer node is stacked) to start stached resource, segment fault =
happend.

# r0.res=20
resource r0 {
  protocol C;
  device    /dev/drbd2;
  disk      /dev/vdb3;
  meta-disk internal;

  on siteA-node1 {
    address    192.168.122.57:7900;
  }

  on siteA-node2 {
    address    192.168.122.29:7900;
  }
}

resource r0-U {
  protocol A;
  device     /dev/drbd5;

  stacked-on-top-of r0 {
    address    10.0.0.1:7910;
  }

  on siteB-node1 {
    disk       /dev/vdb3;
    address    10.0.0.2:7910; # Public IP of the backup node
    meta-disk  internal;
  }
}

# Coredump file:
#0  0x000000000040c547 in adm_new_peer (ctx=3D<optimized out>) at =
drbdadm_main.c:1617
1617		argv[NA(argc)] =3D ssprintf("%s", conn->peer->node_id);
(gdb) bt
#0  0x000000000040c547 in adm_new_peer (ctx=3D<optimized out>) at =
drbdadm_main.c:1617
#1  0x000000000040ba23 in __call_cmd_fn (ctx=3Dctx@entry=3D0x2478800, =
on_error=3Don_error@entry=3DKEEP_RUNNING) at drbdadm_main.c:607
#2  0x000000000040e078 in _run_deferred_cmds (stage=3Dstage@entry=3DCFG_NET=
_PREP_UP) at drbdadm_main.c:722
#3  0x000000000040e15f in run_deferred_cmds () at drbdadm_main.c:758
#4  0x0000000000403368 in main (argc=3D3, argv=3D0x7ffdc0b4dcc8) at =
drbdadm_main.c:3339
(gdb) p *conn
$3 =3D {name =3D 0x0, paths =3D {stqh_first =3D 0x2478550, stqh_last =3D =
0x2478598}, config_line =3D 0, peer_devices =3D {stqh_first =3D 0x2473750,=
=20
    stqh_last =3D 0x2473780}, peer =3D 0x0, net_options =3D {stqh_first =
=3D 0x2478790, stqh_last =3D 0x2478790}, pd_options =3D {stqh_first =3D =
0x0,=20
    stqh_last =3D 0x2478528}, ignore =3D 0, ignore_tmp =3D 0, implicit =3D =
1, is_standalone =3D 0, link =3D {stqe_next =3D 0x0}}

The conn->peer was set to 0x0, which cause this segment fault.

# Debug:
In create_implicit_connections() of post_parse, the name of struct =
hostname address for stacked peer is a fakename, which is concatenated by =
the lower nodes, in this case is "siteA-node1_siteA-node2". However, in =
set_peer_in_connection(), no matter stacked peer or not hostinfo is =
finding by compare to the on_hosts list, but "siteA-node1_siteA-node2" is =
not in this list. Result in fail to find the corresponding peer,so =
conn->peer is set to NULL.

The patch sent in last thread " [PATCH] drbdadm: Fix segfault while =
starting stacked resource in DRBD9" only change the behavior of finding =
host info of stacked peer. I tested against regular/stacked resource, the =
network connection can be find and establish successfully after apply the =
patch.

Best regards,
Nick

