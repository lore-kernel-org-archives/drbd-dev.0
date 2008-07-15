Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id DB4882DD03BB
	for <drbd-dev@lists.linbit.com>; Tue, 15 Jul 2008 17:34:27 +0200 (CEST)
Date: Tue, 15 Jul 2008 17:34:27 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] RDMA and DRBD
Message-ID: <20080715153427.GC9897@soda.linbit>
References: <C1EAC9C5E752D24C968FF091D446D823240B51@ALTERNATEREALIT>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1EAC9C5E752D24C968FF091D446D823240B51@ALTERNATEREALIT>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jul 11, 2008 at 02:30:27PM +0100, Robert Dunkley wrote:
>  
> 
> I’m planning to use DRBD with a “Crossover” Infinband connection. I’m pretty
> sure that I will get reasonable performance with IPOIB-CM but I was wondering
> if an RDMA version of DRBD was available

No.

> (It seems pretty well suited to RDMA).

Yes.

We may add RDMA support if time permits, may well be only in what is
currently codenamed "DRBD 9". It is not on top of our list, though.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
