Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Or Gerlitz <ogerlitz@voltaire.com>
Date: Thu, 13 Jan 2011 17:07:34 +0100
References: <Pine.LNX.4.64.1101131124380.19218@zuben.voltaire.com>
	<201101131604.58153.philipp.reisner@linbit.com>
	<4D2F1E43.3050400@voltaire.com>
In-Reply-To: <4D2F1E43.3050400@voltaire.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101131707.34605.philipp.reisner@linbit.com>
Cc: Jens Axboe <jaxboe@fusionio.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd: clean reference to old kernels
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 13. Januar 2011, um 16:46:11 schrieb Or Gerlitz:
> Philipp Reisner wrote:
> > Yes, I send my pull requests to Jens, and CC them to LKML
> > If it would help you I can start to CC them to drbd-dev@lists.linbit.com
> > as well. It is a really low traffic mailing list
> 
> yep, please do that, it will help, so I'll subscribe to that list

Ok.
 
> > [...] the next pull request to Jens. (That will be for the 2.6.39 merge
> > window) FYI, We are missing the (current) 2.6.38 merge window, with
> > drbd-8.3.10
> 
> The drbd version in 2.6.37 is 8.3.9, looking on the git shortlog in the
> drbd-8.3 tree between 8.3.9 to 8.3.10rc2 I see many many changes with most
> of them being kernel ones.
> 
> Does this means that currently you push upstream only whole drbd releases,
> and such a push can contain tens or even hundred patches?
> 

Yes, exactly. 

Best,
 Phil
-- 
: Dipl-Ing Philipp Reisner
: LINBIT | Your Way to High Availability
: Tel: +43-1-8178292-50, Fax: +43-1-8178292-82
: http://www.linbit.com

DRBD(R) and LINBIT(R) are registered trademarks of LINBIT, Austria.
