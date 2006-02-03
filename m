Return-Path: <lmb@suse.de>
Date: Fri, 3 Feb 2006 17:51:20 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: drbd-dev@lists.linbit.com
Message-ID: <20060203165120.GI16743@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Drbd-dev] fyi: SUSE changes method of kernel module packaging
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,

just to let you know that come SLES10/SL10.1, SUSE will package kernel
modules differently, in their own sub-packages. (I've already internally
converted drbd to this mechanism of course, you'll see that appear in
the next beta if you look ;-)

This mechanism eases building kernel module packages by 3rd parties
considerably. It is also being rolled out for SLES9. You may wish to
investigate using this for your own packages you provide to
customers...

Docs are available at http://www.suse.de/~agruen/KMPM/


Enjoy,
    Lars

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

