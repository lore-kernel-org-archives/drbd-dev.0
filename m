Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AA429142F3
	for <drbd-dev@lists.linbit.com>; Tue,  7 Sep 2004 11:43:01 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd in linux-ha cvs
Date: Tue, 7 Sep 2004 11:43:01 +0200
References: <20040906135609.GT11820@marowsky-bree.de>
	<200409070957.57371.philipp.reisner@linbit.com>
	<20040907091507.GA3257@nudl>
In-Reply-To: <20040907091507.GA3257@nudl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200409071143.01189.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

>
> the point was to have an easy way to _read_ all available information in
> a well defined way in one chunk. and having it in k=v form makes it
> direktly useable by bash, and easily useable by perl:
>

Is it worth the trouble to maintain two interfaces in drbdadm ?

Is it less rouble to maintain the 

CSTATE=$(drbdadm cstate r0)
LOCAL_STATE=$( $DRBDADM state $RES 2> /dev/null )
LOCAL_STATE=${LOCAL_STATE%/*}
LOCAL_STORAGE= $(drbdadm sh-ll-dev r0)
...

lines in the bash script you do ?

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
