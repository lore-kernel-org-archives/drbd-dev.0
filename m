Return-Path: <lmb@suse.de>
Date: Mon, 27 Oct 2008 13:41:06 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20081027124106.GT3192@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] trivial fix for 8.2.x w/git 1.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Attached patch; git 1.6 no longer installs the "git-*" commands.

Regards,
    Lars

-- 
Teamlead Kernel, SuSE Labs, Research and Development
SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde


--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="drbd-8.2.git.diff"

commit 5b6358de919b34287026963ad06257b9da3aca04
Author: Lars Marowsky-Bree <lmb@hermes.in-addr.de>
Date:   Mon Oct 27 13:35:25 2008 +0100

    Work with git 1.6.0 syntax.

diff --git a/Makefile b/Makefile
index b0492d2..8f3cba0 100644
--- a/Makefile
+++ b/Makefile
@@ -42,7 +42,7 @@ ifdef FORCE
 # in the tgz name:
 #   make distclean doc tgz FORCE=1
 #
-REL_VERSION := $(REL_VERSION)-$(shell git-rev-parse HEAD)
+REL_VERSION := $(REL_VERSION)-$(shell git rev-parse HEAD)
 endif
 
 DIST_VERSION := $(REL_VERSION)
@@ -124,7 +124,7 @@ drbd/drbd_buildtag.c:
 # update of .filelist is forced:
 .PHONY: .filelist
 .filelist:
-	@git-ls-files | sed '$(if $(PRESERVE_DEBIAN),,/^debian/d);s#^#drbd-$(DIST_VERSION)/#' > .filelist
+	@git ls-files | sed '$(if $(PRESERVE_DEBIAN),,/^debian/d);s#^#drbd-$(DIST_VERSION)/#' > .filelist
 	@[ -s .filelist ] # assert there is something in .filelist now
 	@find documentation -name "[^.]*.[58]" -o -name "*.html" | \
 	sed "s/^/drbd-$(DIST_VERSION)\//" >> .filelist           ;\
@@ -153,7 +153,7 @@ tgz: check_changelogs_up2date doc
 endif
 
 check_all_committed:
-	@$(if $(FORCE),-,)modified=`git-ls-files -m -t`; 		\
+	@$(if $(FORCE),-,)modified=`git ls-files -m -t`; 		\
 	if test -n "$$modified" ; then	\
 		echo "$$modified";	\
 	       	false;			\
diff --git a/drbd/Makefile b/drbd/Makefile
index fa05d3c..ff1b78e 100644
--- a/drbd/Makefile
+++ b/drbd/Makefile
@@ -111,8 +111,8 @@ else
 	  fi;									\
 	  grep return $@ ;							\
 	else									\
-	  GITHEAD=$$(git-rev-parse HEAD);					\
-	  GITDIFF=$$(cd .. && git-diff --name-only HEAD | tr -s '\t\n' '  ' |	\
+	  GITHEAD=$$(git rev-parse HEAD);					\
+	  GITDIFF=$$(cd .. && git diff --name-only HEAD | tr -s '\t\n' '  ' |	\
 	  	sed -e 's/^/ /;s/ *$$//');					\
 	  echo -e "\treturn \"GIT-hash: $$GITHEAD$$GITDIFF\"";	 		\
 	fi ;									\

--liOOAslEiF7prFVr--
