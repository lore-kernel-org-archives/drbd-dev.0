Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD8: Stuck in WFBitMapS state even across reboot.
Date: Thu, 30 Nov 2006 16:11:40 +0100
References: <BD7042533C2F8943A6A4257A9E31C45439C843@EXNA.corp.stratus.com>
In-Reply-To: <BD7042533C2F8943A6A4257A9E31C45439C843@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301611.41232.philipp.reisner@linbit.com>
Cc: "Montrose, Ernest" <Ernest.Montrose@stratus.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 27. November 2006 23:28 schrieb Montrose, Ernest:
> Hi all,
> I am seeing a problem where both nodes get stuck in the WFBitMaps state
> even across a reboot.
> Dmesg also reveals this on both nodes:
> Drbd0: [drbd0_receiver/4800] sock_sendmsg time expired, ko = 4294967256
> .......
> Drbd0: Split-brain detected, manuall solved. Sync from this node
> Both nodes reports this split brain message.  My configuration for
> device 0 has the following new
> Settings NET:
> rr-conflict violently;
> after-sb-1pri violently-as0p;
> after-sb-2pri violently-as0p;
>
> Thanks for any help.
>

Hi Ernest,

Could you please give us a better description, how we can reproduce this
here ?

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
