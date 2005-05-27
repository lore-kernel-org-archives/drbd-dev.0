Return-Path: <roger.tsang@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2398716873
	for <drbd-dev@lists.linbit.com>; Fri, 27 May 2005 17:11:38 +0200 (CEST)
Received: by rproxy.gmail.com with SMTP id g11so999634rne
	for <drbd-dev@lists.linbit.com>; Fri, 27 May 2005 08:11:38 -0700 (PDT)
Message-ID: <49826335050527081118ad0058@mail.gmail.com>
Date: Fri, 27 May 2005 11:11:37 -0400
From: Roger Tsang <roger.tsang@gmail.com>
To: drbd-dev@lists.linbit.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Drbd-dev] DRBD integration with OpenSSI (code review)
Reply-To: Roger Tsang <roger.tsang@gmail.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

I've managed to maintain the task of DRBD integration with OpenSSI to
provide automatic failover using the cluster manager that comes with
OpenSSI.  Now that I seem to have improved the exiting code to get
DRBD working okay with OpenSSI-1.2.2 release for Fedora Core, I'm
looking for peer review of the integration code by a core DRBD
maintainer or DRBD guru.

I'm sure there's room for improvement.  Please take a look at the
code.  I'd be glad to explain to you how it works with OpenSSI.  My
changes are marked #ifdef CONFIG_CLMS in the sources.

You can checkout openssi/drbd module from our CVS repository
OPENSSI-FC or OPENSSI-DB branch.

# cvs -d:pserver:anonymous@cvs.openssi.org:/cvsroot/ssic-linux login
# cvs -z3 -d:pserver:anonymous@cvs.openssi.org:/cvsroot/ssic-linux co
-r OPENSSI-FC openssi/drbd

FC for Fedora Core. DB for Debian.


Regards,

Roger

OpenSSI clusters for Linux
http://www.openssi.org/
