Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Tristan Tjerks" <t.tjerks@compri.nl>
Date: Tue, 23 Nov 2004 08:13:28 +0100
References: <OFENLNCLHDHNDAONGIOECEPGCAAA.t.tjerks@compri.nl>
In-Reply-To: <OFENLNCLHDHNDAONGIOECEPGCAAA.t.tjerks@compri.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411230813.28869.philipp.reisner@linbit.com>
Cc: drbd-dev@linbit.com
Subject: [Drbd-dev] Re: make disk ready for drbd
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 22. November 2004 17:38 schrieb Tristan Tjerks:
> Thank you,
>
> Now Idea what went wrong. It was formatted okay as ext3. Now it works okay,
> I just formatted it again and saved the partition again with fdisk.
>
> Is it normal that when you restart drbd on one server the whole system
> crashes? I can not even kill anything, the whole Linux system hangs and I
> have to press the reset button (it is a brand new Dell 2800 Dual Xeon
> server)...
>

No, of course not! It should not hang or crash!

Please, retry it and do it in this order:

1. Freshly boot the machine.
2. Start DRBD, (i.e. attach the /dev/drbd0 onto /dev/sda2
3. [optional] Start the peer node and start DRBD there,
   wait until the two are connected.
4. drbdadm primary r0
4. mkfs -t ext3 /dev/drbd0
5. mount /dev/drbd0 /mnt/something

What I want to say here, do not access the backing storage directly:
no mkfs -t ext3 on /dev/sda2, do not mount /dev/sda2 !

-philipp


