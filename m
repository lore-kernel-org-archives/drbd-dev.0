Return-Path: <Lars.Ellenberg@linbit.com>
Date: Mon, 16 Aug 2004 14:33:05 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-latest introduces new build dependency on subversion
Message-ID: <9qhq83g5lYv4If9aHwSho6c=lge@web.de>
References: <20040804112739.GA4411@marowsky-bree.de> <XAeNNKkfuKjjJkgs/KaQR70=lge@web.de> <s7AE7BdNwDCCDr9OXby4kwI=lge@web.de> <20040816120202.GB21836@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816120202.GB21836@marowsky-bree.de>
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

/ 2004-08-16 14:02:02 +0200
\ Lars Marowsky-Bree:
> On 2004-08-04T15:41:47,
>    Lars Ellenberg <Lars.Ellenberg@linbit.com> said:
> 
> > .filelist is only removed by distclean, so that should work.
> > I just now did a successfull "make rpm" in a tar xvzf drbd-0.7.1.tgz.
> > 
> > now, does it work for you again?
> 
> I don't use make rpm; I our buildsystem gets the source files + a spec
> file to build everything from, but for various reasons build from svn
> sources.
> 
> Now as the drbd specfile also generates the km_drbd package which holds
> the external module which is needed to build the kernel, this means that
> I try to keep the dependency chain short. Introducing subversion meant
> that essentially the kernel got build after subversion->drbd, which
> wasn't good. I've now replaced the call to svnversion with a perl one
> liner to grab it from the .svn/dir-wcprops file. ;)

which is the same only for the special case
of an unmodified svn checkout.

> 
> Maybe I really should generate the source tarball for building using
> make tgz though instead of simply tarring the svn dir up...

if you do so, please use "make tarball".
make tgz lacks some preparation steps...

tarball additionally makes sure that there are no modifications pending,
that the changelogs are up-to-date, that documentation is build (ok, *you*
won't need that in the tarball), the .filelist is regenerated, and then
calls make tgz, which just generates the tgz.

tarring up the .svn working dir should work the same, too.
you'd need to "make drbd/drbd_buildtag.c" before you tar it,
and you apply this patch with the preparation step in your
drbd.spec:


--- Makefile	(revision 1490)
+++ Makefile	(working copy)
@@ -96,7 +96,7 @@
 # update of drbd_buildtag.c is forced:
 .PHONY: drbd/drbd_buildtag.c
 drbd/drbd_buildtag.c:
-	@is_tarball=`test -e .svn/. && echo false || echo true`;		\
+	@is_tarball=true;		\
 	set -e; exec > $@.new;							\
 	echo -e "/* automatically generated. DO NOT EDIT. */";			\
 	echo -e "const char * drbd_buildtag(void)\n{";			\
