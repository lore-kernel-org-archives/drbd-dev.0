Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (1Cust91.tnt2.ber2.deu.da.uu.net [149.225.54.91])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id C23581430F
	for <drbd-dev@lists.linbit.com>; Wed,  4 Aug 2004 15:44:45 +0200 (CEST)
Date: Wed, 4 Aug 2004 15:41:47 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd-latest introduces new build dependency on subversion
Message-ID: <s7AE7BdNwDCCDr9OXby4kwI=lge@web.de>
References: <20040804112739.GA4411@marowsky-bree.de> <XAeNNKkfuKjjJkgs/KaQR70=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XAeNNKkfuKjjJkgs/KaQR70=lge@web.de>
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

/ 2004-08-04 14:36:14 +0200
\ Lars Ellenberg:
> / 2004-08-04 13:27:39 +0200
> \ Lars Marowsky-Bree:
> > Is that really necessary just for calling svnversion?
>
> not exactly. if you get the tgz,
> svnversion should never be called,
> I checked that.
> (well, as long as you don't rm drbd_buildtag.c)
>
> if you don't get the tgz, you obviously have svn.
>
> ok?

to be even more exact, drbd_buildtag.c is generated thus:
[ moved lengthy explanation of code you were not concerned about anyways
  to the end of this mail.
  while writing that, I understand that probably mean: ]

the tgz, and therefore the rpm target does not work in and extracted tarball...
since the .filelist depends now on svn...
ok, so I remove the .filelist dependency from the tgz target,
but leave it in for the tarball target
(which is used to create the distribution tarballs)

.filelist is only removed by distclean, so that should work.
I just now did a successfull "make rpm" in a tar xvzf drbd-0.7.1.tgz.

now, does it work for you again?

	Lars Ellenberg


---- 

the other use of svn in our makefiles is here,
and I took the svn-havenots intoconsideration
from the very beginning:


# update of drbd_buildtag.c is forced:
.PHONY: drbd/drbd_buildtag.c
drbd/drbd_buildtag.c:

 I like to call it by name, to here we have a boolean value:
        @is_tarball=`test -e .svn/. && echo false || echo true`;

 whatever goes to stdout from now on goes to drbd_buildtag.c.new

        set -e; exec > $@.new;
        echo -e "/* automatically generated. DO NOT EDIT. */";
        echo -e "const char * drbd_buildtag(void)\n{";                  \

        if $$is_tarball; then
          if ! test -e $@ ; then

can only happen when you rm drbd_buildtag.c; if you did, just:

                echo >&2 "your DRBD source tree is broken. unpack again.";
                exit 1;
          fi;

this is the reason, why I split the string constant
in drbd_buildtag.c into two lines: I just grep the
svn version tag from the previous drbd_buildtag.c:

          grep return $@ ;

so you are expected to never modify the code in a tgz, if you do,
we lose that information ("M" postfix on the svn version).

        else

not $$is_tarball, i.e. .svn/ exists,
generate a new version line, with correct "version:otherversion[MS]" structure:

          echo -ne "\treturn \"SVN Revision: "; svnversion -n .; echo \";
        fi ;
        echo -e "\t\t\" build by $$USER@$$HOSTNAME, `date "+%F %T"`\";\n}";
        mv $@{.new,}

