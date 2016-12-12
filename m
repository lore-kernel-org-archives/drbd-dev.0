Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0FC2D1056469
	for <drbd-dev@lists.linbit.com>; Mon, 12 Dec 2016 07:32:00 +0100 (CET)
Date: Mon, 12 Dec 2016 07:31:56 +0100
From: Philipp Marek <philipp.marek@linbit.com>
To: "David M. Syzdek" <david.syzdek@acsalaska.net>
Message-ID: <20161212063155.qulxytpx67ywnqe3@cacao.linbit>
References: <B9A4DA4C-C940-46CF-B971-E84C01CA3AEB@acsalaska.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7bttugq4alldsu6t"
Content-Disposition: inline
In-Reply-To: <B9A4DA4C-C940-46CF-B971-E84C01CA3AEB@acsalaska.net>
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-overview misreports volume status if the
 resource contains multiple volumes
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


--7bttugq4alldsu6t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

=20
> The utility =E2=80=9Cdrbd-overview=E2=80=9D does not appear to proper t=
rack the status of=20
> volumes in a multi-volume resource.  The status of the last volume is=20
> displayed as the status for all volumes in a resource.  For example, if=
=20
> a resource has three volumes; volume 0 and volume 1 are inconsistent; a=
nd=20
> volume 2 is UpToDate, then drbd-overview will report all three volumes =
as=20
> UpToDate.
thank you very much for the report; the fix is committed.



--7bttugq4alldsu6t
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-drbd-overview-We-need-to-track-disk-states-per-volum.patch"

From cd731d9a344b0008fef5639673d568f7db895193 Mon Sep 17 00:00:00 2001
From: Philipp Marek <philipp.marek@linbit.com>
Date: Mon, 12 Dec 2016 07:25:00 +0100
Subject: [PATCH] drbd-overview: We need to track disk states per volume.

As reported by David on -user (Thank you!), the drbd-overview output
was wrong if volumes within a resource had different states (eg. one
"UpToDate", the other "Inconsistent").

Fix that by tracking disk state per volume.
---
 scripts/drbd-overview.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/drbd-overview.pl b/scripts/drbd-overview.pl
index c2802a2..22abdf4 100755
--- a/scripts/drbd-overview.pl
+++ b/scripts/drbd-overview.pl
@@ -228,10 +228,11 @@ sub slurp_drbdsetup() {
             my $minor = $f{minor};
             my $vol = $f{volume};
             $later{$res}{vol_minor}{$vol} = $minor;
-            $later{$res}{peers}{dstates}{$HOSTNAME}  = $f{disk};
+            $later{$res}{peers}{dstates}{$vol}{$HOSTNAME} = $f{disk};
         } elsif ($what eq "peer-device") {
             my $n = $f{"conn-name"};
-            $later{$res}{peers}{dstates}{$n} = $f{"peer-disk"};
+            my $vol = $f{volume};
+            $later{$res}{peers}{dstates}{$vol}{$n} = $f{"peer-disk"};
         } else {
             warn("unknown key $what\n");
         }
@@ -259,7 +260,7 @@ sub slurp_drbdsetup() {
 # role with all mixed together
             $v->{role} = shorten_list(\@h_incl, $peers->{states});
 
-            $v->{dstate} = shorten_list(\@h_incl, $peers->{dstates});
+            $v->{dstate} = shorten_list(\@h_incl, $peers->{dstates}{$vol2});
             $v->{conn} = shorten_list(\@h_incl, $peers->{conns});
         }
     }
-- 
2.10.2


--7bttugq4alldsu6t--
