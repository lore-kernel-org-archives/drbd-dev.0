Return-Path: <philipp@hug.cx>
Received: from postman.abacus.ch (postman.abacus.ch [193.246.101.142])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B8D2B1431C
	for <drbd-dev@lists.linbit.com>; Wed, 24 Nov 2004 16:05:38 +0100 (CET)
Message-ID: <41A4A309.9030705@hug.cx>
Date: Wed, 24 Nov 2004 16:04:41 +0100
From: Philipp Hug <philipp@hug.cx>
MIME-Version: 1.0
To: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Drbd-dev] Re: 0.7.6 release tomorrow...
References: <200411152259.28960.philipp.reisner@linbit.com>	<41A48BB0.4080707@wollmersdorfer.at>
	<41A4909F.4070806@hug.cx>
	<200411241518.55023.philipp.reisner@linbit.com>
In-Reply-To: <200411241518.55023.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

yes, that would be nice

Philipp Reisner wrote:

>[...]
>  
>
>>sounds easier than it is: according to debian policy the upstream source
>>tgz must not be modified when uploaded to debian, instead a diff.gz is
>>upload that contains the diffs between upstream and debian release + it
>>normally contains the debian directory.
>>its not possible for the debian packager to remove files from the
>>original tgz not even in the diffs. you could call this a bug in the
>>dpkg-buildpackage tool but that's the way it is now.
>>
>>2nd: if an upstream package already contains a debian directory is
>>called a "native-debian" package and the version number should be e.g.
>>0.7.6 (without -debianversion). but the problem here would be, that the
>>drbd release must be the version that goes into debian.org and that's
>>not the case here...
>>
>>so I think that removing ./debian at least from the release tarball
>>would be a good idea... maybe we could add a "make releasetarball"
>>target...
>>
>>    
>>
>
>Ok... So ./debian stays in SVN but will be removed from the release-
>tarball. Ok. 
>Do you want to have it this way even with 0.7.6 ?
>
>-phil
>  
>
