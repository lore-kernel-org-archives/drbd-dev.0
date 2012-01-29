Return-Path: <1988wzc@gmail.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 228821055700
	for <drbd-dev@lists.linbit.com>; Sun, 29 Jan 2012 02:29:24 +0100 (CET)
Received: by wibhn14 with SMTP id hn14so3901071wib.27
	for <drbd-dev@lists.linbit.com>; Sat, 28 Jan 2012 17:29:23 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 29 Jan 2012 09:23:12 +0800
Message-ID: <CAPkhwwRYNwmv7B--Whaz8Nrpfc9XDMxqVw8J5V8qObfroVF2qw@mail.gmail.com>
From: carlos_wang <1988wzc@gmail.com>
To: "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Content-Type: multipart/alternative; boundary=e89a8f234bfbd2136204b7a09251
Subject: [Drbd-dev] Why does resync-cache uses LRU, rather than a queue,
	as its mechanism.
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--e89a8f234bfbd2136204b7a09251
Content-Type: text/plain; charset=ISO-8859-1

Hi all:
        I got a problem in understanding why resync-cache uses LRU as its
mechanism. I think that a queue is enough to realize the LRU functions. Why
does it use LRU anyway?

        Thanks in advance.

        Carlos.

--e89a8f234bfbd2136204b7a09251
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi all: <br>
=A0=A0=A0=A0=A0=A0=A0 I got a problem in understanding why resync-cache use=
s LRU as its mechanism. I think that a queue is enough to realize the LRU f=
unctions. Why does it use LRU anyway? </p>
<p>=A0=A0=A0=A0=A0=A0=A0 Thanks in advance. </p>
<p>=A0=A0=A0=A0=A0=A0=A0 Carlos.</p>

--e89a8f234bfbd2136204b7a09251--
