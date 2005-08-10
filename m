Return-Path: <Lars.Ellenberg@linbit.com>
Date: Wed, 10 Aug 2005 23:20:34 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-user@lists.linbit.com
Message-ID: <20050810212034.GD6226@barkeeper1.linbit>
References: <42FA271D.1040803@delouw.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA271D.1040803@delouw.ch>
Subject: [Drbd-dev] Re: [DRBD-user] drbd 0.8.0
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2005-08-10 18:11:09 +0200
\ Luc de Louw:
asked on drbd-dev, but maybe more a drbd-user question:
> Hi all,
> 
> I have read somewhere that the SuSE packages of drbd 0.8 should not be used and I agree.
> 
> How about the SVN trunk? Are there a lot of features/API-Changes to be expected?

yes.

> Accoring the roadmap there will be a lot changes between 0.7.x and 0.8.

yes.

> Means: When I setup a System with a future what should I do? Install the SVN Trunk code or the stable 0.7.11?

drbd 0.7.11 (soonish 12...),
or branches/drbd-0.7, which is the current "stable" branch.

as long as svn trunk reads 0.8, it is "experimental developement".
you can use it, crash your boxes, send us bug reports and thus help
developement. if you intend to _use_ drbd, don't use svn trunk.
at least not now.

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
