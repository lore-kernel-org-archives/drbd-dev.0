Return-Path: <lars@linbit.com>
Date: Thu, 10 May 2007 14:59:38 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: panic accessing NULL lru cache
Message-ID: <20070510125938.GC16300@barkeeper1.linbit>
References: <BD7042533C2F8943A6A4257A9E31C454F478EC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C454F478EC@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, May 09, 2007 at 05:40:10PM -0400, Montrose, Ernest wrote:
> But the lc entry was freed by the time  we called drbd_al_to_on_disk_bm().  If
> this is correct, I am still not sure
> how to best fix this.

thanks for triggering this :)
my proposed fix is comitted as svn r2884.
(untested)

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
