Return-Path: <christoph.boehmwalder@linbit.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 8589B1630C1
	for <drbd-dev@lists.linbit.com>; Thu, 26 Mar 2026 15:26:17 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
	ffacd0b85a97d-43b9144790dso578457f8f.1
	for <drbd-dev@lists.linbit.com>; Thu, 26 Mar 2026 07:26:17 -0700 (PDT)
Message-ID: <af0dab46-3a73-4756-bea6-7cef66bb8d5e@linbit.com>
Date: Thu, 26 Mar 2026 15:26:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] drbd: Add check for error pointer
To: Ethan Tidmore <ethantidmore06@gmail.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
	<20260317232318.18923-5-ethantidmore06@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260317232318.18923-5-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com
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

On 3/18/26 00:23, Ethan Tidmore wrote:
> The function find_cfg_context_attr() can return an error pointer or NULL
> in its error path.
> 
> Change NULL check to IS_ERR_OR_NULL().
> 
> Detected by Smatch:
> drivers/block/drbd/drbd_nl.c:6571 drbd_adm_dump_paths() error:
> 'resource_filter' dereferencing possible ERR_PTR()
> 
> Fixes: 626c95b0e2a23 ("drbd: rework netlink interface for DRBD 9 multi-peer config")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>   drivers/block/drbd/drbd_nl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index c5e253820ccf..1f458eb972e9 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -6566,7 +6566,7 @@ static int drbd_adm_dump_paths(struct sk_buff *skb, struct netlink_callback *cb)
>   	resource = (struct drbd_resource *)cb->args[0];
>   	if (!cb->args[0]) {
>   		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
> -		if (resource_filter) {
> +		if (!IS_ERR_OR_NULL(resource_filter)) {
>   			retcode = ERR_RES_NOT_KNOWN;
>   			resource = drbd_find_resource(nla_data(resource_filter));
>   			if (!resource)

find_cfg_context_attr is also called identically in 3 other cases, so 
these have the same issue.
I've also fixed these 3 cases in my squash.

Regards,
Christoph
