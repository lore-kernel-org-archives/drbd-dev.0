Return-Path: <ivoks@ubuntu.com>
Message-ID: <4B47B824.4040701@ubuntu.com>
Date: Fri, 08 Jan 2010 23:56:36 +0100
From: =?UTF-8?B?QW50ZSBLYXJhbWF0acSH?= <ivoks@ubuntu.com>
MIME-Version: 1.0
To: drbd-user@lists.linbit.com, drbd-dev@lists.linbit.com
References: <201001071350.25981.philipp.reisner@linbit.com>
In-Reply-To: <201001071350.25981.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [DRBD-user] drbd-8.3.7rc2.tar.gz
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 07.01.2010 13:50, Philipp Reisner wrote:

> The second release candidate of 8.3.7 is intended to be the least RC.

Am I missing something in the build process? By default, when 
configured, prefix is /usr/local. Yet, files get installed even in 
/sbin/. Example:

./configure --prefix=/tmp/DRBD
make
make install

and the problem:

make[1]: Entering directory `/tmp/drbd-8.3.7rc2/user'
install -d //sbin/

in user/Makefile.in, there's:

install -d $(DESTDIR)/sbin/

while DESTDIR is defined as:

DESTDIR ?= /

So, prefix is ignored and DESTDIR can be overridden by:

DESTDIR=/tmp/DRBD make install

that creates /tmp/DRBD with arch dependent files and /tmp/DRBD/tmp/DRBD 
with arch independent files.

Take care
