Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: YAMAGUCHI Masashi <yamagu-m@saturn.dti.ne.jp>
Date: Fri, 28 May 2010 11:13:10 +0200
References: <201005272346.o4RNkutF012753@smtp14.dti.ne.jp>
In-Reply-To: <201005272346.o4RNkutF012753@smtp14.dti.ne.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005281113.10709.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] scripts/notify.sh: Fix event identification
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Freitag, 28. Mai 2010, um 01:46:56 schrieb YAMAGUCHI Masashi:
> Hi,
> 
> "notify.sh" cannot identify the events of "notify-pri-lost.sh" and
> "notify-pri-lost-after-sb.sh" so the mails sent by these scripts are
> treated as "Unspecified DRBD notification".
> 

Thanks for pointing that out, patch goes in.

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
