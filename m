Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 22 Sep 2008 16:37:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20080922143709.GB9784@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Cc: drbd-user@lists.linbit.com
Subject: [Drbd-dev] whitespace, linebreak,
	typedef and comment patch coming up, I'm going to fold 8.1 into 8.0
Reply-To: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

due to the divergence in whitespace, linebreaks, typedefs and comment
style, it is currently difficult to merge bugfixes from 8.0 up to 8.2,
or cherry-pick them from 8.2 down to 8.0 again.

the drbd branches 8.0 and 8.1 differ only in these aspects,
and I'm going to basically fold 8.1 cleanups into 8.0.
(no functional change at all).
I'm sorry for the noise, but I think it is useful to do that now.

this will probably happen this week.

so if anyone out there has some in-house patches
for the **drbd 8.0** module
(hi Simon and the other Stratus people)
this would be a good time to post them to drbd-dev@lists.linbit.com.
and let me do the work to get them to apply again.

if you wait too long, you have to merge all
resulting "conflicts" yourself.

-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
