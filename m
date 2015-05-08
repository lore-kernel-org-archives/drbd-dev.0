Return-Path: <pryzby@telsasoft.com>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
	[209.85.213.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EF5A51028A43
	for <drbd-dev@lists.linbit.com>; Fri,  8 May 2015 17:09:07 +0200 (CEST)
Received: by igbpi8 with SMTP id pi8so23202532igb.1
	for <drbd-dev@lists.linbit.com>; Fri, 08 May 2015 08:09:05 -0700 (PDT)
Received: from pryzbyj (charmander.telsasoft.com. [50.244.222.1])
	by mx.google.com with ESMTPSA id j20sm5231731igt.5.2015.05.08.08.09.03
	for <drbd-dev@lists.linbit.com>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 May 2015 08:09:04 -0700 (PDT)
Date: Fri, 8 May 2015 10:09:02 -0500
From: Justin Pryzby <pryzby@telsasoft.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150508150902.GB3518@telsasoft.com>
References: <20150508045517.GA6131@telsasoft.com>
	<20150508080325.GS1968@rck.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150508080325.GS1968@rck.sh>
Subject: Re: [Drbd-dev] crm-fence-peer.sh missing shell expansion
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

On Fri, May 08, 2015 at 10:03:26AM +0200, Roland Kammerer wrote:
> On Thu, May 07, 2015 at 11:55:17PM -0500, Justin Pryzby wrote:
> > There are several instances of unexpanded variables in here:
> > 
> >                 sleep $(( net_hickup_time - SECONDS ))
> >         reboot_timeout=$(( reboot_timeout + SECONDS ))
> >                 echo WARNING "${extra_msg}going to reboot -f in $(( reboot_timeout - SECONDS )) seconds! To cancel: kill $$"
> >                         if out=$( crmadmin -t $(( cibtimeout * 200 )) -S $DRBD_PEER ) \
> 
> Could you be a bit more precise where you _exactly_ see the problem,
> please? "Several" does not help a bash n00b like me. Do you mean the '$'
> is missing for example for 'SECONDS'?

Yes, I was referring to that .. but, oh my goodness, you're right ..

Sorry for noise and thanks for the lesson :)

Justin
