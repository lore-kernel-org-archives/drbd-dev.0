Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A57AB2DD0580
	for <drbd-dev@lists.linbit.com>; Tue,  1 Jul 2008 11:58:21 +0200 (CEST)
Date: Tue, 1 Jul 2008 11:58:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] Remove proc_root usage (fixes 2.6.26 build)
Message-ID: <20080701095821.GE20245@soda.linbit>
References: <20080701083440.GA4432@develbox.linuxbox.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080701083440.GA4432@develbox.linuxbox.cz>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Jul 01, 2008 at 10:34:40AM +0200, Nikola Ciprich wrote:
> Hi,
> following patch removes usage of obsolete proc_root by usind NULL instead.
> Please apply

will have to check against "backwards compatibility"
in the old SLES 9 and RHEL 4 kernels first.

but thanks,
will do.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
