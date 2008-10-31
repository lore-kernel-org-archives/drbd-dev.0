Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems with code to disallow connection when peer
	has mismatched UUID
Date: Fri, 31 Oct 2008 13:43:45 +0100
References: <DA0E7D869C862D4095C265233CD1D41E011929A3@EXNA.corp.stratus.com>
	<DA0E7D869C862D4095C265233CD1D41E011929C8@EXNA.corp.stratus.com>
	<DA0E7D869C862D4095C265233CD1D41E01192D4A@EXNA.corp.stratus.com>
In-Reply-To: <DA0E7D869C862D4095C265233CD1D41E01192D4A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810311343.46320.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag 15 September 2008 16:40:34 schrieb Graham, Simon:
> Attached is a proposed patch to address this problem that does the
> following:
>
> 1. When connection is lost, a new UUID is not created on the primary if
> the local disk is inconsistent
> 2. Allow connection to be established if local disk is inconsistent even
> if the remote is using
>    a different UUID - our data is useless and cannot have been changed
> anyway. The following handshake
>    will cause the appropriate resync.
>
> Although only one of these is actually required to fix my problem, I
> thought it was better to be consistent
> and change both.
>

Hi Simon,

You patch is correct, and quite similar to that commit. The second
hunk is missing since a node in such an state can not get promoted
to primary anyways.

commit a20ecb2e221a3a0e565ecdbb9ac5239b54dca395
Author: Philipp Reisner <philipp.reisner@linbit.com>
Date:   Thu Jul 24 14:06:41 2008 +0200

    Fixed the "exposed data" logic in case a sync target primary lost the 
network connection

    closes #98

-Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.

