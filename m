Return-Path: <tvb@able.be>
Received: from mail.able.be (gwb.able.be [194.78.97.254])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 0437B1055F44
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2013 15:46:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by gw-master.mechelen.vasco.com (Postfix) with ESMTP id 0CCB017F49
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2013 15:24:31 +0100 (CET)
Received: from itsj.localnet (tvb.mechelen.vasco.com [10.32.64.113])
	by gw-master.mechelen.vasco.com (Postfix) with ESMTP id D55B617F20
	for <drbd-dev@lists.linbit.com>; Wed,  6 Mar 2013 15:24:30 +0100 (CET)
From: Tijs Van Buggenhout <tvb@able.be>
To: drbd-dev@lists.linbit.com
Date: Wed, 06 Mar 2013 15:24:36 +0100
Message-ID: <1963827.4HPAHhzfUk@itsj>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Drbd-dev] DRBD 8.4.3 : create-md possibly broken for fixed sized
	(shared) meta devices
Reply-To: Tijs Van Buggenhout <tvb@able.be>
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

Hi,

I recently installed drbd 8.4.3 packages and ran into problems when trying to 
create a drbd resource using fixed size drbd meta device ided by an index. 
Investigating further, it seems that when using a flexible meta disk, there is 
no problem whatsoever.
I also used the same configuration file/set of commands on the previous 
version (8.4.2) for fixed size meta-disk, which worked without problems.

The following excerpt from the console log shows how I first create a drbd 
resource (drbd0) with flexible meta disk (/dev/lv/drbd-meta-84). Afterwards I 
undo the configuration, and try to do the same for fixed drbd meta disk, which 
fails (every time). Then I roll back to the previous version of drbd 
utils/module, and try the setup with fixed drbd meta disk again, which 
succeeds.

(master.domain.com):~# lvdisplay lv
  --- Logical volume ---
  LV Path                /dev/lv/data
  LV Name                data
  VG Name                lv
  LV UUID                A1WAT3-uWDN-6ch5-BCnc-KTyJ-7ZiT-FdKhDZ
  LV Write Access        read/write
  LV Creation host, time master.domain.com, 2013-03-07 01:18:00 +0100
  LV Status              available
  # open                 0
  LV Size                512.00 MiB
  Current LE             128
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0
   
  --- Logical volume ---
  LV Path                /dev/lv/drbd-meta-84
  LV Name                drbd-meta-84
  VG Name                lv
  LV UUID                6fW32r-94t8-G8vZ-I0ME-ElJi-LeWC-u4Hdik
  LV Write Access        read/write
  LV Creation host, time master.domain.com, 2013-03-07 01:18:35 +0100
  LV Status              available
  # open                 0
  LV Size                128.00 MiB
  Current LE             32
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1
   
(master.domain.com):~# cat /etc/drbd.conf 
#
# drbd.conf (generated, do not modify)
#

global {
        # minor-count 32;
        # dialog-refresh 5; # 5 seconds
        # disable-ip-verification;

        # Participate in DRBD's online usage counter at http://usage.drbd.org
        usage-count no;
}

common {
        disk { resync-rate 10M; }
}

