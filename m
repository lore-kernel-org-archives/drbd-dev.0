Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 529D614311
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 15:18:56 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
Date: Wed, 24 Nov 2004 15:18:54 +0100
References: <200411152259.28960.philipp.reisner@linbit.com>
	<41A48BB0.4080707@wollmersdorfer.at> <41A4909F.4070806@hug.cx>
In-Reply-To: <41A4909F.4070806@hug.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411241518.55023.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> sounds easier than it is: according to debian policy the upstream source
> tgz must not be modified when uploaded to debian, instead a diff.gz is
> upload that contains the diffs between upstream and debian release + it
> normally contains the debian directory.
> its not possible for the debian packager to remove files from the
> original tgz not even in the diffs. you could call this a bug in the
> dpkg-buildpackage tool but that's the way it is now.
>
> 2nd: if an upstream package already contains a debian directory is
> called a "native-debian" package and the version number should be e.g.
> 0.7.6 (without -debianversion). but the problem here would be, that the
> drbd release must be the version that goes into debian.org and that's
> not the case here...
>
> so I think that removing ./debian at least from the release tarball
> would be a good idea... maybe we could add a "make releasetarball"
> target...
>

Ok... So ./debian stays in SVN but will be removed from the release-
tarball. Ok. 
Do you want to have it this way even with 0.7.6 ?

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
