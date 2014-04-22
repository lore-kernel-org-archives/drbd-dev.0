Return-Path: <ls@numerigraphe.com>
Received: from chr.numerigraphe.com (chr.numerigraphe.com [91.121.34.38])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7BB91101AC75
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 14:05:39 +0200 (CEST)
Received: from localhost.localdomain (ovh3 [5.135.35.94])
	by chr.numerigraphe.com (Postfix) with ESMTP id 3D21719600D8
	for <drbd-dev@lists.linbit.com>; Tue, 22 Apr 2014 13:56:17 +0200 (CEST)
Message-ID: <535658E0.7060409@numerigraphe.com>
Date: Tue, 22 Apr 2014 13:56:16 +0200
From: Lionel Sausin <ls@numerigraphe.com>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative;
	boundary="------------000501040208060505090203"
Subject: [Drbd-dev] drbdsetup legacy utils can't fall back to version 8.3
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

This is a multi-part message in MIME format.
--------------000501040208060505090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear DRBD developers,

Ubuntu 12.04 has several kernel users can choose from, some with DRBD 
8.3 and others with 8.4.
To address this, they have just deployed the drbd utils v8.4.3 with 
"--with-legacy_utils".
This works fine for drbdadm but drbdsetup seems to not revert to the 
legacy version, even though drbdsetup is built and deployed to 
/lib/drbd/drbdsetup-83:
     # /sbin/drbdsetup show 1
     Could not connect to 'drbd' generic netlink family

     # /lib/drbd/drbdsetup-83 show 1
     disk {
         size                0s _is_default; # bytes
     ...
     }

 From my (quick) reading of the source code, drbdadmin works because it 
adds /lib/drbd to the path using add_lib_drbd_to_path(), and drbdsetup 
seems not to.
Is the correct fix to add a symlink from /lib/drbd/drbdsetup-83 to 
/sbin, or should drbdsetup be patched to search in /lib/drbd too?

Thanks in advance,
Lionel Sausin.

--------------000501040208060505090203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Dear DRBD developers,<br>
    <br>
    Ubuntu 12.04 has several kernel users can choose from, some with
    DRBD 8.3 and others with 8.4.<br>
    To address this, they have just deployed the drbd utils v8.4.3 with
    "--with-legacy_utils".<br>
    This works fine for drbdadm but drbdsetup seems to not revert to the
    legacy version, even though drbdsetup is built and deployed to
    /lib/drbd/drbdsetup-83:<br>
    &nbsp;&nbsp;&nbsp; # /sbin/drbdsetup show 1<br>
    &nbsp;&nbsp;&nbsp; Could not connect to 'drbd' generic netlink family<br>
    <br>
    &nbsp;&nbsp;&nbsp; # /lib/drbd/drbdsetup-83 show 1<br>
    &nbsp;&nbsp;&nbsp; disk {<br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0s _is_default; # bytes<br>
    &nbsp;&nbsp;&nbsp; ...<br>
    &nbsp;&nbsp;&nbsp; }<br>
    <div class="boardCommentBody">
      <div class="comment-text" itemprop="commentText">
        <p>From my (quick) reading of the source code, drbdadmin works
          because it adds /lib/drbd to the path using add_lib_<wbr>drbd_to_<wbr>path(),
          and drbdsetup seems not to.<br>
          Is the correct fix to add a symlink from /lib/drbd/<wbr>drbdsetup-<wbr>83
          to /sbin, or should drbdsetup be patched to search in
          /lib/drbd too?</p>
      </div>
    </div>
    Thanks in advance,<br>
    Lionel Sausin.<br>
  </body>
</html>

--------------000501040208060505090203--
