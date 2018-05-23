Return-Path: <axboe@kernel.dk>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
	[209.85.223.194])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id B166A101AC7B
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 23:27:16 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id e20-v6so24557263iof.4
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 14:27:15 -0700 (PDT)
To: Joe Perches <joe@perches.com>, "Ed L. Cashin" <ed.cashin@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>, Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
Date: Wed, 23 May 2018 15:27:11 -0600
MIME-Version: 1.0
In-Reply-To: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, nbd@other.debian.org,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block drivers/block: Use octal not symbolic
	permissions
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 5/23/18 2:05 PM, Joe Perches wrote:
> Convert the S_<FOO> symbolic permissions to their octal equivalents as
> using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> see: https://lkml.org/lkml/2016/8/2/1945
> 
> Done with automated conversion via:
> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> 
> Miscellanea:
> 
> o Wrapped modified multi-line calls to a single line where appropriate
> o Realign modified multi-line calls to open parenthesis

Honestly, I see this as pretty needless churn.

-- 
Jens Axboe

