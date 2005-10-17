Return-Path: <lmb@suse.de>
Date: Mon, 17 Oct 2005 15:43:49 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20051017134349.GT8354@marowsky-bree.de>
References: <20051017134012.CB1741431D@mail.linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051017134012.CB1741431D@mail.linbit.com>
Subject: [Drbd-dev] Re: [DRBD-cvs] svn commit by phil - r1985 -
	branches/drbd-0.7/drbd - Fixed a self made SMP lockup;
	showing up in drbd_al_com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2005-10-17T15:40:12, drbd-cvs@lists.linbit.com wrote:

> Author: phil
> Date: 2005-10-17 15:40:11 +0200 (Mon, 17 Oct 2005)
> New Revision: 1985
> 
> Modified:
>    branches/drbd-0.7/drbd/drbd_bitmap.c
> Log:
> Fixed a self made SMP lockup; showing up in drbd_al_complete_io()
> 
>   With drbd-0.7.12 we moved the al_lock before the bm_clear_bit()
>   in  __drbd_set_in_sync(). That by itself is okay, but 
>   in bm_clear_bit() we used the spin_[un]lock_irq() functions,
>   therefore reenabling interrupts...
>   This is fixed now.

Hi Philipp, how critical is this bug, and how likely is it that it will
be hit in practice?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

