Return-Path: <Ernest.Montrose@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 1 Dec 2006 09:17:36 -0500
Message-ID: <BD7042533C2F8943A6A4257A9E31C45439C852@EXNA.corp.stratus.com>
From: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD8: drbdadm can't stat drbdsetup/drbdmeta
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,
Looks like a bug was introduced where unless drbdadm is invoqued with
the full path, it complains this way:
"stat() of drbdsetup/drbmeta failed: no such file or directory."
I am not sure why we don't just let the exec fail instead of verifying
ahead.

See sanity_check_cmd() and sanity_check_perm() in user/drbdadm_main.c.

Thanks

EM--