resource drbd0 {
        protocol C;

        handlers {
                # pri-on-incon-degr "echo o > /proc/sysrq-trigger; halt -f";
                # pri-lost-after-sb "echo o > /proc/sysrq-trigger; halt -f";
                # local-io-error "echo o > /proc/sysrq-trigger; halt -f";
        }

        startup {
                # wfc-timeout  0;
                # degr-wfc-timeout 60;
                # outdated-wfc-timeout 0;
                # wait-after-sb no;
                # stacked-timeouts no;
                # become-primary-on master.domain.com;
        }

        disk {
                fencing dont-care;
                on-io-error detach;
                al-extents 1237;
                al-updates yes;
                resync-rate 700K;
        }

        net {
                after-sb-0pri discard-younger-primary;
                after-sb-1pri consensus;
                after-sb-2pri disconnect;
                rr-conflict disconnect;
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.179:7788;
                flexible-meta-disk /dev/lv/drbd-meta-84;
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.180:7788;
                flexible-meta-disk /dev/lv/drbd-meta-84;
        }
}
(master.domain.com):~# dd if=/dev/zero of=/dev/lv/drbd-meta-84 bs=$[1024*1024] 
count=128
128+0 records in
128+0 records out
134217728 bytes (134 MB) copied, 10.7637 s, 12.5 MB/s
(master.domain.com):~# modprobe drbd
(master.domain.com):~# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
2013-03-05 15:10:01
(master.domain.com):~# drbdsetup new-resource drbd0
(master.domain.com):~# drbdsetup new-minor drbd0 /dev/drbd0 0
(master.domain.com):~# drbdadm create-md drbd0 -vvvvvvvvvv
drbdmeta 0 v08 /dev/lv/drbd-meta-84 flex-external create-md 
Writing meta data...
initializing activity log
NOT initializing bitmap
New drbd meta data block successfully created.
drbdmeta 0 v08 /dev/lv/drbd-meta-84 flex-external write-dev-uuid 
000000000000000D
(master.domain.com):~# drbdmeta /dev/drbd0 v08 /dev/lv/drbd-meta-84 0 dump-md 
-vvvvvvvvvv
hard_sect_size is 512 Byte
 v08_md_disk_to_cpu        : pread(4, ...,  4096,           0)
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 04  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0d  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 80 83 74 02 6b  |.............t.k|
00000040  00 04 00 00 00 00 00 08  00 00 01 01 00 00 00 48  |...............H|
00000050  00 00 10 00 00 00 00 00  00 00 00 01 00 00 00 08  |................|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000ff0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00001000
# DRBD meta data dump
# 2013-03-07 07:17:01 +0100 [1362637021]
# master.domain.com> drbdmeta -vvvvvvvvvv /dev/drbd0 v08 /dev/lv/drbd-meta-84 
0 dump-md
#

version "v08";

# md_size_sect 262144
# md_offset 0
# al_offset 4096
# bm_offset 36864

uuid {
    0x0000000000000004; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
    flags 0x00000080;
}
# al-extents 257;
la-size-sect 0;
bm-byte-per-bit 4096;
device-uuid 0x000000000000000D;
la-peer-max-bio-size 0;
# bm-bytes 0;
bm {
}
# bits-set 0;
# al {
 printf_al                 : pread(4, ..., 32768,        4096)
#     block  0 { INITIALIZED }
#     block  1 { INITIALIZED }
#     block  2 { INITIALIZED }
#     block  3 { INITIALIZED }
#     block  4 { INITIALIZED }
#     block  5 { INITIALIZED }
#     block  6 { INITIALIZED }
#     block  7 { INITIALIZED }
# }
(master.domain.com):~# drbdadm attach drbd0
(master.domain.com):~# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
2013-03-05 15:10:01
 0: cs:StandAlone ro:Secondary/Unknown ds:Inconsistent/DUnknown   r-----
    ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:524160
(master.domain.com):~# drbdadm detach drbd0
(master.domain.com):~# drbdadm down drbd0
(master.domain.com):~# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
2013-03-05 15:10:01
(master.domain.com):~# rmmod drbd
(master.domain.com):~# cat /etc/drbd.conf 
#
# drbd.conf (generated, do not modify)
#

global {
        # minor-count 32;
        # dialog-refresh 5; # 5 seconds
        # disable-ip-verification;

        # Participate in DRBD's online usage counter at http://usage.drbd.org
        usage-count no;
}

common {
        disk { resync-rate 10M; }
}

