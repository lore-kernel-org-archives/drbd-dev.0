Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (office.linbit [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B2E932DF6270
	for <drbd-dev@lists.linbit.com>; Tue, 18 Jul 2006 16:33:23 +0200 (CEST)
Date: Tue, 18 Jul 2006 16:33:25 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Large data requests
Message-ID: <20060718143325.GF3989@soda.linbit>
References: <342BAC0A5467384983B586A6B0B376710333A9A3@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342BAC0A5467384983B586A6B0B376710333A9A3@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-07-18 09:59:21 -0400
\ Graham, Simon:
> This seems too easy to be a bug, but I've been getting occasional errors
> with DRBD-8 (latest trunk as of yesterday) like this:
> 
> Jul 17 16:25:03 jake kernel: drbd2: receive_DataReply: (data_size >
> PAGE_SIZE) in /sandbox/sgraham/sn/trunk/drbd-8/drbd/drbd_receiver.c:1035
> 
> The line in question being:
> 
> 	ERR_IF(data_size >  PAGE_SIZE) return FALSE;
> 
> in receive_DataReply. Now, one of the changes in DRBD-8 was to allow
> requests up to 32K to be passed down and it looks to me like these are
> just passed on to the remote side (if the local side does not have good
> data) so it would be perfectly OK to receive a DataReply > 4KB in size -
> is this just a left over assert that needs to be removed? Or did I miss
> something?

thanks.
committed as:
-       ERR_IF(data_size >  PAGE_SIZE) return FALSE;
+       ERR_IF(data_size >  DRBD_MAX_SEGMENT_SIZE) return FALSE;


-- 
: Lars Ellenberg                                  Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
