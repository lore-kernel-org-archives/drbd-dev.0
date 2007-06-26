Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [DRBD-8] Update to drbdsetup events -a command
Date: Tue, 26 Jun 2007 12:01:44 +0200
References: <342BAC0A5467384983B586A6B0B3767105DEBC84@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767105DEBC84@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706261201.44842.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Monday 25 June 2007 20:32:14 Graham, Simon wrote:
> The drbdsetup events command starts off by outputting the current state
> of the selected device - however, when you use '-a' to have it monitor
> all devices, it would be useful if it would output the current state of
> all devices - this removes the need to poll for state before running the
> command. Attached is a suggested patch - probably a little too gross
> since I just looped for all possible minor numbers 0-255;  presumably we
> should actually read the configured max from somewhere?
>
>

You are absolutely right with this two patches ...
The are in.

-phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
