Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Oct 2006 15:02:59 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767103C3B980@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] DRBD-8: weirdness with netlink/connector
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

We have noticed that when issuing a sequence of drbdadm secondary &
primary commands, we get errors from the underlying drbdsetup command
like this:

[root@adam ~]# drbdadm secondary vm1.root.fs
[root@adam ~]# drbdadm primary vm1.root.fs
[root@adam ~]# drbdadm secondary vm1.root.fs
No response from the DRBD driver! Is the module loaded?

I noticed in the code that this error message is produced in a loop that
keeps reading from the netlink socket until it gets the expected reply
and also that there was some commented out trace code that would print
info if an unexpected reply was seen so I enabled this and now see
things like this:

[root@adam ~]# drbdadm secondary vm1.root.fs
[root@adam ~]# drbdadm primary vm1.root.fs
INFO: got other message=20
got seq: 110 ; ack 0=20
exp seq: 1 ; ack 1849768433=20
[root@adam ~]# drbdadm secondary vm1.root.fs
INFO: got other message=20
got seq: 111 ; ack 0=20
exp seq: 1 ; ack 299691195=20
No response from the DRBD driver! Is the module loaded?

This is very reproducible and is presumably either due to the wrong size
messages being sent by the kernel or some sort of data corruption in
drbdsetup - I figured you guys might have a better handle on fixing this
quickly!

Simon
