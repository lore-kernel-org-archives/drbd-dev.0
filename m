Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id E41882E0B3C0
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jan 2008 09:21:56 +0100 (CET)
Date: Mon, 14 Jan 2008 09:21:56 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-8.0 PATCH] Make heartbeat script conform to LSB
	spec
Message-ID: <20080114082156.GE5715@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107C5AF55@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF55@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 11, 2008 at 10:14:50AM -0500, Graham, Simon wrote:
> The drbddisk script has a few places where it returns exit codes that don’t
> conform to the LSB spec when it could – this patch corrects the ones I’ve seen.

well, it is no lsb script, it is not intended to be,
and without proper support by drbdadm and drbdsetup,
it is probably not as easy as one might think to
actually make it lsb conform.

it is a "legacy heartbeat v1 resource agent" script.
so actually I see no point in making it conform to
some standard which does not apply.

but:

Content-Description: 0002-Make-heartbeat-script-conform-to-LSB-spec.patch
> From b56371785abc5f22698dcffe699e0434a88beab7 Mon Sep 17 00:00:00 2001
> From: Simon Graham <sgraham@anna.sn.stratus.com>
> Date: Fri, 21 Dec 2007 21:12:27 -0500
> Subject: [PATCH] Make heartbeat script conform to LSB spec
> 
> ---
>  scripts/drbddisk |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/drbddisk b/scripts/drbddisk
> index 7d001f5..53e02a0 100755
> --- a/scripts/drbddisk
> +++ b/scripts/drbddisk
> @@ -29,13 +29,15 @@ case "$CMD" in
>  	try=6
>  	while true; do
>  		$DRBDADM primary $RES && break
> -		let "--try" || exit 20
> +		let "--try" || exit 1

Ok. neither me nor heartbeat would care.

>  		sleep 1
>  	done
>  	;;
>      stop)
> -	# exec, so the exit code of drbdadm propagates
> -	exec $DRBDADM secondary $RES
> +	$DRBDADM secondary $RES
> +	if [ $? -eq 11 ]; then
> +	    exit 1
> +	fi

uh?
where does the 11 come from?
why handle only 11, and map everything else to 0?
what for exit codes != 0 and != 11?


>      status)
>  	if [ "$RES" = "all" ]; then
> @@ -46,10 +48,8 @@ case "$CMD" in
>  	STATE=${ST%/*}
>  	if [ "$STATE" = "Primary" ]; then
>  	    echo "running"
> -	elif [ "$STATE" = "Secondary" ]; then
> -	    echo "stopped"
>  	else
> -	    echo "$ST"
> +	    echo "stopped"

what about:
	STATE=${ST%/*}
+	case $STATE in
+		Primary)
+			echo "running (Primary)" ;;
+		Secondary|Unconfigured)
+			echo "stopped ($STATE)" ;;
+		"")
+			echo "stopped" ;;
+		*)
+			# unexpected. whatever...
+			echo "stopped ($ST)" ;;
+	esac


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
