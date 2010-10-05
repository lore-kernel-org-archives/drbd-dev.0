Return-Path: <lars.ellenberg@linbit.com>
Date: Tue, 5 Oct 2010 21:19:39 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com, drbd-user@lists.linbit.com
Message-ID: <20101005191939.GF4179@barkeeper1-xen.linbit>
References: <4C9DD673.1060403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4C9DD673.1060403@gmail.com>
Subject: Re: [Drbd-dev] DRBD 8.3.7 user/Makefile.in patch
Reply-To: drbd-user@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sat, Sep 25, 2010 at 01:01:07PM +0200, Deftunix wrote:
> Hi all,
> 
> i've found a little problem when installing drbd 8.3.7 from
> source. It installs binary only related to $(DESTDIR) disregarding
> $(sbindir).
> 
> Kind regards,
> 
> 	-- deftunix

I think that has been intentional, as drbdsetup may be necessary early
during boot, we really want it in /sbin, not in /usr/sbin, or
/usr/local/sbin/ or whatever.

If there is a "autofoo configure" variable for /sbin/ equivalent
(as opposed to /usr/sbin/ equivalent), please let me know.


> --- drbd-8.3.7/user/Makefile.in.orig    2010-01-13 17:04:50.000000000 +0100
> +++ drbd-8.3.7/user/Makefile.in         2010-09-25 12:26:17.963038793 +0200
> @@ -98,23 +98,24 @@ distclean: clean
>  
>  install:
>  ifeq ($(WITH_UTILS),yes)
> -       install -d $(DESTDIR)/sbin/
> +       install -d $(DESTDIR)$(sbindir)

...


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
__
please don't Cc me, but send to list   --   I'm subscribed
