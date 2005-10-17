Return-Path: <lmb@suse.de>
Date: Mon, 17 Oct 2005 15:57:49 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [DRBD-cvs] svn commit by phil - r1985 -
	branches/drbd-0.7/drbd - Fixed a self made SMP lockup;
	showing up in drbd_al_com
Message-ID: <20051017135748.GU8354@marowsky-bree.de>
References: <20051017134012.CB1741431D@mail.linbit.com>
	<20051017134349.GT8354@marowsky-bree.de>
	<20051017135618.GA32693@barkeeper1.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051017135618.GA32693@barkeeper1.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-10-17T15:56:18, Lars Ellenberg <Lars.Ellenberg@linbit.com> wrote:

> it will be hit. rating is CRITICAL (for smp).
> 
> there will be a 0.7.14 today, latest tomorrow, including this fix,
> and the fix for not notifying the peer about "io-error on read".

Great, thank you. I'll pull that into SLES9 then.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

