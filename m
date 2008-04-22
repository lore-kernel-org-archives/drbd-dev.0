Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com,
	Azeez Ahamed <azeez.ahamed@rediffmail.com>
Subject: Re: [Drbd-dev] DRBD contribution
Date: Tue, 22 Apr 2008 11:29:22 +0200
References: <20080422075743.16073.qmail@f5mail-236-217.rediffmail.com>
In-Reply-To: <20080422075743.16073.qmail@f5mail-236-217.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804221129.22532.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> I need some clarification on the activities you suggested me to
> develop.
>
> >   3 Change drbdadm so that it allows multiple "on" sections per
> >     resource. -- One has to specify the peer he means on the
> >     commandline when use drbdadm connect.
> >     [for DRBD-8.2]
>
>   Here you are looking for 1 to n node replication? When we use
> drbdadm connect command, it uses this command internally
>
> drbdsetup /dev/drbd0 net 10.1.40.33:1234 10.1.40.41:1234 C --set-defaults
> --create-device
>
>   Do i need to modify drbdsetup command to support multiple nodes?
> Please correct me if i am wrong.
>

Hi Azeez,

What I suggest is that the DRBD-driver and drbdsetup should stay as
they are. I suggest that you modify drbdadm so that one can specify
multiple on sections in a resource section.

As the driver and drbdsetup are two nodes only, one will then have
to select a peer node when calling drbdadm connect. So the command
line syntax of drbdadm will have to change as well. Maybe

drbdadm --to foo-node connect r0

Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
