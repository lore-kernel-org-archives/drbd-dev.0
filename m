Return-Path: <heming.zhao@suse.com>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id E3A3116B836
	for <drbd-dev@lists.linbit.com>; Thu, 15 May 2025 04:19:47 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
	ffacd0b85a97d-3a0bcb1f1afso60188f8f.0
	for <drbd-dev@lists.linbit.com>; Wed, 14 May 2025 19:19:47 -0700 (PDT)
Message-ID: <30933ffd-6462-4c95-8fbb-10b13acedb15@suse.com>
Date: Thu, 15 May 2025 10:19:43 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] remove lock file after using it
To: drbd-dev@lists.linbit.com
References: <20250514150402.15848-1-heming.zhao@suse.com>
	<20250514150402.15848-2-heming.zhao@suse.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250514150402.15848-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: zzhou@suse.com
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

On 5/14/25 23:04, Heming Zhao wrote:
> In a SELinux env, if a user runs as root to set up a DRBD device,
> it will leave a lock file in "/var/run/drbd/lock/". Then HA pacemaker
> will fail to set up DRBD because of a permission issue.
> 
> This commit removes the lock file when drbdsetup and drbdmeta close
> the lock fd.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>   user/shared/drbdmeta.c    |  3 +++
>   user/shared/shared_tool.c | 16 +++++++++++++++-
>   user/shared/shared_tool.h |  2 +-
>   user/v84/drbdsetup.c      |  2 +-
>   user/v9/drbdsetup.c       |  2 +-
>   5 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/user/shared/drbdmeta.c b/user/shared/drbdmeta.c
> index 099592a530da..c84c09abef86 100644
> --- a/user/shared/drbdmeta.c
> +++ b/user/shared/drbdmeta.c
> @@ -5482,6 +5482,9 @@ int main(int argc, char **argv)
>   	if (minor_attached)
>   		fprintf(stderr, "# Output might be stale, since minor %d is attached\n", cfg->minor);
>   
> +	if ((cfg->minor != -1) && (cfg->lock_fd != -1))
> +		dt_unlock_drbd(cfg->lock_fd, cfg->minor);
> +
>   	// dummy bool normalization to not return negative values, the usual "FIXME sane exit codes" still applies */
>   	return !!rv;
>   	/* and if we want an explicit free,
> diff --git a/user/shared/shared_tool.c b/user/shared/shared_tool.c
> index 20598132a0ac..f9ed4e7258f8 100644
> --- a/user/shared/shared_tool.c
> +++ b/user/shared/shared_tool.c
> @@ -793,10 +793,24 @@ int dt_lock_drbd(int minor)
>   }
>   
>   /* ignore errors */
> -void dt_unlock_drbd(int lock_fd)
> +void dt_unlock_drbd(int lock_fd, int minor)
>   {
> +	int sz;
> +	char *lfname;
> +
>   	if (lock_fd >= 0)
>   		unlock_fd(lock_fd);
> +
> +	sz = asprintf(&lfname, "%s/drbd-%d-%d",
> +		      drbd_lock_dir(), LANANA_DRBD_MAJOR, minor);
> +	if (sz < 0) {
> +		perror("");
> +		exit(20);
> +	}
> +	if (unlink(lfname) < 0) {
> +		perror("unlink");
> +		exit(20);
> +	}

Sorry, I forgot to free the lfname before the function returns.
Will send v2 patch.

- Heming

>   }
>   
>   void dt_print_gc(const uint32_t* gen_cnt)
> diff --git a/user/shared/shared_tool.h b/user/shared/shared_tool.h
> index 3dedf79683f5..44f10b549a77 100644
> --- a/user/shared/shared_tool.h
> +++ b/user/shared/shared_tool.h
> @@ -108,7 +108,7 @@ extern bool addr_scope_local(const char *input);
>   extern unsigned long long m_strtoll(const char* s,const char def_unit);
>   extern int only_digits(const char *s);
>   extern int dt_lock_drbd(int minor);
> -extern void dt_unlock_drbd(int lock_fd);
> +extern void dt_unlock_drbd(int lock_fd, int minor);
>   extern int dt_minor_of_dev(const char *device);
>   extern void dt_print_gc(const uint32_t* gen_cnt);
>   extern void dt_pretty_print_gc(const uint32_t* gen_cnt);
> diff --git a/user/v84/drbdsetup.c b/user/v84/drbdsetup.c
> index 9127a4462a0e..530af7b70b95 100644
> --- a/user/v84/drbdsetup.c
> +++ b/user/v84/drbdsetup.c
> @@ -3715,7 +3715,7 @@ int main(int argc, char **argv)
>   	rv = cmd->function(cmd, argc, argv);
>   
>   	if ((context & CTX_MINOR) && !cmd->lockless)
> -		dt_unlock_drbd(lock_fd);
> +		dt_unlock_drbd(lock_fd, minor);
>   	return rv;
>   }
>   #endif
> diff --git a/user/v9/drbdsetup.c b/user/v9/drbdsetup.c
> index 8aa9b7c48a6a..e7fa4d8bad7b 100644
> --- a/user/v9/drbdsetup.c
> +++ b/user/v9/drbdsetup.c
> @@ -4779,6 +4779,6 @@ int drbdsetup_main(int argc, char **argv)
>   	rv = cmd->function(cmd, argc, argv);
>   
>   	if ((context & CTX_MINOR) && !cmd->lockless)
> -		dt_unlock_drbd(lock_fd);
> +		dt_unlock_drbd(lock_fd, minor);
>   	return rv;
>   }

