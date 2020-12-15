Return-Path: <michael.d.labriola@gmail.com>
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
	[209.85.210.52])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 458AC420372
	for <drbd-dev@lists.linbit.com>; Tue, 15 Dec 2020 20:39:36 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id h18so20574542otq.12
	for <drbd-dev@lists.linbit.com>; Tue, 15 Dec 2020 11:39:36 -0800 (PST)
MIME-Version: 1.0
References: <CAOQxz3ztdjxt+7ock3q6+kMRgYAwY3h10K8xOY0hHrijt+MfcA@mail.gmail.com>
In-Reply-To: <CAOQxz3ztdjxt+7ock3q6+kMRgYAwY3h10K8xOY0hHrijt+MfcA@mail.gmail.com>
From: Michael Labriola <michael.d.labriola@gmail.com>
Date: Tue, 15 Dec 2020 14:39:23 -0500
Message-ID: <CAOQxz3weoma13ua-dRcRYvecf5OdTw6F-hTHABfGLtQFJ+VepQ@mail.gmail.com>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] problems connecting with mix of 9.0.26-rc3, 9.0.24-1,
	and 9.0.25-1
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

On Mon, Dec 14, 2020 at 10:36 AM Michael Labriola
<michael.d.labriola@gmail.com> wrote:
>
> I just tried upgrading 1 node of a 3 node cluster to 9.0.26-rc3 (w/ patch=
es for 5.10 kernel support).  The other two nodes are running 9.0.24-1 and =
9.0.25-1.  The upgraded node comes up w/out any noticeable complaints, but =
stays in Connecting forever.  Switching that node back to 9.0.25-1 connects=
 instantly.
>
*snip*
>
> Anyone seeing this kind of thing with the latest rc?
>

FYI, I'm happy to report that this problem is fixed in rc4.  I've got
working DRBD devices w/ the 5.10.1 kernel.  I'll go beat on it and see
if anything else breaks.  :-)

--=20
Michael D Labriola
21 Rip Van Winkle Cir
Warwick, RI 02886
401-316-9844 (cell)
