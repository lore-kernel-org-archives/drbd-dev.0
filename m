Return-Path: <lists@alteeve.ca>
Received: from mail.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A610A1057311
	for <drbd-dev@lists.linbit.com>; Sun,  4 Feb 2018 01:30:55 +0100 (CET)
Received: from pulsar.alteeve.ca (ip-104-193-58-76.user.start.ca
	[104.193.58.76])
	by mail.alteeve.ca (Postfix) with ESMTPSA id A0542E0145
	for <drbd-dev@lists.linbit.com>; Sat,  3 Feb 2018 19:21:13 -0500 (EST)
To: drbd-dev@lists.linbit.com
From: Digimer <lists@alteeve.ca>
Message-ID: <e2b1538d-2bcc-32ec-827a-69813e23390c@alteeve.ca>
Date: Sat, 3 Feb 2018 19:21:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Drbd-dev] drbd-utils won't build with '--without 84support'
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

On 3ce302afa9503ac8982757a93533555a7c0156b5;

rpmbuild -ba --without 84support drbd.spec

(Note also the bad date; Should be either 'Thu 21' or 'Fri 22'.

====
warning: bogus date in %changelog: Fri Dec 21 2017 Roland Kammerer
<roland.kammerer@linbit.com> - 9.2.0-1
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.fnl6W6
+ umask 022
+ cd /home/digimer/rpmbuild/BUILD
+ cd /home/digimer/rpmbuild/BUILD
+ rm -rf drbd-utils-9.2.0
+ /usr/bin/gzip -dc /home/digimer/rpmbuild/SOURCES/drbd-utils-9.2.0.tar.gz
+ /usr/bin/tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd drbd-utils-9.2.0
+ /usr/bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.bd1Qn5
+ umask 022
+ cd /home/digimer/rpmbuild/BUILD
+ cd drbd-utils-9.2.0
+ aclocal
+ autoheader
+ autoconf
+ CFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic'
+ export CFLAGS
+ CXXFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic'
+ export CXXFLAGS
+ FFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -I/usr/lib64/gfortran/modules'
+ export FFLAGS
+ FCFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -I/usr/lib64/gfortran/modules'
+ export FCFLAGS
+ LDFLAGS='-Wl,-z,relro '
+ export LDFLAGS
+ '[' 1 == 1 ']'
+ '[' x86_64 == ppc64le ']'
++ find . -name config.guess -o -name config.sub
+ ./configure --build=x86_64-redhat-linux-gnu
--host=x86_64-redhat-linux-gnu --program-prefix=
--disable-dependency-tracking --prefix=/usr --exec-prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc
--datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64
--libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib
--mandir=/usr/share/man --infodir=/usr/share/info --without-84support
--with-initdir=/etc/rc.d/init.d --with-tmpfilesdir=/usr/lib/tmpfiles.d
--with-initscripttype=systemd
configure: WARNING: unrecognized options: --disable-dependency-tracking
checking for x86_64-redhat-linux-gnu-gcc... no
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for getentropy... no
checking for x86_64-redhat-linux-gnu-pkg-config... no
checking for pkg-config... /bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
Using systemd unit directory: /usr/lib/systemd/system
Using udev rules directory: /usr/lib/udev
checking for x86_64-redhat-linux-gnu-gcc... gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking whether ln -s works... yes
checking for sed... /bin/sed
checking for grep... /bin/grep
checking for flex... /bin/flex
checking for rpmbuild... /bin/rpmbuild
checking for xsltproc... /bin/xsltproc
checking for tar... /bin/tar
checking for git... /bin/git
checking for dpkg-buildpackage... no
checking for udevadm... /sbin/udevadm
checking for udevinfo... false
checking for x86_64-redhat-linux-gnu-g++... no
checking for x86_64-redhat-linux-gnu-c++... no
checking for x86_64-redhat-linux-gnu-gpp... no
checking for x86_64-redhat-linux-gnu-aCC... no
checking for x86_64-redhat-linux-gnu-CC... no
checking for x86_64-redhat-linux-gnu-cxx... no
checking for x86_64-redhat-linux-gnu-cc++... no
checking for x86_64-redhat-linux-gnu-cl.exe... no
checking for x86_64-redhat-linux-gnu-FCC... no
checking for x86_64-redhat-linux-gnu-KCC... no
checking for x86_64-redhat-linux-gnu-RCC... no
checking for x86_64-redhat-linux-gnu-xlC_r... no
checking for x86_64-redhat-linux-gnu-xlC... no
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking whether g++ supports C++11 features by default... no
checking whether g++ supports C++11 features with -std=gnu++11... yes
configure: WARNING: No dpkg-buildpackage found, building Debian packages
is disabled.
checking for /etc/redhat-release... yes
checking for /etc/debian_version... no
checking for /etc/SuSE-release... no
configure: configured for Red Hat (includes Fedora, RHEL, CentOS).
checking for /etc/fedora-release... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating user/shared/Makefile
config.status: creating user/v9/Makefile
config.status: creating user/v83/Makefile
config.status: creating user/v84/Makefile
config.status: creating scripts/Makefile
config.status: creating documentation/v9/Makefile
config.status: creating documentation/v83/Makefile
config.status: creating documentation/v84/Makefile
config.status: creating scripts/drbd.rules
config.status: creating user/drbdmon/Makefile
config.status: creating documentation/ja/v84/Makefile
config.status: creating user/shared/config.h
configure: WARNING: unrecognized options: --disable-dependency-tracking
+ make -j2
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/shared'
flex -s -odrbdmeta_scanner.c drbdmeta_scanner.fl
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/shared'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
flex -s -odrbdadm_scanner.c drbdadm_scanner.fl
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_scanner.o drbdadm_scanner.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_parser.o drbdadm_parser.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_postparse.o drbdadm_postparse.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_main.o drbdadm_main.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_adjust.o drbdadm_adjust.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_dump.o drbdadm_dump.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdtool_common.o drbdtool_common.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdadm_usage_cnt.o drbdadm_usage_cnt.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbd_buildtag.o ../shared/drbd_buildtag.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o registry.o registry.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o config_flags.o config_flags.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-DHAVE_CTRL_ATTR_VERSION -DHAVE_CTRL_ATTR_HDRSIZE
-DHAVE_CTRL_ATTR_MCAST_GROUPS   -c -o libgenl.o ../shared/libgenl.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbd_nla.o drbd_nla.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o shared_tool.o ../shared/shared_tool.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o shared_main.o ../shared/shared_main.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o shared_parser.o ../shared/shared_parser.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdmeta.o ../shared/drbdmeta.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdmeta_scanner.o ../shared/drbdmeta_scanner.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbd_strings.o ../../drbd-headers/drbd_strings.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdsetup.o drbdsetup.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o wrap_printf.o ../shared/wrap_printf.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-c -o drbdsetup_colors.o drbdsetup_colors.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-Wl,-z,relro   -Wl,-z,relro  -o drbdadm drbdadm_scanner.o
drbdadm_parser.o drbdadm_postparse.o drbdadm_main.o drbdadm_adjust.o
drbdadm_dump.o drbdtool_common.o drbdadm_usage_cnt.o drbd_buildtag.o
registry.o config_flags.o libgenl.o drbd_nla.o shared_tool.o
shared_main.o shared_parser.o
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-Wl,-z,relro   -Wl,-z,relro  -o drbdmeta drbdmeta.o drbdmeta_scanner.o
drbdtool_common.o drbd_buildtag.o drbd_strings.o shared_tool.o
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I../../drbd-headers -I.. -I. -I../shared
-Wl,-z,relro   -Wl,-z,relro  -o drbdsetup libgenl.o registry.o
drbdsetup.o drbdtool_common.o drbd_buildtag.o drbd_strings.o
config_flags.o drbd_nla.o wrap_printf.o drbdsetup_colors.o shared_tool.o
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
flex -s -odrbdadm_scanner.c drbdadm_scanner.fl
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
flex -s -odrbdadm_scanner.c drbdadm_scanner.fl
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdadm_scanner.o
drbdadm_scanner.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdadm_parser.o
drbdadm_parser.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdadm_main.o
drbdadm_main.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdadm_adjust.o
drbdadm_adjust.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdtool_common.o
drbdtool_common.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdadm_usage_cnt.o
drbdadm_usage_cnt.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbd_buildtag.o
../shared/drbd_buildtag.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o
drbdadm_minor_table.o drbdadm_minor_table.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o shared_tool.o
../shared/shared_tool.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o shared_main.o
../shared/shared_main.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o shared_parser.o
../shared/shared_parser.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbdsetup.o drbdsetup.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared   -c -o drbd_strings.o
drbd_strings.c
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared  -Wl,-z,relro   -Wl,-z,relro
 -o drbdadm-83 drbdadm_scanner.o drbdadm_parser.o drbdadm_main.o
drbdadm_adjust.o drbdtool_common.o drbdadm_usage_cnt.o drbd_buildtag.o
drbdadm_minor_table.o shared_tool.o shared_main.o shared_parser.o
gcc -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
  -m64 -mtune=generic -Wall -I. -I../shared  -Wl,-z,relro   -Wl,-z,relro
 -o drbdsetup-83 drbdsetup.o drbdtool_common.o drbd_buildtag.o
drbd_strings.o shared_tool.o
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/scripts'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/scripts'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o drbdmon_main.o drbdmon_main.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DrbdMon.o DrbdMon.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o MessageLog.o MessageLog.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o CompactDisplay.o CompactDisplay.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DrbdResource.o DrbdResource.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DrbdRole.o DrbdRole.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DrbdVolume.o DrbdVolume.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DrbdConnection.o DrbdConnection.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o VolumesContainer.o VolumesContainer.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o StateFlags.o StateFlags.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o EventsIo.o EventsIo.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o EventsSourceSpawner.o EventsSourceSpawner.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o Args.o Args.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o ConfigOption.o ConfigOption.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o StringTokenizer.o StringTokenizer.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o comparators.o comparators.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o utils.o utils.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o cppdsaext/src/dsaext.o cppdsaext/src/dsaext.cpp
g++ -std=gnu++11 -std=c++11 -I. -I../shared -Icppdsaext/src -Wall
-Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow   -c -o DebugDisplay.o DebugDisplay.cpp
g++ -std=gnu++11 -o drbdmon  -std=c++11 -I. -I../shared -Icppdsaext/src
-Wall -Werror --pedantic-errors -fPIC -O2 -Wsign-compare -Wpointer-arith
-Wswitch-default -Wswitch-enum -Wtype-limits -Wmissing-declarations
-Wshadow drbdmon_main.o DrbdMon.o MessageLog.o CompactDisplay.o
DrbdResource.o DrbdRole.o DrbdVolume.o DrbdConnection.o
VolumesContainer.o StateFlags.o EventsIo.o EventsSourceSpawner.o Args.o
ConfigOption.o StringTokenizer.o comparators.o utils.o
cppdsaext/src/dsaext.o
g++ -std=gnu++11 -o drbdmon_test  -std=c++11 -I. -I../shared
-Icppdsaext/src -Wall -Werror --pedantic-errors -fPIC -O2 -Wsign-compare
-Wpointer-arith -Wswitch-default -Wswitch-enum -Wtype-limits
-Wmissing-declarations -Wshadow drbdmon_main.o DrbdMon.o MessageLog.o
CompactDisplay.o DrbdResource.o DrbdRole.o DrbdVolume.o DrbdConnection.o
VolumesContainer.o StateFlags.o EventsIo.o EventsSourceSpawner.o Args.o
ConfigOption.o StringTokenizer.o comparators.o utils.o
cppdsaext/src/dsaext.o DebugDisplay.o
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'

	Userland tools build was successful.
make -C documentation/v9 doc
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v9'
/bin/xsltproc -o drbdsetup.xml drbdsetup.xsl drbdsetup.xml.in
make -C ../../user/v9 drbdsetup
make[2]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
make[2]: `drbdsetup' is up to date.
make[2]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
/bin/xsltproc -o drbd.conf.xml drbd.conf.xsl drbd.conf.xml.in
../../user/v9/drbdsetup xml-help new-resource >
drbdsetup_xml-help_new-resource.xml
../../user/v9/drbdsetup xml-help new-minor >
drbdsetup_xml-help_new-minor.xml
../../user/v9/drbdsetup xml-help del-resource >
drbdsetup_xml-help_del-resource.xml
../../user/v9/drbdsetup xml-help del-minor >
drbdsetup_xml-help_del-minor.xml
../../user/v9/drbdsetup xml-help new-peer > drbdsetup_xml-help_new-peer.xml
../../user/v9/drbdsetup xml-help new-path > drbdsetup_xml-help_new-path.xml
../../user/v9/drbdsetup xml-help del-peer > drbdsetup_xml-help_del-peer.xml
../../user/v9/drbdsetup xml-help del-path > drbdsetup_xml-help_del-path.xml
../../user/v9/drbdsetup xml-help attach > drbdsetup_xml-help_attach.xml
../../user/v9/drbdsetup xml-help connect > drbdsetup_xml-help_connect.xml
../../user/v9/drbdsetup xml-help disk-options >
drbdsetup_xml-help_disk-options.xml
../../user/v9/drbdsetup xml-help net-options >
drbdsetup_xml-help_net-options.xml
../../user/v9/drbdsetup xml-help resource-options >
drbdsetup_xml-help_resource-options.xml
../../user/v9/drbdsetup xml-help peer-device-options >
drbdsetup_xml-help_peer-device-options.xml
../../user/v9/drbdsetup xml-help disconnect >
drbdsetup_xml-help_disconnect.xml
../../user/v9/drbdsetup xml-help detach > drbdsetup_xml-help_detach.xml
../../user/v9/drbdsetup xml-help primary > drbdsetup_xml-help_primary.xml
../../user/v9/drbdsetup xml-help secondary >
drbdsetup_xml-help_secondary.xml
../../user/v9/drbdsetup xml-help verify > drbdsetup_xml-help_verify.xml
../../user/v9/drbdsetup xml-help invalidate >
drbdsetup_xml-help_invalidate.xml
../../user/v9/drbdsetup xml-help invalidate-remote >
drbdsetup_xml-help_invalidate-remote.xml
../../user/v9/drbdsetup xml-help down > drbdsetup_xml-help_down.xml
../../user/v9/drbdsetup xml-help role > drbdsetup_xml-help_role.xml
../../user/v9/drbdsetup xml-help cstate > drbdsetup_xml-help_cstate.xml
../../user/v9/drbdsetup xml-help dstate > drbdsetup_xml-help_dstate.xml
../../user/v9/drbdsetup xml-help resize > drbdsetup_xml-help_resize.xml
../../user/v9/drbdsetup xml-help check-resize >
drbdsetup_xml-help_check-resize.xml
../../user/v9/drbdsetup xml-help pause-sync >
drbdsetup_xml-help_pause-sync.xml
../../user/v9/drbdsetup xml-help resume-sync >
drbdsetup_xml-help_resume-sync.xml
../../user/v9/drbdsetup xml-help outdate > drbdsetup_xml-help_outdate.xml
../../user/v9/drbdsetup xml-help show-gi > drbdsetup_xml-help_show-gi.xml
../../user/v9/drbdsetup xml-help get-gi > drbdsetup_xml-help_get-gi.xml
../../user/v9/drbdsetup xml-help show > drbdsetup_xml-help_show.xml
../../user/v9/drbdsetup xml-help events2 > drbdsetup_xml-help_events2.xml
../../user/v9/drbdsetup xml-help status > drbdsetup_xml-help_status.xml
../../user/v9/drbdsetup xml-help suspend-io >
drbdsetup_xml-help_suspend-io.xml
../../user/v9/drbdsetup xml-help resume-io >
drbdsetup_xml-help_resume-io.xml
../../user/v9/drbdsetup xml-help new-current-uuid >
drbdsetup_xml-help_new-current-uuid.xml
../../user/v9/drbdsetup xml-help wait-connect-volume >
drbdsetup_xml-help_wait-connect-volume.xml
../../user/v9/drbdsetup xml-help wait-connect-connection >
drbdsetup_xml-help_wait-connect-connection.xml
../../user/v9/drbdsetup xml-help wait-connect-resource >
drbdsetup_xml-help_wait-connect-resource.xml
../../user/v9/drbdsetup xml-help wait-sync-volume >
drbdsetup_xml-help_wait-sync-volume.xml
../../user/v9/drbdsetup xml-help wait-sync-connection >
drbdsetup_xml-help_wait-sync-connection.xml
../../user/v9/drbdsetup xml-help wait-sync-resource >
drbdsetup_xml-help_wait-sync-resource.xml
../../user/v9/drbdsetup xml-help forget-peer >
drbdsetup_xml-help_forget-peer.xml
/bin/xsltproc \
--xinclude --stringparam variablelist.term.break.after 1 \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbd.conf.xml
/bin/xsltproc -o drbdsetup_new-resource.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_new-resource.xml
/bin/xsltproc -o drbdsetup_new-minor.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_new-minor.xml
/bin/xsltproc -o drbdsetup_del-resource.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_del-resource.xml
/bin/xsltproc -o drbdsetup_del-minor.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_del-minor.xml
/bin/xsltproc -o drbdsetup_new-peer.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_new-peer.xml
/bin/xsltproc -o drbdsetup_new-path.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_new-path.xml
/bin/xsltproc -o drbdsetup_del-peer.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_del-peer.xml
/bin/xsltproc -o drbdsetup_del-path.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_del-path.xml
/bin/xsltproc -o drbdsetup_attach.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_attach.xml
/bin/xsltproc -o drbdsetup_connect.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_connect.xml
/bin/xsltproc -o drbdsetup_disk-options.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_disk-options.xml
/bin/xsltproc -o drbdsetup_net-options.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_net-options.xml
/bin/xsltproc -o drbdsetup_resource-options.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_resource-options.xml
/bin/xsltproc -o drbdsetup_peer-device-options.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_peer-device-options.xml
/bin/xsltproc -o drbdsetup_disconnect.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_disconnect.xml
/bin/xsltproc -o drbdsetup_detach.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_detach.xml
/bin/xsltproc -o drbdsetup_primary.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_primary.xml
/bin/xsltproc -o drbdsetup_secondary.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_secondary.xml
/bin/xsltproc -o drbdsetup_verify.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_verify.xml
/bin/xsltproc -o drbdsetup_invalidate.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_invalidate.xml
/bin/xsltproc -o drbdsetup_invalidate-remote.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_invalidate-remote.xml
/bin/xsltproc -o drbdsetup_down.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_down.xml
/bin/xsltproc -o drbdsetup_role.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_role.xml
/bin/xsltproc -o drbdsetup_cstate.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_cstate.xml
/bin/xsltproc -o drbdsetup_dstate.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_dstate.xml
/bin/xsltproc -o drbdsetup_resize.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_resize.xml
/bin/xsltproc -o drbdsetup_check-resize.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_check-resize.xml
/bin/xsltproc -o drbdsetup_pause-sync.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_pause-sync.xml
/bin/xsltproc -o drbdsetup_resume-sync.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_resume-sync.xml
/bin/xsltproc -o drbdsetup_outdate.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_outdate.xml
/bin/xsltproc -o drbdsetup_show-gi.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_show-gi.xml
/bin/xsltproc -o drbdsetup_get-gi.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_get-gi.xml
/bin/xsltproc -o drbdsetup_show.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_show.xml
/bin/xsltproc -o drbdsetup_events2.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_events2.xml
/bin/xsltproc -o drbdsetup_status.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_status.xml
/bin/xsltproc -o drbdsetup_suspend-io.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_suspend-io.xml
/bin/xsltproc -o drbdsetup_resume-io.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_resume-io.xml
/bin/xsltproc -o drbdsetup_new-current-uuid.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_new-current-uuid.xml
/bin/xsltproc -o drbdsetup_wait-connect-volume.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_wait-connect-volume.xml
/bin/xsltproc -o drbdsetup_wait-connect-connection.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_wait-connect-connection.xml
/bin/xsltproc -o drbdsetup_wait-connect-resource.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_wait-connect-resource.xml
/bin/xsltproc -o drbdsetup_wait-sync-volume.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_wait-sync-volume.xml
/bin/xsltproc -o drbdsetup_wait-sync-connection.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_wait-sync-connection.xml
/bin/xsltproc -o drbdsetup_wait-sync-resource.xml
xml-usage-to-docbook.xsl drbdsetup_xml-help_wait-sync-resource.xml
/bin/xsltproc -o drbdsetup_forget-peer.xml xml-usage-to-docbook.xsl
drbdsetup_xml-help_forget-peer.xml
/bin/xsltproc \
--xinclude --stringparam variablelist.term.break.after 1 \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbdsetup.xml
Note: Writing drbd.conf.5
Note: Writing drbdsetup.8
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v9'
make -C documentation/v83 doc
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v83'
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbdsetup.xml
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbd.conf.xml
Note: Writing drbd.conf.5
Note: Writing drbdsetup.8
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbd.xml
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbdadm.xml
Note: Writing drbd.8
Note: Writing drbdadm.8
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbdmeta.xml
/bin/xsltproc \
--xinclude \
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
drbddisk.xml
Note: Writing drbdmeta.8
Note: Writing drbddisk.8
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v83'
+ exit 0
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.4k78ED
+ umask 022
+ cd /home/digimer/rpmbuild/BUILD
+ '[' /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
'!=' / ']'
+ rm -rf /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
++ dirname /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
+ mkdir -p /home/digimer/rpmbuild/BUILDROOT
+ mkdir /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
+ cd drbd-utils-9.2.0
+ rm -rf /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
+ make install
DESTDIR=/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64
CREATE_MAN_LINK=no
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/shared'
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/shared'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lib/drbd
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lock
if getent group haclient > /dev/null 2> /dev/null ; then	\
	install -g haclient -m 4750 drbdsetup
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin ;	\
	install -g haclient -m 4750 drbdmeta
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin ;	\
	install -m 755 drbdadm
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
;		\
else								\
	install -m 755 drbdsetup
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
;		\
	install -m 755 drbdmeta
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
;		\
	install -m 755 drbdadm
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
;		\
fi
if test -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin && \
 ! test
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin -ef
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
; then		\
	ln -sf /usr/sbin/drbdsetup
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin ;		\
	ln -sf /usr/sbin/drbdmeta
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin ;		\
	ln -sf /usr/sbin/drbdadm
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin ;		\
fi
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lib/drbd
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v9'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
make[1]: Nothing to be done for `install'.
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v84'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lib/drbd
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lock
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
if getent group haclient > /dev/null 2> /dev/null ; then		\
	install -g haclient -m 4750 drbdsetup-83
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
;	\
	install -m 755 drbdadm-83
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
;		\
else									\
	install -m 755 drbdsetup-83
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
;		\
	install -m 755 drbdadm-83
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
; 		\
fi
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/v83'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/scripts'
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/systemd/system
install -m 644 drbd.service
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/systemd/system/
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
install -m 755 drbd
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/tmpfiles.d/
install -m 444 drbd.tmpfiles.conf
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/tmpfiles.d/drbd.conf
install -m 755 outdate-peer.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -m 755 snapshot-resync-target-lvm.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -m 755 notify.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -m 755 stonith_admin-fence-peer.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
( set -e ; cd
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
;\
  ln -s -f snapshot-resync-target-lvm.sh unsnapshot-resync-target-lvm.sh ;\
  ln -s -f notify.sh notify-split-brain.sh ;\
  ln -s -f notify.sh notify-io-error.sh ;\
  ln -s -f notify.sh notify-pri-on-incon-degr.sh ;\
  ln -s -f notify.sh notify-pri-lost.sh ;\
  ln -s -f notify.sh notify-pri-lost-after-sb.sh ;\
  ln -s -f notify.sh notify-emergency-reboot.sh ;\
  ln -s -f notify.sh notify-emergency-shutdown.sh ;\
  ln -s -f notify.sh notify-out-of-sync.sh; )
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
install -m 755 drbd-overview.pl
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin/drbd-overview
Don't forget to run chkconfig
mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/udev/rules.d
install -m 644 drbd.rules
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/udev/rules.d/65-drbd.rules
mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/xen/scripts
install -m 755 block-drbd
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/xen/scripts
mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/ha.d/resource.d
install -m 755 drbddisk
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/ha.d/resource.d
install -m 755 drbdupper
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/ha.d/resource.d
install -d
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -m 755 crm-fence-peer.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
install -m 755 crm-fence-peer.9.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
( set -e ; cd
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
;\
  ln -s -f crm-fence-peer.sh crm-unfence-peer.sh ;\
  ln -s -f crm-fence-peer.9.sh crm-unfence-peer.9.sh )
mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/ocf/resource.d/linbit
install -m 755 drbd.ocf
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/ocf/resource.d/linbit/drbd
install -m 644 drbd.shellfuncs.sh
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/ocf/resource.d/linbit/
mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/bash_completion.d
install -m 644 drbdadm.bash_completion
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/etc/bash_completion.d/drbdadm
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/scripts'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'
install -m 755 drbdmon
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/user/drbdmon'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v83'
set -e; for f in drbdsetup.8 drbd.conf.5 drbd.8 drbdadm.8 drbdmeta.8
drbddisk.8 ; do \
	s=${f##*.}; \
	b=${f%.[0-9]}; \
	install -v -D -m 644 $f
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man$s/$b-8.3.$s
; \
done
install: creating directory
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share'
install: creating directory
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man'
install: creating directory
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8'
'drbdsetup.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdsetup-8.3.8'
install: creating directory
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man5'
'drbd.conf.5' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man5/drbd.conf-8.3.5'
'drbd.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbd-8.3.8'
'drbdadm.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdadm-8.3.8'
'drbdmeta.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdmeta-8.3.8'
'drbddisk.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbddisk-8.3.8'
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v83'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v84'
make[1]: Nothing to be done for `install'.
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v84'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v9'
set -e; for f in drbdsetup.8 drbd.conf.5 drbd.8 drbdadm.8 drbdmeta.8
drbd-overview.8 drbdmon.8 ; do \
	s=${f##*.}; \
	b=${f%.[0-9]}; \
	install -v -D -m 644 $f
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man$s/$b-9.0.$s
; \
	if [ "no" = "yes" ]; then \
		ML=9.0; \
		if [ $f = "drbdmon.8" ]; then ML=9.0; fi ; \
		ln -sf $b-$ML.$s
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man$s/$f
; \
	fi \
done
'drbdsetup.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdsetup-9.0.8'
'drbd.conf.5' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man5/drbd.conf-9.0.5'
'drbd.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbd-9.0.8'
'drbdadm.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdadm-9.0.8'
'drbdmeta.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdmeta-9.0.8'
'drbd-overview.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbd-overview-9.0.8'
'drbdmon.8' ->
'/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/man8/drbdmon-9.0.8'
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/v9'
make[1]: Entering directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/ja/v84'
make[1]: Nothing to be done for `install'.
make[1]: Leaving directory
`/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0/documentation/ja/v84'
+ mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/run/drbd
+ mkdir
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin/
+ cd /home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/sbin/
+ ln -sv ../usr/sbin/drbdadm .
'./drbdadm' -> '../usr/sbin/drbdadm'
+ ln -sv ../usr/sbin/drbdmeta .
'./drbdmeta' -> '../usr/sbin/drbdmeta'
+ ln -sv ../usr/sbin/drbdsetup .
'./drbdsetup' -> '../usr/sbin/drbdsetup'
+ /usr/lib/rpm/find-debuginfo.sh --strict-build-id -m --run-dwz
--dwz-low-mem-die-limit 10000000 --dwz-max-die-limit 110000000
/home/digimer/rpmbuild/BUILD/drbd-utils-9.2.0
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin/drbdsetup
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin/drbdmeta
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin/drbdadm
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/sbin/drbdmon
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/drbdsetup-83
extracting debug info from
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd/drbdadm-83
/usr/lib/rpm/sepdebugcrcfix: Updated 5 CRC32s, 1 CRC32s did match.
symlinked /usr/lib/debug/usr/sbin/drbdadm.debug to
/usr/lib/debug/sbin/drbdadm.debug
symlinked /usr/lib/debug/usr/sbin/drbdmeta.debug to
/usr/lib/debug/sbin/drbdmeta.debug
symlinked /usr/lib/debug/usr/sbin/drbdsetup.debug to
/usr/lib/debug/sbin/drbdsetup.debug
cpio: drbd-utils-9.2.0/user/v9/drbdmeta_scanner.c: Cannot stat: No such
file or directory
cpio: drbd-utils-9.2.0/user/v9/drbdmeta_scanner.fl: Cannot stat: No such
file or directory
2700 blocks
+ /usr/lib/rpm/check-buildroot
+ /usr/lib/rpm/redhat/brp-compress
+ /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/brp-python-bytecompile /usr/bin/python 1
+ /usr/lib/rpm/redhat/brp-python-hardlink
+ /usr/lib/rpm/redhat/brp-java-repack-jars
Processing files: drbd-9.2.0-1.el7.centos.x86_64
Executing(%doc): /bin/sh -e /var/tmp/rpm-tmp.z1WIlk
+ umask 022
+ cd /home/digimer/rpmbuild/BUILD
+ cd drbd-utils-9.2.0
+
DOCDIR=/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-9.2.0
+ export DOCDIR
+ /usr/bin/mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-9.2.0
+ cp -pr COPYING
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-9.2.0
+ cp -pr ChangeLog
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-9.2.0
+ cp -pr README.md
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-9.2.0
+ exit 0
Provides: drbd = 9.2.0-1.el7.centos drbd(x86-64) = 9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Processing files: drbd-utils-9.2.0-1.el7.centos.x86_64
warning: %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd
warning: %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
warning: %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lib/drbd
warning: %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/run/drbd
Executing(%doc): /bin/sh -e /var/tmp/rpm-tmp.7xU070
+ umask 022
+ cd /home/digimer/rpmbuild/BUILD
+ cd drbd-utils-9.2.0
+
DOCDIR=/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ export DOCDIR
+ /usr/bin/mkdir -p
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ cp -pr scripts/drbd.conf.example
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ cp -pr COPYING
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ cp -pr ChangeLog
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ cp -pr README.md
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/doc/drbd-utils-9.2.0
+ exit 0
Provides: config(drbd-utils) = 9.2.0-1.el7.centos drbd-utils = 8.3.16
drbd-utils = 9.2.0-1.el7.centos drbd-utils(x86-64) = 9.2.0-1.el7.centos
Requires(interp): /bin/sh /bin/sh /bin/sh
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires(post): /bin/sh
Requires(preun): /bin/sh
Requires(postun): /bin/sh
Requires: /bin/bash /usr/bin/perl libc.so.6()(64bit)
libc.so.6(GLIBC_2.11)(64bit) libc.so.6(GLIBC_2.14)(64bit)
libc.so.6(GLIBC_2.15)(64bit) libc.so.6(GLIBC_2.16)(64bit)
libc.so.6(GLIBC_2.2.5)(64bit) libc.so.6(GLIBC_2.3)(64bit)
libc.so.6(GLIBC_2.3.2)(64bit) libc.so.6(GLIBC_2.3.4)(64bit)
libc.so.6(GLIBC_2.4)(64bit) libc.so.6(GLIBC_2.7)(64bit)
libc.so.6(GLIBC_2.8)(64bit) libc.so.6(GLIBC_2.9)(64bit)
libgcc_s.so.1()(64bit) libgcc_s.so.1(GCC_3.0)(64bit) libm.so.6()(64bit)
libstdc++.so.6()(64bit) libstdc++.so.6(CXXABI_1.3)(64bit)
libstdc++.so.6(GLIBCXX_3.4)(64bit) perl(Getopt::Long) perl(strict)
perl(warnings) rtld(GNU_HASH)
Conflicts: drbd < 8.3.6 drbd82 drbd83
Processing files: drbd-xen-9.2.0-1.el7.centos.x86_64
Provides: drbd-xen = 9.2.0-1.el7.centos drbd-xen(x86-64) =
9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: /bin/bash
Processing files: drbd-udev-9.2.0-1.el7.centos.x86_64
Provides: config(drbd-udev) = 9.2.0-1.el7.centos drbd-udev =
9.2.0-1.el7.centos drbd-udev(x86-64) = 9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Processing files: drbd-pacemaker-9.2.0-1.el7.centos.x86_64
Provides: drbd-pacemaker = 9.2.0-1.el7.centos drbd-pacemaker(x86-64) =
9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: /bin/bash /bin/sh
Processing files: drbd-heartbeat-9.2.0-1.el7.centos.x86_64
Provides: drbd-heartbeat = 9.2.0-1.el7.centos drbd-heartbeat(x86-64) =
9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: /bin/bash
Processing files: drbd-bash-completion-9.2.0-1.el7.centos.x86_64
Provides: config(drbd-bash-completion) = 9.2.0-1.el7.centos
drbd-bash-completion = 9.2.0-1.el7.centos drbd-bash-completion(x86-64) =
9.2.0-1.el7.centos
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Processing files: drbd-man-ja-9.2.0-1.el7.centos.x86_64
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbd-*
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdsetup-*
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdadm-*
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man5/drbd.conf-*
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdmeta-*
error: File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbddisk-*


RPM build errors:
    bogus date in %changelog: Fri Dec 21 2017 Roland Kammerer
<roland.kammerer@linbit.com> - 9.2.0-1
    %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/lib/drbd
    %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/lib/drbd
    %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/lib/drbd
    %defattr doesn't define directory mode so file mode defined in
%defattr is used for directory:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/var/run/drbd
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbd-*
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdsetup-*
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdadm-*
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man5/drbd.conf-*
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbdmeta-*
    File not found by glob:
/home/digimer/rpmbuild/BUILDROOT/drbd-9.2.0-1.el7.centos.x86_64/usr/share/man/ja/man8/drbddisk-*
====

-- 
Digimer
Papers and Projects: https://alteeve.com/w/
"I am, somehow, less interested in the weight and convolutions of
Einstein’s brain than in the near certainty that people of equal talent
have lived and died in cotton fields and sweatshops." - Stephen Jay Gould
