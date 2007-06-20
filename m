Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbdadm segfaults with incorrect drbd.conf
Date: Wed, 20 Jun 2007 19:32:29 +0200
References: <467956FB.5060507@mvista.com>
In-Reply-To: <467956FB.5060507@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706201932.29361.philipp.reisner@linbit.com>
Cc: Dave Jiang <djiang@mvista.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wednesday 20 June 2007 18:34:03 Dave Jiang wrote:
> It seems that when the resources aren't setup exactly right in drbd.conf
> drbdadm can segfault due to using a pointer that is NULL. Attached is a
> patch that fixes the issue.

Could you provide such an drbd.conf file as well, so that we can see 
the issue, that gets fixed by the patch ?

Thanks!

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
