Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Iustin Pop <iustin@google.com>
Subject: Re: [Drbd-dev] Another small patch for guess_dev_name in
	user/drbdsetup.c (0.7 branch)
Date: Fri, 16 Feb 2007 12:28:23 +0100
References: <20070109093747.GC1756@google.com>
In-Reply-To: <20070109093747.GC1756@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161228.23769.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 9. Januar 2007 10:37 schrieb Iustin Pop:
> Hi,
>
> guess_dev_name can exit early if the major/minor pair passed in is 0,0
> as this is not a real device so we won't find it in /dev. This skips
> recursing over /dev and stat-ing every file.
>

Hi Iustin,

Finally your patches found their way to SVN ;)

http://lists.linbit.com/pipermail/drbd-cvs/2007-February/001466.html

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
