Return-Path: <lars.ellenberg@linbit.com>
Date: Wed, 11 Mar 2009 19:35:04 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: "ILLES, Marton" <illes.marton@balabit.hu>
Message-ID: <20090311183504.GH8646@soda.linbit>
References: <1236792621.7981.25.camel@octane>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1236792621.7981.25.camel@octane>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] invalidate broken in 8.3.0 regression from 8.2.6
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Mar 11, 2009 at 06:30:21PM +0100, ILLES, Marton wrote:
> Hi,
> 
> First of all thanks for drbd, it is such a nice piece of code, we love
> to use it.
> 
> In my current setup I use drbd 8.3.0 with linux 2.6.27 and some ubuntu
> patches (but it does not really matter), while I discovered that
> "drbdsetup /dev/drbd0 invalidate" does not do anything. No error code,
> nothing. In 8.2.6 it worked well, so some regression is here.

was drbd0 configured while you did "drbdsetup /dev/drbd0 invalidate"?

if not, that is a known bug, which we unfortunately not have fixed yet.
drbdadm should try drbdsetup, and if that fails because the device is
unconfigured, it should use drbdmeta to mark it as invalid in the meta
data itself.

unfortunately drbdsetup invalidate exits with 0 for unconfigured
devices.

if drbdsetup invalidate does nothing even while it is configured,
that would be new to me.

> After
> some more careful code watching, I realized that after 8.2.6 release
> during a tree merge the fix it is partially reverted, cause currently we
> have:
> 
>  861     /* Early state sanitising. */
>  862 
>  863     /* Dissalow the invalidate command to connect  */
>  864     if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
>  865         os.conn < Connected) {
>  866         ns.conn = os.conn;
>  867         ns.pdsk = os.pdsk;
>  868     }
> 
> While the 1ad8484c83eb1ae28a8471d998c7b060ed045493 patch was:
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -707,6 +707,10 @@ int is_valid_state_transition(struct drbd_conf *mdev,
>             ns.conn != os.conn && os.conn > Connected)
>                 rv = SS_ResyncRunning;
>  
> +       if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
> +           os.conn < Connected)
> +               rv = SS_NeedConnection;
> +
>         return rv;
>  }
>  
> @@ -730,12 +734,7 @@ int _drbd_set_state(struct drbd_conf *mdev,
>                 dec_local(mdev);
>         }
>  
> -       /* Early state sanitising. Dissalow the invalidate ioctl to connect  */
> -       if ( (ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
> -               os.conn < Connected ) {
> -               ns.conn = os.conn;
> -               ns.pdsk = os.pdsk;
> -       }
> +       /* Early state sanitising. */
>  
>         /* Dissalow Network errors to configure a device's network part */
>         if ( (ns.conn >= Timeout && ns.conn <= TearDown ) &&
> 
> So IMHO some lines come back accidentally, which is bad. Checking the
> patch it looks like that is the only affected part that "returned".
> After removing the lines, invalidate works like a charm.
> 
> So here is the "magic" patch to fix it:
> 
> diff --git a/drbd/drbd_main.c b/drbd/drbd_main.c
> index 1a66e52..d73e247 100644
> --- a/drbd/drbd_main.c
> +++ b/drbd/drbd_main.c
> @@ -860,13 +860,6 @@ int _drbd_set_state(struct drbd_conf *mdev,
>  
>         /* Early state sanitising. */
>  
> -       /* Dissalow the invalidate command to connect  */
> -       if ((ns.conn == StartingSyncS || ns.conn == StartingSyncT) &&
> -               os.conn < Connected) {
> -               ns.conn = os.conn;
> -               ns.pdsk = os.pdsk;
> -       }
> -
>         /* Dissalow Network errors to configure a device's network part */
>         if ((ns.conn >= Timeout && ns.conn <= TearDown) &&
>             os.conn <= Disconnecting)
> 
> Please correct me if I am wrong, or please apply the patch. :)

thanks for reporting and investigating,
we'll have a look into why code changed as it did,
and what in fact is wrong.


-- 
: Lars Ellenberg
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
