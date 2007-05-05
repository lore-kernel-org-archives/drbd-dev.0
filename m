Return-Path: <lars@linbit.com>
Date: Sat, 5 May 2007 11:31:12 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Panic in _drbd_send_page() again.
Message-ID: <20070505093112.GA21486@nudl>
References: <342BAC0A5467384983B586A6B0B3767105636A25@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105636A25@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, May 04, 2007 at 08:31:07PM -0400, Graham, Simon wrote:
> > but I don't think we can get rid of RQ_NET_SENT _that_ easy.
> 
> OK - you obviously know this stuff better than me!
> 
> I do still think that with this change we can remove the checks for
> RQ_NET_SENT before calling req_may_be_done which I like because it moves
> all the 'may be done' processing inside that function...

that's correct.
 :)


-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
