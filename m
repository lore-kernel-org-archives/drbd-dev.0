Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD8.0 PATCH] Updated fix to ensure stale state is
	not sent if a cluster wide state change is in progress
Date: Mon, 25 Feb 2008 16:22:44 +0100
References: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767108591DEC@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802251622.45055.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Samstag, 23. Februar 2008 21:44:10 schrieb Graham, Simon:
> This is an addendum to a patch I previously submitted (applied to the
> 8.0 tree as ID 6e9fdc92) that blocks sending state information if a
> cluster wide state change is in progress - there was a hole in this
> because the code in drbd_request_state() actually released the drbd
> state lock BEFORE updating the state locally leaving a small window
> where a request to send state can send the old stale state.
>

Hi simon,

just applied. Thanks!

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
