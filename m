Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Thu, 19 Mar 2009 13:38:32 +0100
References: <20090312131445.E5AD3100EBE6@mail09.linbit.com>
In-Reply-To: <20090312131445.E5AD3100EBE6@mail09.linbit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903191338.32612.philipp.reisner@linbit.com>
Cc: Oliver Daniel <DOLIVER1@qinetiq.com>, Watts Mark <MWATTS@qinetiq.com>
Subject: Re: [Drbd-dev] chkconfig kill priority in init script
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thursday 12 March 2009 14:07:53 Oliver Daniel wrote:
> Hi there,
>
> I've just noticed a problem with the drbd init script in git and the RPM
> in the CentOS extras tree (I know this is quite old).
>
> The kill priority of the chkconfig parameters (345 70 8) is not
> recognised by the chkconfig that ships with RHEL 5.  This results in
> drbd script being created as K00drdb in rc0.d and rc6.d, causing it to
> be run before heartbeat, whose default is K05.
>
> If the chkconfig parameters are changed to "345 70 08", everything works
> as expected.  I haven't checked the very latest source for chkconfig,
> but I think it is very unlikely to cause a problem.
>
> Thanks,
> Dan.

Finally the commit,

http://git.drbd.org/?p=drbd-8.0.git;a=commitdiff;h=9fd9fd38e12d0f7bbbed5d59af7e0ad7c98b2242

Thanks,
  Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

