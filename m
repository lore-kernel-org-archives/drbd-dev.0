Return-Path: <iustin@google.com>
Received: from localhost (artichoke.zrh.corp.google.com [172.30.13.34])
	by mail2.zrh.corp.google.com with ESMTP id l08GQ5cZ024998
	for <drbd-dev@lists.linbit.com>; Mon, 8 Jan 2007 08:26:05 -0800
Date: Mon, 8 Jan 2007 17:26:05 +0100
To: drbd-dev@lists.linbit.com
Message-ID: <20070108162605.GA14463@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
From: iustin@google.com (Iustin Pop)
Subject: [Drbd-dev] wrong check of strncpy return value,
	drbdsetup.c:guess_dev_name (0.7)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

In the 0.7 branch, guess_dev_name in drbdsetup.c can go into an infinite
loop while scanning for block devices.

This can happen because when looking for subdirectories the return value
from snprintf is not checked, and we can (due to truncation) actually
recurse in the same directory, if the total path length of the current
directory is exactly 49 chars (line 1247 in drbdsetup.c). This means
that snprintf will truncate the new component and leave us with the
current directory in the buffer.

I saw this when using udev which has in /dev/.udev/failed links to the
/sys filesystem which contains long paths.

This causes the drbdsetup command to hang forever (if file descriptors
are exhausted, it will go up the stack closing a few descriptors and
then recursing again). Maybe at some point it finishes iterating, but
for practical means it hangs.

Attached patch does three things:
  - fixes this problem
  - fixes another wrong use of sntrcpy return value (check should be >=
    50, not == 49, per sntrpcy man page values greater or equal to size
    show that truncation has happened)
  - changes another verify of this value to skip the current entry if
    too deep, not abort the entire search

Please include this in the 0.7 branch.

Regards,
Iustin Pop

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="snprintf.patch"

Index: user/drbdsetup.c
===================================================================
--- user/drbdsetup.c	(revision 2659)
+++ user/drbdsetup.c	(working copy)
@@ -1226,7 +1226,8 @@
 
   while((dde=readdir(device_dir)))
     {
-      snprintf(dev_name,50,"%s/%s",dir,dde->d_name);
+      if(snprintf(dev_name,50,"%s/%s",dir,dde->d_name)>=50)
+	continue;
       if(stat(dev_name,&sb)) continue;
 
       if(S_ISBLK(sb.st_mode))
@@ -1244,7 +1245,8 @@
 
   while((dde=readdir(device_dir)))
     {
-      snprintf(dev_name,50,"%s/%s",dir,dde->d_name);
+      if(snprintf(dev_name,50,"%s/%s",dir,dde->d_name)>=50)
+	continue;
       if(stat(dev_name,&sb)) continue;
 
       if(!strcmp(dde->d_name,".")) continue;
@@ -1257,11 +1259,8 @@
 	{
 	  char subdir[50];
 
-	  if(snprintf(subdir,50,"%s/%s",dir,dde->d_name)==49)
-	    { /* recursion is too deep */
-	      strcpy(dev_name,"can not guess name");
-	      return dev_name;
-	    }
+	  if(snprintf(subdir,50,"%s/%s",dir,dde->d_name)>=50)
+	    continue;
 
 	  if(guess_dev_name(subdir,major,minor)) return dev_name;
 	}

--M9NhX3UHpAaciwkO--
