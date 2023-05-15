Return-Path: <mirimmad@outlook.com>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam12olkn2105.outbound.protection.outlook.com
	[40.92.22.105])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id B509242016E
	for <drbd-dev@lists.linbit.com>; Mon, 15 May 2023 15:26:33 +0200 (CEST)
From: Immad Mir <mirimmad@outlook.com>
To: =?Windows-1252?Q?Christoph_B=F6hmwalder?=
	<christoph.boehmwalder@linbit.com>
Date: Mon, 15 May 2023 13:12:00 +0000
Message-ID: <CY5PR12MB645585CED318784A647D29F2C6789@CY5PR12MB6455.namprd12.prod.outlook.com>
References: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
	<CY5PR12MB64558DB2E8ACBD592F26E61AC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
	<2ec28ec3-1e22-e772-fc9a-d59c6d176b7d@linbit.com>
In-Reply-To: <2ec28ec3-1e22-e772-fc9a-d59c6d176b7d@linbit.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY5PR12MB645585CED318784A647D29F2C6789CY5PR12MB6455namp_"
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH v2] drdb: fix debugfs_create_dir and
 debugfs_create_symlink error handling
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--_000_CY5PR12MB645585CED318784A647D29F2C6789CY5PR12MB6455namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Ah, Thanks for the feedback, Christopher.

Immad.
________________________________
From: Christoph B=F6hmwalder <christoph.boehmwalder@linbit.com>
Sent: Monday, May 15, 2023 2:26 PM
To: mirimmad@outlook.com <mirimmad@outlook.com>
Cc: axboe@kernel.dk <axboe@kernel.dk>; drbd-dev@lists.linbit.com <drbd-dev@=
lists.linbit.com>; lars.ellenberg@linbit.com <lars.ellenberg@linbit.com>; l=
inux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>; mirimmad17@gmail.com <mirimmad1=
7@gmail.com>; philipp.reisner@linbit.com <philipp.reisner@linbit.com>; skha=
n@linuxfoundation.org <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] drdb: fix debugfs_create_dir and debugfs_create_sym=
link error handling

