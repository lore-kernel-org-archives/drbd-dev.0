Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-059-179.arcor-ip.net
	[145.254.59.179])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id B563A1430A
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 01:58:42 +0200 (CEST)
Date: Thu, 21 Oct 2004 01:58:29 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] user interface test of drbd.conf
Message-ID: <WisKeXa4Zk9f7OFi56xHQ04=lge@web.de>
References: <20041020235059.650D53BE6F@garcon.linbit.com>
	<41768F97.60206@wollmersdorfer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020235059.650D53BE6F@garcon.linbit.com>
	<41768F97.60206@wollmersdorfer.at>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2004-10-20 18:17:27 +0200
\ Helmut Wollmersdorfer:

> Problem description: senseless values are accepted.

[ complains about missing range checks in the drbd.conf parser ]


/ 2004-10-21 01:50:59 +0200
\ svn@svn.drbd.org:
> Author: lars
> Date: 2004-10-21 01:50:56 +0200 (Thu, 21 Oct 2004)
> New Revision: 1609
> 
> Modified:
>    branches/drbd-0.7/documentation/drbd.conf.sgml
>    branches/drbd-0.7/scripts/drbd.conf
>    branches/drbd-0.7/user/drbdadm_parser.y
> Log:
> added range_check to drbdadm_parser.y,
>  now helmut can add rangechecks where neccessary

now, if you come up with more range checks you think should be in there,
just go to drbdadm_parser.y, and insert a
  range_check(value, name, min, max)
line at the appropriate location, like this:

> Modified: branches/drbd-0.7/user/drbdadm_parser.y
> ===================================================================
> --- branches/drbd-0.7/user/drbdadm_parser.y	2004-10-20 13:28:36 UTC (rev 1608)
> +++ branches/drbd-0.7/user/drbdadm_parser.y	2004-10-20 23:50:56 UTC (rev 1609)
> @@ -149,9 +159,15 @@
>  glob_stmt:	  TK_DISABLE_IO_HINTS
>  			{ global_options.disable_io_hints=1;   }
>  		| TK_MINOR_COUNT TK_INTEGER
> -			{ global_options.minor_count=atoi($2); }
> -		| TK_DIALOG_REFRESH TK_INTEGER   
> -                        { global_options.dialog_refresh=atoi($2); }
> +		{
> +			global_options.minor_count=atoi($2);
> +			range_check(global_options.minor_count,"minor_count",1,255);
> +		}
> +		| TK_DIALOG_REFRESH TK_INTEGER
> +		{
> +			global_options.dialog_refresh=atoi($2);
> +			range_check(global_options.dialog_refresh,"dialog_refresh",0,600);
> +		}
>  		;
