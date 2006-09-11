Return-Path: <Lars.Ellenberg@linbit.com>
Received: from barkeeper1 (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 8D5EC2CF754D
	for <drbd-dev@lists.linbit.com>; Mon, 11 Sep 2006 12:13:49 +0200 (CEST)
Date: Mon, 11 Sep 2006 12:13:49 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8 (My) first problem with new requests handling
	code...
Message-ID: <20060911101349.GB22563@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B37671038AFF9F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B37671038AFF9F@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-09-10 18:58:32 -0400
\ Graham, Simon:
> Got a pretty quick death running the latest trunk - I think it's this
> code in the completed_ok case of _req_done:
> 
> 		bio_put(req->private_bio);
> 		req->private_bio = NULL;	<<=== Whoops!
> 		dec_local(mdev);
> 
> 		if (bio_data_dir(req->private_bio) == WRITE)  <<===
> BANG!
> 			mdev->writ_cnt += req->size>>9;
> 		else
> 			mdev->read_cnt += req->size>>9;
> 
> Presumably the bio_put and clear of req->private_bio should be after
> testing the direction ;-)

as I said untested...
and "obvious" :)
thanks.

> BTW: It took me quite a while to find this from the panic -- it actually
> crashed in drbd_endio_pri and the code generated for this is humungous
> and unbelievably complicated (it's about 12KB!) -- I wonder if you are
> trying to inline too much and it mightn't be better to have req_mod be a
> non-inline function and also have each case be a separate real
> function... I'd even suggest having _req_may_be_done() as a separate
> function.

probably the way to go.  let _req_may_be_done() be a non-inline
function, so the compiler can decide itself.

and, as the comment at the head of _req_mod says: we probably should
split the case branches out into "STATIC" functions, and only have the
_req_mod dispatch, or even remove the _req_mod switch statement again,
and only have the branch functions...

otherwise, what do you thin/have found out about that monster patch?

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
