Return-Path: <dirk@systemication.com>
Received: from mo4-p05-ob.smtp.rzone.de (mo4-p05-ob.smtp.rzone.de
	[81.169.146.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 48BF31028A4C
	for <drbd-dev@lists.linbit.com>; Sun, 16 Nov 2014 15:41:45 +0100 (CET)
Received: from miriup.de ([86.99.54.140])
	by smtp.strato.de (RZmta 35.11 DYNA|AUTH)
	with ESMTPSA id Z036a1qAGEZvDxc
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
	(Client did not present a certificate)
	for <drbd-dev@lists.linbit.com>;
	Sun, 16 Nov 2014 15:35:57 +0100 (CET)
Date: Sun, 16 Nov 2014 18:35:43 +0400
From: Dirk Tilger <dirk@systemication.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20141116143543.GA26665@miriup.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] [PATCH] Correctly skip interface indexes larger than 256
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

fscanf line probably copied from kernel printf, but printf specifies the
minimal field widwth and scanf the maximal field width.

printf (3) manual:

> Each conversion specification is introduced by the character %, and ends with
> a conversion specifier. In between there may be (in this order) zero or more
> flags, an optional minimum field width, an optional precision and an optional
> length modifier.

fscanf manual:

> Each conversion specification in format begins with either the character '%'
> or the character sequence "%n$" (see below for the distinction) followed by:
>
> * An optional '*' assignment-suppression character: scanf() reads input as
>   directed by the conversion specification, but discards the input. No
>   corresponding pointer argument is required, and this specification is not
>   included in the count of successful assignments returned by scanf().

[...]

> * An optional decimal integer which specifies the maximum field width.
>   Reading of characters stops either when this maximum is reached or when a
>   nonmatching character is found, whichever happens first. Most conversions
>   discard initial white space characters (the exceptions are noted below),
>   and these discarded characters don't count toward the maximum field width.
>   String input conversions store a terminating null byte ('\0') to mark the
>   end of the input; the maximum field width does not include this terminator.
---
 user/shared/shared_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/user/shared/shared_main.c b/user/shared/shared_main.c
index 8dec945..44a3d54 100644
--- a/user/shared/shared_main.c
+++ b/user/shared/shared_main.c
@@ -186,7 +186,7 @@ int have_ip_ipv6(const char *ip)
 
 	while (fscanf
 	       (if_inet6,
-		X32(08) X32(08) X32(08) X32(08) " %*02x %*02x %*02x %*02x %s",
+		X32(08) X32(08) X32(08) X32(08) " %*x %*x %*x %*x %s",
 		b, b + 1, b + 2, b + 3, name) > 0) {
 		for (i = 0; i < 4; i++)
 			addr6.s6_addr32[i] = cpu_to_be32(b[i]);
-- 
1.9.1
