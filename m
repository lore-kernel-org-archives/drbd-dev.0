Return-Path: <axboe@kernel.dk>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
	[209.85.210.180])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 9352D42011D
	for <drbd-dev@lists.linbit.com>; Sat,  2 Apr 2022 01:56:44 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id w7so3968164pfu.11
	for <drbd-dev@lists.linbit.com>; Fri, 01 Apr 2022 16:56:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220331220349.885126-1-jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
Message-Id: <164885740219.761778.5044909883791536138.b4-ty@kernel.dk>
Date: Fri, 01 Apr 2022 17:56:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	linux-block@vger.kernel.org, Cristiano Giuffrida <c.giuffrida@vu.nl>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/2] drbd: remove usage of list iterator
	variable after loop for list_for_each_entry_safe_from()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, 1 Apr 2022 00:03:48 +0200, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to iterate through the list [1].
> 
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
> 
> [...]

Applied, thanks!

[1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
      commit: 901aeda62efa21f2eae937bccb71b49ae531be06
[2/2] drbd: remove check of list iterator against head past the loop body
      commit: 2651ee5ae43241831ca63d7158bb2b151a6a0e1f

Best regards,
-- 
Jens Axboe


