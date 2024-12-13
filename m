Return-Path: <joel.colledge@linbit.com>
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
	[209.85.218.47])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B27A3160645
	for <drbd-dev@lists.linbit.com>; Fri, 13 Dec 2024 16:59:26 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
	a640c23a62f3a-a9f1d76dab1so385674766b.0
	for <drbd-dev@lists.linbit.com>; Fri, 13 Dec 2024 07:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20241127112048.1460255-1-zhengbing.huang@easystack.cn>
In-Reply-To: <20241127112048.1460255-1-zhengbing.huang@easystack.cn>
From: Joel Colledge <joel.colledge@linbit.com>
Date: Fri, 13 Dec 2024 16:59:14 +0100
Message-ID: <CAGNP_+V7KHBsunRO_EKhXVrw7Ly4EJ7qYCT+m2CL0fwp4ii2Xw@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix memory leak
To: "zhengbing.huang" <zhengbing.huang@easystack.cn>
Content-Type: text/plain; charset="UTF-8"
Cc: drbd-dev@lists.linbit.com
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

> In the output of kmemleak, we have the followe backtrace:
> ...
> This is a memory leak.

Thanks for testing with kmemleak and reporting this.

> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index 86535080f..48c9588eb 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -3765,6 +3765,8 @@ struct drbd_resource *drbd_create_resource(const char *name,
>
>         list_add_tail_rcu(&resource->resources, &drbd_resources);
>
> +       resource->state_change_err_str = NULL;

This is not necessary. "resource" is allocated with "kzalloc", which
zero-initializes the memory.

> diff --git a/drbd/drbd_state.c b/drbd/drbd_state.c
> index 24ff7ab30..4102f2a04 100644
> --- a/drbd/drbd_state.c
> +++ b/drbd/drbd_state.c
> @@ -1566,6 +1566,9 @@ static __printf(2, 3) void _drbd_state_err(struct change_context *context, const
>                 *context->err_str = err_str;
>         if (context->flags & CS_VERBOSE)
>                 drbd_err(resource, "%s\n", err_str);
> +
> +       if (!context->err_str)
> +               kfree(err_str);
>  }

Good spot. I find it cleaner to rearrange the code and make this an
"else", as follows. Do you agree that this works too? Changing the
order of printing the error and assigning the "err_str" field should
not have any impact on the behavior of DRBD.

@@ -1557,10 +1557,13 @@ static __printf(2, 3) void
_drbd_state_err(struct change_context *context, const
        va_end(args);
        if (!err_str)
                return;
-       if (context->err_str)
-               *context->err_str = err_str;
        if (context->flags & CS_VERBOSE)
                drbd_err(resource, "%s\n", err_str);
+
+       if (context->err_str)
+               *context->err_str = err_str;
+       else
+               kfree(err_str);
 }


>  static __printf(2, 3) void drbd_state_err(struct drbd_resource *resource, const char *fmt, ...)
> @@ -1582,6 +1585,9 @@ static __printf(2, 3) void drbd_state_err(struct drbd_resource *resource, const
>                 *resource->state_change_err_str = err_str;
>         if (resource->state_change_flags & CS_VERBOSE)
>                 drbd_err(resource, "%s\n", err_str);
> +
> +       if (!resource->state_change_err_str)
> +               kfree(err_str);
>  }

Rearrange into "if-else" as above.

>  static enum drbd_state_rv __is_valid_soft_transition(struct drbd_resource *resource)
> @@ -5586,6 +5592,7 @@ static enum drbd_state_rv twopc_after_lost_peer(struct drbd_resource *resource,
>                 .target_node_id = -1,
>                 .flags = flags | (resource->res_opts.quorum != QOU_OFF ? CS_FORCE_RECALC : 0),
>                 .change_local_state_last = false,
> +               .err_str = NULL,

This is not necessary. Omitted fields are initialized to zero.

>         };
>
>         /* The other nodes get the request for an empty state change. I.e. they
> @@ -5915,7 +5922,8 @@ enum drbd_state_rv change_repl_state(struct drbd_peer_device *peer_device,
>                         .mask = { { .conn = conn_MASK } },
>                         .val = { { .conn = new_repl_state } },
>                         .target_node_id = peer_device->node_id,
> -                       .flags = flags
> +                       .flags = flags,
> +                       .err_str = NULL,

This is not necessary. Omitted fields are initialized to zero.

Best regards,
Joel
