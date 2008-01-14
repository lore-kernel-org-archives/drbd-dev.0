Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E17E2E0B3C0
	for <drbd-dev@lists.linbit.com>; Mon, 14 Jan 2008 10:21:44 +0100 (CET)
Date: Mon, 14 Jan 2008 10:21:43 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-8.0 PATCH] One more place where stop=sync flag
	is not explicitely
Message-ID: <20080114092143.GJ5715@barkeeper1.linbit>
References: <342BAC0A5467384983B586A6B0B3767107C5AF6F@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107C5AF6F@EXNA.corp.stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Fri, Jan 11, 2008 at 10:31:31AM -0500, Graham, Simon wrote:
> The following patch fixes an issue where the STOP-SYNC flag was not explicitly
> cleared when resync is required – this can lead to the resync stalling.

probably correct.
though maybe it is not the right place to do it,
it certainly makes it more robust.


-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
