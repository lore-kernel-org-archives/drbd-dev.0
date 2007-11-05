Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] PATCH: Missing state change netlink events
Date: Mon, 5 Nov 2007 11:25:22 +0100
References: <342BAC0A5467384983B586A6B0B376710707453A@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710707453A@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711051125.23233.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Sunday 04 November 2007 22:46:47 Graham, Simon wrote:
>  <<ava-3834.patch>> We have noticed that not all state changes are being
> reported via netlink (as seen with the 'drbdsetup /dev/drbd0 events -a
> -u' command) - the reason for this is that the state broadcast is done
> in after_state_ch using the _current_ mdev state when it runs - it's
> entirely possible for two state changes to occur in quick succession
> before the after_state_ch worker runs which results in the same state
> being broadcast twice - this is especially a problem if you are looking
> to see disk Failed state changes as the state tends to change to Failed
> and then to Diskless very quickly, which can result in the Diskless
> state being reported twice.
>
> I think the fix is simple - modify the code so that after_state_ch
> broadcasts the new state rather than the current state (patch attached)
> - I would have removed the passing of mdev completely from
> drbd_bcast_state() if it weren't for the fact it is required by the
> generated to_tags function. I'm testing this at the moment but it's a
> little hard to be sure it's right since this requires fairly tight
> timing.
>

Hi Simon,

You are right. Obviously.
I have put it into GIT.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
