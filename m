Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AE9DE1433E
	for <drbd-dev@lists.linbit.com>; Tue, 19 Oct 2004 14:45:32 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: [PATCH] drbdmeta und glib ...
Date: Tue, 19 Oct 2004 14:46:46 +0200
References: <20041018221350.449853BE6D@garcon.linbit.com>
	<200410191135.04249.philipp.reisner@linbit.com>
	<89zVeflIzpji7xC+ripnD2w=lge@web.de>
In-Reply-To: <89zVeflIzpji7xC+ripnD2w=lge@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410191446.46648.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

[...]
> ok. so what exactly do you want to protect with that lock?
> I thought of locking the physical device.
>
> anycase, we probably should be able to identify which meta data block
> belongs to which data storage area, independently of device nodes and
> numbers.
>

The initail idea was to prevent drbdsetup to run while drbdmeta runs...

-philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
