Return-Path: <lmb@suse.de>
Date: Wed, 8 Sep 2004 13:20:01 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Another drbd race
Message-ID: <20040908112001.GD20844@marowsky-bree.de>
References: <20040819110202.GO9601@marowsky-bree.de>
	<200409071419.55799.philipp.reisner@linbit.com>
	<20040907122840.GA15272@marowsky-bree.de>
	<200409071447.45785.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409071447.45785.philipp.reisner@linbit.com>
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 2004-09-07T14:47:45,
   Philipp Reisner <philipp.reisner@linbit.com> said:

> No. It would be better to have a "drbdadm fence r0" operation on N2!
> The "drbdadm fence r0" command would only set the "Outdated" flag.

Well, it's automatically supposed to assume it's outdated when it
crashes in S-P mode.

When the secondary loses connection to the primary, a mark-peer-dead
would prevent that flag from being set.

So, why an explicit drbdadm fence operation? I'm missing what that would
catch.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

