Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Fri, 4 Apr 2008 12:09:04 +0200
References: <20080403125233.2330.qmail@f5mail-237-205.rediffmail.com>
In-Reply-To: <20080403125233.2330.qmail@f5mail-237-205.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804041209.04704.philipp.reisner@linbit.com>
Cc: Azeez Ahamed <azeez.ahamed@rediffmail.com>
Subject: [Drbd-dev] Re: DRBD bugs repository?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Azeez,

> About my background details, i have 4+ years of experience in the field
> of Storage Networking (NAS and SAN). I have been working as software
> developer on platforms like Linux with C language.
>
> I am very much interested in contributing to this project. I can spend
> around 10hrs per week for this project. Please help me in providing
> access to the bugs list.

It is in our own intrest to make our bugzilla publically available,
at least for read access. -- But I do not have the resources right
now for that.

And I think that will not be of much use for you, since to work on the
issues that are currently open in bugzilla you need to have years
of experience with kernel development, and need quite some time to
get familiarize yourself with the DRBD module code base.

But I suggest that you select one of these tasks for you debut
as DRBD contributor:

  1 Implement an include statement for the config file in drbdadm.
    So that one can have a /etc/drbd.d/res1.conf .... and a
    /etc/drbd.conf that only says "include /etc/drbd.d/*;"
    [for DRBD-8.2]

  2 Work on the spec file. The RPMs that get currently build 
    lack a dependency on the kernel they are built for. Add that
    dependency. PS: You have to take care that it works for RHEL 
    and for SLES
    [for DRBD-8.0 and will get propagated to 8.2 from there]

  3 Change drbdadm so that it allows multiple "on" sections per
    resource. -- One has to specify the peer he means on the
    commandline when use drbdadm connect.
    [for DRBD-8.2]

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
