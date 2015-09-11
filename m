Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 60C2A10518BD
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:45:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 265352BE88C
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:45:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ah30fpsyWmLM for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 14:45:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 08FDF2BE89D
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:45:39 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Z5imnlNyrG1 for <drbd-dev@lists.linbit.com>;
	Fri, 11 Sep 2015 14:45:38 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id DE4CA2BE88C
	for <drbd-dev@lists.linbit.com>; Fri, 11 Sep 2015 14:45:38 +0200 (CEST)
Date: Fri, 11 Sep 2015 14:45:38 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20150911124538.GN3436@soda.linbit>
References: <55F1BD96.7010507@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F1BD96.7010507@sandisk.com>
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Add support for building without
 manuals
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

On Thu, Sep 10, 2015 at 10:27:50AM -0700, Bart Van Assche wrote:
> When building DRBD for installation on e.g. an appliance no manuals
> are needed. Hence add an option to the spec file to build the
> drbd-utils RPM without manuals.

Ok.
Thank you,

	Lars