Am 14.05.23 um 16:10 schrieb mirimmad@outlook.com:
> From: Immad Mir <mirimmad17@gmail.com>
>
> debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
> a failure which must be checked with the inline function IS_ERR. This
> patch attempts to do the same.
>
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
> Changes in v2:
>     - Fix indentation
>     - Fix potential memory leak
>
>  drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_=
debugfs.c
> index 12460b584..ab431a3f2 100644
> --- a/drivers/block/drbd/drbd_debugfs.c
> +++ b/drivers/block/drbd/drbd_debugfs.c
> @@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *devi=
ce)
>
>        snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
>        dentry =3D debugfs_create_dir(vnr_buf, vols_dir);
> +    if (IS_ERR(dentry)) goto fail;
>        device->debugfs_vol =3D dentry;
>
>        snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
> @@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *dev=
ice)
>        if (!slink_name)
>                goto fail;
>        dentry =3D debugfs_create_symlink(minor_buf, drbd_debugfs_minors, =
slink_name);
> -     device->debugfs_minor =3D dentry;
> -     kfree(slink_name);
> -     slink_name =3D NULL;
> +    if (!IS_ERR(dentry)) {
> +        device->debugfs_minor =3D dentry;
> +        kfree(slink_name);
> +        slink_name =3D NULL;
> +    } else {
> +        kfree(slink_name);
> +        slink_name =3D NULL;
> +        goto fail;
> +    }
>
>  #define DCF(name)    do {                                    \
>        dentry =3D debugfs_create_file(#name, 0440,       \
> --
> 2.40.0
>
>

Hi, thanks for the patch.

Please see this commit:

commit d27e84a305980ac61df0a6841059d0eb09b8283d
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue Jun 18 17:45:49 2019 +0200

    block: drbd: no need to check return value of debugfs_create functions

    When calling debugfs functions, there is no need to ever check the
    return value.  The function can work or not, but the code logic should
    never do something different based on this.

Also, it still looks like that whitespace is garbled.

NAK.

--
Christoph B=F6hmwalder
LINBIT | Keeping the Digital World Running
DRBD HA =97  Disaster Recovery =97 Software defined Storage

--_000_CY5PR12MB645585CED318784A647D29F2C6789CY5PR12MB6455namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Ah, Thanks&nbsp;for the feedback, Christopher.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Immad.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christoph B=F6hmwalde=
r &lt;christoph.boehmwalder@linbit.com&gt;<br>
<b>Sent:</b> Monday, May 15, 2023 2:26 PM<br>
<b>To:</b> mirimmad@outlook.com &lt;mirimmad@outlook.com&gt;<br>
<b>Cc:</b> axboe@kernel.dk &lt;axboe@kernel.dk&gt;; drbd-dev@lists.linbit.c=
om &lt;drbd-dev@lists.linbit.com&gt;; lars.ellenberg@linbit.com &lt;lars.el=
lenberg@linbit.com&gt;; linux-block@vger.kernel.org &lt;linux-block@vger.ke=
rnel.org&gt;; linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.org=
&gt;;
 mirimmad17@gmail.com &lt;mirimmad17@gmail.com&gt;; philipp.reisner@linbit.=
com &lt;philipp.reisner@linbit.com&gt;; skhan@linuxfoundation.org &lt;skhan=
@linuxfoundation.org&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drdb: fix debugfs_create_dir and debugfs_cre=
ate_symlink error handling</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 14.05.23 um 16:10 schrieb mirimmad@outlook.com:=
<br>
&gt; From: Immad Mir &lt;mirimmad17@gmail.com&gt;<br>
&gt; <br>
&gt; debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of=
<br>
&gt; a failure which must be checked with the inline function IS_ERR. This<=
br>
&gt; patch attempts to do the same.<br>
&gt; <br>
&gt; Signed-off-by: Immad Mir &lt;mirimmad17@gmail.com&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Fix indentation<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Fix potential memory leak<br>
&gt; <br>
&gt;&nbsp; drivers/block/drbd/drbd_debugfs.c | 13 ++++++++++---<br>
&gt;&nbsp; 1 file changed, 10 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/dr=
bd_debugfs.c<br>
&gt; index 12460b584..ab431a3f2 100644<br>
&gt; --- a/drivers/block/drbd/drbd_debugfs.c<br>
&gt; +++ b/drivers/block/drbd/drbd_debugfs.c<br>
&gt; @@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *d=
evice)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(vnr_buf, sizeof(vnr=
_buf), &quot;%u&quot;, device-&gt;vnr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dentry =3D debugfs_create_di=
r(vnr_buf, vols_dir);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (IS_ERR(dentry)) goto fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device-&gt;debugfs_vol =3D d=
entry;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(minor_buf, sizeof(m=
inor_buf), &quot;%u&quot;, device-&gt;minor);<br>
&gt; @@ -789,9 +790,15 @@ void drbd_debugfs_device_add(struct drbd_device *=
device)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!slink_name)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dentry =3D debugfs_create_sy=
mlink(minor_buf, drbd_debugfs_minors, slink_name);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; device-&gt;debugfs_minor =3D dentry;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(slink_name);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; slink_name =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; if (!IS_ERR(dentry)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device-&gt;debugfs_minor =
=3D dentry;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(slink_name);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slink_name =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(slink_name);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slink_name =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; #define DCF(name)&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dentry =3D debugfs_create_fi=
le(#name, 0440,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; --<br>
&gt; 2.40.0<br>
&gt; <br>
&gt; <br>
<br>
Hi, thanks for the patch.<br>
<br>
Please see this commit:<br>
<br>
commit d27e84a305980ac61df0a6841059d0eb09b8283d<br>
Author: Greg Kroah-Hartman &lt;gregkh@linuxfoundation.org&gt;<br>
Date:&nbsp;&nbsp; Tue Jun 18 17:45:49 2019 +0200<br>
<br>
&nbsp;&nbsp;&nbsp; block: drbd: no need to check return value of debugfs_cr=
eate functions<br>
<br>
&nbsp;&nbsp;&nbsp; When calling debugfs functions, there is no need to ever=
 check the<br>
&nbsp;&nbsp;&nbsp; return value.&nbsp; The function can work or not, but th=
e code logic should<br>
&nbsp;&nbsp;&nbsp; never do something different based on this.<br>
<br>
Also, it still looks like that whitespace is garbled.<br>
<br>
NAK.<br>
<br>
-- <br>
Christoph B=F6hmwalder<br>
LINBIT | Keeping the Digital World Running<br>
DRBD HA =97&nbsp; Disaster Recovery =97 Software defined Storage<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB645585CED318784A647D29F2C6789CY5PR12MB6455namp_--
