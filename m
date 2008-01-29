Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] DRBD 8.0;
	Make sure barrier is sent after last data block in epoch
Date: Tue, 29 Jan 2008 14:37:05 +0100
References: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B3767107E8A3F8@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200801291437.06285.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi Simon,

Back from travelling...=20

I have applied the two patches you sent Yesterday.
0001-Make-sure-barrier-is-sent-AFTER-last-data-block-in-e.patch
0002-Make-sure-we-dont-set-CREATE_BARRIER-flag-when-conne.patch

BTW, I did white space changes to them.=20
  Since we propagate changes from 8.0 to 8.2, and in 8.2 we try
  follow the Linux coding style hard, it makes things easier
  for us when the patches follow the Linux coding style in the
  first place.

=46rom the other patch bomb I still intend to merge=20
0010-Ensure-that-state-updates-cannot-be-done-out-of-orde.patch

Regarding the other patches from patch bomb #1, I wanted to
write an summay, which patches where accepted, which are not
yet applied for what reasons. ... But then I went to the
"Open Source Meets Business" Conference and now I can not=20
remember...=20

Simon, from your point of view, what patches to we missed from
patch bomb #1 ?

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
