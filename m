Return-Path: <lars@linbit.com>
Date: Mon, 30 May 2005 19:15:50 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Cyril Bouthors <cyb@debian.org>
Subject: Re: [Drbd-dev] [Igor Genibel] Bug#310993: reproductible segfault when
	parsing the config file
Message-ID: <20050530171550.GA5280@nudl>
References: <87oeatrume.fsf@wide.bouthors.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oeatrume.fsf@wide.bouthors.org>
Cc: Igor Genibel <igor@jexiste.org>, drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, May 30, 2005 at 11:22:17AM +0300, Cyril Bouthors wrote:
> Igor has found a bug in 0.7.10. drbdadm fails when the config file is
> bigger than 4798 bytes, which is the default:
> 
> root@wide:~# drbdadm -d adjust all
> Segmentation fault
> root@wide:~# ls -lh /etc/drbd.conf
> -rw-r--r--  1 root root 11K 2005-05-30 11:18 /etc/drbd.conf
> root@wide:~#
> 
> I've marked this Debian bug as "forwarded to upstream".  Please notice
> me when it's fixed.

thanks for the heads up,
quoting from a recent commit message:

* fixed flex input buffer overflow:
  drbdadm_scanner.fl produced tokens of arbitrary length due to excessive use
  of "+" and "*" modifiers. Now these are replaced with "{x,y}" modifiers, so
  it should no longer segfault.
  Though it may now produce parse errors where it suceeded before, if you
  happen to use 90 character long resource names or the like.


drbd-0.7.11 is about to be officially released within the next two days.
(unless we find some other stopper bug).

cheers,

: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
