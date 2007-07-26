Return-Path: <lars@linbit.com>
Date: Thu, 26 Jul 2007 11:38:17 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Noah Watkins <nwatkins@ittc.ku.edu>
Message-ID: <20070726093817.GA4842@mail.linbit.com>
References: <20070725224946.GA3373@ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725224946.GA3373@ittc.ku.edu>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: git/svn development process
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jul 25, 2007 at 05:49:46PM -0500, Noah Watkins wrote:
> I was interested in your development process now that you have expressed
> an interest in pushing your code into mainline. Should people wanting to
> contribute be working off of the SVN trunk, or the GIT tree which was
> posted on LKML?

so, I guess, you have something specific in mind
that you would like to contribute?

for small things right now, it would be ok to
base it on svn, and probably easier on the contributors side,
because I guess, even though few if any feature changes are expected,
the source layout of the git tree will change a lot before inclusion,
causing your patches to not apply.

for me, it would of course be nice if you'd do the extra work to
make your patches apply, and submit against the git tree.

to make things easier on both ends,
I try to fold back any changes neccessary for kernel.org inclusion
onto the drbd/branches/drbd-8.1 branch.

any future development will likely be based on that branch,
read this will become drbd "trunk" soonish.

so for now, as a potential contributor to drbd,
your best way to proceed is to base your work on that svn brach. 

it has the same "problem" now, that I expect the source code layout to
change a lot, still, though most whitespace fixes have been done
already. it has the additional benefit over the git repository, that
there we will keeps backwards compatibility with older kernels
(back to the 2.6.5 derived SLES9, or 2.6.9 derived RHEL 4).

thanks,

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
