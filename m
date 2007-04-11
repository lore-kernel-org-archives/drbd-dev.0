Return-Path: <lars@linbit.com>
Date: Wed, 11 Apr 2007 16:51:40 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] switching between protocols A and C
Message-ID: <20070411145140.GA4659@barkeeper1.linbit>
References: <461CD0EC.4040402@dcs.gla.ac.uk>
	<20070411125716.GC27110@barkeeper1.linbit>
	<461CE69A.5020604@dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461CE69A.5020604@dcs.gla.ac.uk>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Apr 11, 2007 at 02:46:02PM +0100, Cristian Zamfir wrote:
> Lars Ellenberg wrote:
> >On Wed, Apr 11, 2007 at 01:13:32PM +0100, Cristian Zamfir wrote:
> >>Hi,
> >>
> >>Would it be possible to switch from protocol A to C and vice versa 
> >>without disconnecting (for instance detach, switch protocol and 
> >>re-attach)?
> >>
> >>This would be useful when alternating between two primaries (only 
> >>protocol C can be used) and a primary/secondary configuration where 
> >>protocol A may increase write throughput on the primary node.
> >
> >protocol A does _NOT_ increase throughput at all.
> >it _MAY_ reduce latency somewhat sometimes.
> 
> I am testing with the bonnie++ benchmark over a 100Mbps link and I get a 
> substantial increase for output in the case of protocol A at the expense 
> of higher CPU ratio. From what I understand, it would make sense to get 
> better throughput from the asynchronous protocol over low quality links. 
> Or am I doing something wrong?

and your exact bonnie++ command line is:

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
__
please use the "List-Reply" function of your email client.
