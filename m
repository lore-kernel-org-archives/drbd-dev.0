Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Date: Wed, 20 Oct 2004 12:39:55 +0200
References: <gt0q2bPC2BjLTdYvoniqOkA=lge@web.de>
	<n/0nVbG2W2wQDG4jMwN41Pc=lge@web.de>
	<NPUp4T3Ya1hNzMAxjFRXf0M=lge@web.de>
In-Reply-To: <NPUp4T3Ya1hNzMAxjFRXf0M=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410201239.55282.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: DRBD IOCTLs nicht 64bit clean...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 18 October 2004 19:19, you wrote:
> / 2004-10-18 18:41:00 +0200
>
> \ Lars Ellenberg:
> > na dann, ran...
> > es ind ja nicht mehr viele.
> > gnaugenommen nur eben dieser.
> > alle anderen benutzen doch sowieso structs, und die sind doch sowieso
> > all u32/u64, oder täusch ich mich da jetzt?
>
> hm.
> eigentlich ist doch ein "int" immer 32 bit gross,
> auch auf einer 64 bit box. interessant sind also nur pointer und longs.
>
> und enums, wenn da der basistyp nicht klar ist.

[...]

You are 100% right:

phil@mescal:~/src/drbd07/testing$ file ./ioctl_structs_sizes
./ioctl_structs_sizes: ELF 32-bit LSB executable, Intel 80386, version 1 
(SYSV), for GNU/Linux 2.2.0, dynamically linked (uses shared libs), not 
stripped
phil@mescal:~/src/drbd07/testing$ ./ioctl_structs_sizes
sizeof(struct disk_config) = 24
sizeof(struct net_config) = 300
sizeof(struct syncer_config) = 20
sizeof(struct ioctl_disk_config) = 28
sizeof(struct ioctl_net_config) = 304
sizeof(struct ioctl_syncer_config) = 24
sizeof(struct ioctl_wait) = 12
sizeof(struct ioctl_get_config) = 428
sum = 1140  DRBD_07_SUM = 1140
OKAY

[root@ra2:/usr/src/drbd-0.7.5/testing]# file ./ioctl_structs_sizes
./ioctl_structs_sizes: ELF 64-bit LSB executable, AMD x86-64, version 1 
(SYSV), dynamically linked (uses shared libs), not stripped
[root@ra2:/usr/src/drbd-0.7.5/testing]# ./ioctl_structs_sizes
sizeof(struct disk_config) = 32
sizeof(struct net_config) = 300
sizeof(struct syncer_config) = 20
sizeof(struct ioctl_disk_config) = 40
sizeof(struct ioctl_net_config) = 304
sizeof(struct ioctl_syncer_config) = 24
sizeof(struct ioctl_wait) = 12
sizeof(struct ioctl_get_config) = 432
sum = 1164  DRBD_07_SUM = 1140
FAILED


Dann alle Structs mit __attribute__((packed)) versehen:

[root@ra2:/usr/src/drbd-0.7.5/testing]# file ./ioctl_structs_sizes
./ioctl_structs_sizes: ELF 64-bit LSB executable, AMD x86-64, version 1 
(SYSV), dynamically linked (uses shared libs), not stripped
[root@ra2:/usr/src/drbd-0.7.5/testing]# ./ioctl_structs_sizes
sizeof(struct disk_config) = 24
sizeof(struct net_config) = 300
sizeof(struct syncer_config) = 20
sizeof(struct ioctl_disk_config) = 28
sizeof(struct ioctl_net_config) = 304
sizeof(struct ioctl_syncer_config) = 24
sizeof(struct ioctl_wait) = 12
sizeof(struct ioctl_get_config) = 428
sum = 1140  DRBD_07_SUM = 1140
OKAY


I have not yet decided if I will do the reordering of the
members as well and increase the API version, 

OR, 

leave the members in this order and no change to the API
version number .... This would be more conventient for our
i386 users, but plain frong for the users of 64bit archs...


-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
