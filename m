Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Iustin Pop <iustin@google.com>
Date: Mon, 17 May 2010 23:44:40 +0200
References: <cover.1274099535.git.iustin@google.com>
In-Reply-To: <cover.1274099535.git.iustin@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005172344.40802.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 0/3] Implement {begin|after}-resync-source
	handlers
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag 17 Mai 2010 14:37:57 schrieb Iustin Pop:
> These small patches duplicate the resync-target handlers for the other
> end of the connection.
>

Hi Iustin,

The patches look okay so far, I am considering to apply them
to our tree.

* Have you ever considered to use the "drbdsetup events" 
  interface instead?

* Are you going to use them in your organisation? 

Best,
 Phil
