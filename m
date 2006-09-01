Return-Path: <Simon.Graham@stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Fri, 1 Sep 2006 13:59:47 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710377B6ED@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Another drbdsetup issue...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I notice that with the latest drbd 8 from trunk, I get errors printed
out during system boot - these are caused by invalid drbdsetup commands
being issued that cause drbdsetup to print it's usage information
(leading to the segfault I reported earlier) - what I found is that the
drbd startup script is issuing a "drbdadm wait_con_int" command which in
turn generates 'drbdsetup wait_connect" commands which seem to have been
removed from drbdsetup... did I miss something whilst I was on vacation?


Simon

PS: I'm using the trunk from ~midday yesterday, Aug 31st.
