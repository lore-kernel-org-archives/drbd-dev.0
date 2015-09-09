Return-Path: <lists@alteeve.ca>
Received: from vm08-mail01.alteeve.ca (mail.alteeve.ca [65.39.153.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1A484100EC11
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 08:34:39 +0200 (CEST)
Received: from lemass.alteeve.ca (dhcp-108-168-17-164.cable.user.start.ca
	[108.168.17.164])
	by vm08-mail01.alteeve.ca (Postfix) with ESMTPSA id 9324920281
	for <drbd-dev@lists.linbit.com>; Wed,  9 Sep 2015 02:34:34 -0400 (EDT)
To: drbd-dev@lists.linbit.com
References: <55EF7BEA.5060409@alteeve.ca>
From: Digimer <lists@alteeve.ca>
Message-ID: <55EFD2FD.6010500@alteeve.ca>
Date: Wed, 9 Sep 2015 02:34:37 -0400
MIME-Version: 1.0
In-Reply-To: <55EF7BEA.5060409@alteeve.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] rhcs_fence
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

On 08/09/15 08:23 PM, Digimer wrote:
> Is rhcs_fence not shipped with drbd 8.4?

If not (it appears not), and if there is interest in adding it, I've
moved it's development into the main striker repo:

https://github.com/digimer/striker/blob/master/tools/rhcs_fence

-- 
Digimer
Papers and Projects: https://alteeve.ca/w/
What if the cure for cancer is trapped in the mind of a person without
access to education?