resource drbd0 {
        protocol C;

        handlers {
                # pri-on-incon-degr "echo o > /proc/sysrq-trigger; halt -f";
                # pri-lost-after-sb "echo o > /proc/sysrq-trigger; halt -f";
                # local-io-error "echo o > /proc/sysrq-trigger; halt -f";
        }

        startup {
                # wfc-timeout  0;
                # degr-wfc-timeout 60;
                # outdated-wfc-timeout 0;
                # wait-after-sb no;
                # stacked-timeouts no;
                # become-primary-on master.domain.com;
        }

        disk {
                fencing dont-care;
                on-io-error detach;
                al-extents 1237;
                al-updates yes;
                resync-rate 700K;
        }

        net {
                after-sb-0pri discard-younger-primary;
                after-sb-1pri consensus;
                after-sb-2pri disconnect;
                rr-conflict disconnect;
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.179:7788;
                meta-disk /dev/lv/drbd-meta-84 [0];
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.180:7788;
                meta-disk /dev/lv/drbd-meta-84 [0];
        }
}
(master.domain.com):~# dd if=/dev/zero of=/dev/lv/drbd-meta-84 bs=$[1024*1024] 
count=128
128+0 records in
128+0 records out
134217728 bytes (134 MB) copied, 10.6723 s, 12.6 MB/s
(master.domain.com):~# modprobe drbd
(master.domain.com):~# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
2013-03-05 15:10:01
(master.domain.com):~# drbdsetup new-resource drbd0
(master.domain.com):~# drbdsetup new-minor drbd0 /dev/drbd0 0
(master.domain.com):~# drbdadm create-md drbd0 -vvvvvvvvvv
drbdmeta 0 v08 /dev/lv/drbd-meta-84 0 create-md 
Writing meta data...
initializing activity log
NOT initializing bitmap
New drbd meta data block successfully created.
drbdmeta 0 v08 /dev/lv/drbd-meta-84 0 write-dev-uuid 000000000000000D 
(master.domain.com):~# drbdmeta /dev/drbd0 v08 /dev/lv/drbd-meta-84 0 dump-md 
-vvvvvvvvvv
hard_sect_size is 512 Byte
 v08_md_disk_to_cpu        : pread(4, ...,  4096,           0)
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 04  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0d  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 80 83 74 02 6b  |.............t.k|
00000040  00 04 00 00 00 00 00 08  00 00 01 01 00 00 00 48  |...............H|
00000050  00 00 10 00 00 00 00 00  00 00 00 01 00 00 00 08  |................|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000ff0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00001000
# DRBD meta data dump
# 2013-03-07 07:22:35 +0100 [1362637355]
# master.domain.com> drbdmeta -vvvvvvvvvv /dev/drbd0 v08 /dev/lv/drbd-meta-84 
0 dump-md
#

version "v08";

# md_size_sect 262144
# md_offset 0
# al_offset 4096
# bm_offset 36864

uuid {
    0x0000000000000004; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
    flags 0x00000080;
}
# al-extents 257;
la-size-sect 0;
bm-byte-per-bit 4096;
device-uuid 0x000000000000000D;
la-peer-max-bio-size 0;
# bm-bytes 0;
bm {
}
# bits-set 0;
# al {
 printf_al                 : pread(4, ..., 32768,        4096)
#     block  0 { INITIALIZED }
#     block  1 { INITIALIZED }
#     block  2 { INITIALIZED }
#     block  3 { INITIALIZED }
#     block  4 { INITIALIZED }
#     block  5 { INITIALIZED }
#     block  6 { INITIALIZED }
#     block  7 { INITIALIZED }
# }
(master.domain.com):~# drbdadm attach drbd0
0: Failure: (119) No valid meta-data signature found.

        ==> Use 'drbdadm create-md res' to initialize meta-data area. <==

Command 'drbdsetup attach 0 /dev/lv/data /dev/lv/drbd-meta-84 0 --resync-
rate=700K --al-updates=yes --al-extents=1237 --on-io-error=detach --
fencing=dont-care' terminated with exit code 10
(master.domain.com):~# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
GIT-hash: 89a294209144b68adb3ee85a73221f964d3ee515 build by root@build, 
2013-03-05 15:10:01
 0: cs:Unconfigured
(master.domain.com):~# drbdadm down drbd0
(master.domain.com):~# rmmod drbd
.... reinstall drbd 8.4.2 modules/tools ...
(master.domain.com):~# dd if=/dev/zero of=/dev/lv/drbd-meta-84 bs=$[1024*1024] 
count=128
128+0 records in
128+0 records out
134217728 bytes (134 MB) copied, 10.7561 s, 12.5 MB/s
(master.domain.com):~# depmod -a
(master.domain.com):~# modprobe drbd
(master.domain.com):~# cat /proc/drbd 
version: 8.4.2 (api:1/proto:86-101)
GIT-hash: 7ad5f850d711223713d6dcadc3dd48860321070c build by root@build, 
2013-03-06 10:15:58
(master.domain.com):~# cat /etc/drbd.conf 
#
# drbd.conf (generated, do not modify)
#

global {
        # minor-count 32;
        # dialog-refresh 5; # 5 seconds
        # disable-ip-verification;

        # Participate in DRBD's online usage counter at http://usage.drbd.org
        usage-count no;
}

