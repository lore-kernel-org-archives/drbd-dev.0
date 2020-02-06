Return-Path: <dongsheng081251@gmail.com>
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
	[209.85.167.171])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8E9D042038C
	for <drbd-dev@lists.linbit.com>; Thu,  6 Feb 2020 03:02:20 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id l9so2990087oii.5
	for <drbd-dev@lists.linbit.com>; Wed, 05 Feb 2020 18:02:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+qeAOqyL5fDoFUXxVD0iaYSpY9P1qNH0Hd7eUUyGCg6hznKRQ@mail.gmail.com>
	<CA+qeAOpn85PevU6yxKqyt358ZVhdmLfwdaxvcpi4vy32Y4u8Mg@mail.gmail.com>
In-Reply-To: <CA+qeAOpn85PevU6yxKqyt358ZVhdmLfwdaxvcpi4vy32Y4u8Mg@mail.gmail.com>
From: Dongsheng Yang <dongsheng081251@gmail.com>
Message-ID: <CA+qeAOoXShFs5u7JUpCSs0vV9LEkY++zLmaez8CWvZbDcD_VSQ@mail.gmail.com>
To: lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
	joel.colledge@linbit.com, linux-block@vger.kernel.org,
	drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: duan.zhang@easystack.cn
Subject: [Drbd-dev] Fwd: Bug Report : meet an unexcepted WFBitMapS status
 after restarting the primary
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
Date: Thu, 06 Feb 2020 02:02:20 -0000

Adding linux-block maillist......

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongsheng Yang <dongsheng081251@gmail.=
com>
Date: 2020=E5=B9=B42=E6=9C=886=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=
=889:44
Subject: Fwd: Bug Report : meet an unexcepted WFBitMapS status after
restarting the primary
To: <lars.ellenberg@linbit.com>, <philipp.reisner@linbit.com>,
<linux-block@vger.kernel.org>, <joel.colledge@linbit.com>,
<drbd-dev@lists.linbit.com>
Cc: <duan.zhang@easystack.cn>


Hi Philipp and Lars,
     Any suggestions?

Thanx
---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongsheng Yang <dongsheng081251@gmail.=
com>
Date: 2020=E5=B9=B42=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=
=887:06
Subject: Bug Report : meet an unexcepted WFBitMapS status after
restarting the primary
To: <joel.colledge@linbit.com>
Cc: <drbd-dev@lists.linbit.com>, <duan.zhang@easystack.cn>


Hi guys,

Version: drbd-9.0.21-1

Layout: drbd.res within 3 nodes -- node-1(Secondary), node-2(Primary),
node-3(Secondary)

Description:
a.reboot node-2 when cluster is working.
b.re-up the drbd.res on node-2 after it restarted.
c.an expected resync from node-3 to node-2 happens. When the resync is
done, however,
  node-1 raises an unexpected WFBitMapS repl status and can't recover
to normal anymore.

Status output:

node-1: drbdadm status

drbd6 role:Secondary

disk:UpToDate

hotspare connection:Connecting

node-2 role:Primary

replication:WFBitMapS peer-disk:Consistent

node-3 role:Secondary

peer-disk:UpToDate


node-2: drbdadm status

drbd6 role:Primary

disk:UpToDate

hotspare connection:Connecting

node-1 role:Secondary

peer-disk:UpToDate

node-3 role:Secondary

peer-disk:UpToDate

I assume that there is a process sequence below according to my source
code version:
node-1                                           node-2
                                            node-3
        restarted with CRASHED_PRIMARY
        start sync with node-3 as target
   start sync with node-2 as source
        =E2=80=A6                                                          =
      =E2=80=A6
                                                 end sync with node-3
                                            end sync with node-2
        w_after_state_change
                      loop 1 within for loop against node-1:(a)
receive_uuids10                                  send uuid with
UUID_FLAG_GOT_STABLE&CRASHED_PRIMARY to node-1
receive uuid of node-2 with CRASHED_PRIMARY      loop 2 within for
loop against node-3:
        clear  CRASHED_PRIMARY(b)
send uuid to node-2 with UUID_FLAG_RESYNC        receive uuids10
sync_handshake to SYNC_SOURCE_IF_BOTH_FAILED     sync_handshake to NO_SYNC
change repl state to WFBitMapS

The key problem is about the order of step(a) and step(b), that is,
node-2 sends the
unexpected  CRASHED_PRIMARY to node-1 though it's actually no longer a
crashed primary
after syncing with node-3.
So may I have the below questions:
a.Is this really a BUG or just an expected result?
b.If there's already a patch fix within the newest verion?
c.If there's some workaround method against this kind of unexcepted
status, since I really
  meet so many other problems like that :(