common {
        disk { resync-rate 10M; }
}

resource drbd0 {
        protocol C;

        handlers {
                # pri-on-incon-degr "echo o > /proc/sysrq-trigger; halt -f";
                # pri-lost-after-sb "echo o > /proc/sysrq-trigger; halt -f";
                # local-io-error "echo o > /proc/sysrq-trigger; halt -f";
        }

        startup {
                # wfc-timeout  0;
                # degr-wfc-timeout 60;
                # outdated-wfc-timeout 0;
                # wait-after-sb no;
                # stacked-timeouts no;
                # become-primary-on master.domain.com;
        }

        disk {
                fencing dont-care;
                on-io-error detach;
                al-extents 1237;
                #al-updates yes;
                resync-rate 700K;
        }

        net {
                after-sb-0pri discard-younger-primary;
                after-sb-1pri consensus;
                after-sb-2pri disconnect;
                rr-conflict disconnect;
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.179:7788;
                meta-disk /dev/lv/drbd-meta-84 [0];
        }

        on master.domain.com {
                device /dev/drbd0;
                disk /dev/lv/data;
                address 172.16.1.180:7788;
                meta-disk /dev/lv/drbd-meta-84 [0];
        }
}
(master.domain.com):~# drbdsetup new-resource drbd0
(master.domain.com):~# drbdsetup new-minor drbd0 /dev/drbd0 0
(master.domain.com):~# drbdadm create-md drbd0 -vvvvvvvvvv
drbdmeta 0 v08 /dev/lv/drbd-meta-84 0 create-md 
Writing meta data...
initializing activity log
NOT initializing bitmap
New drbd meta data block successfully created.
drbdmeta 0 v08 /dev/lv/drbd-meta-84 0 write-dev-uuid 000000000000000D 
(master.domain.com):~# drbdmeta /dev/drbd0 v08 /dev/lv/drbd-meta-84 0 dump-md 
-vvvvvvvvvv
hard_sect_size is 512 Byte
 v08_md_disk_to_cpu        : pread(4, ...,  4096,           0)
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 04  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 0d  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 83 74 02 6b  |.............t.k|
00000040  00 04 00 00 00 00 00 08  00 00 01 01 00 00 00 48  |...............H|
00000050  00 00 10 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000ff0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00001000
# DRBD meta data dump
# 2013-03-07 07:32:58 +0100 [1362637978]
# master.domain.com> drbdmeta -vvvvvvvvvv /dev/drbd0 v08 /dev/lv/drbd-meta-84 
0 dump-md
#

version "v08";

# md_size_sect 262144
# md_offset 0
# al_offset 4096
# bm_offset 36864

uuid {
    0x0000000000000004; 0x0000000000000000; 0x0000000000000000; 
0x0000000000000000;
    flags 0x00000000;
}
# al-extents 257;
la-size-sect 0;
bm-byte-per-bit 4096;
device-uuid 0x000000000000000D;
la-peer-max-bio-size 0;
# bm-bytes 0;
bm {
}
# bits-set 0;
# al {
 printf_al                 : pread(4, ..., 32768,        4096)
#     block  0 { INITIALIZED }
#     block  1 { INITIALIZED }
#     block  2 { INITIALIZED }
#     block  3 { INITIALIZED }
#     block  4 { INITIALIZED }
#     block  5 { INITIALIZED }
#     block  6 { INITIALIZED }
#     block  7 { INITIALIZED }
# }
(master.domain.com):~# drbdadm attach drbd0
(master.domain.com):~# cat /proc/drbd 
version: 8.4.2 (api:1/proto:86-101)
GIT-hash: 7ad5f850d711223713d6dcadc3dd48860321070c build by root@build, 
2013-03-06 10:15:58
 0: cs:StandAlone ro:Secondary/Unknown ds:Inconsistent/DUnknown   r-----
    ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:524160
(master.domain.com):~# drbdadm detach drbd0
(master.domain.com):~# drbdadm down drbd0
(master.domain.com):~# rmmod drbd

Am I doing something wrong, or did I misconfigure drbd, such that the setup of 
a drbd resource with fixed size meta disk fails in version 8.4.3, or can this 
be some kind of regression problem/bug?

Best regards,
Tijs
