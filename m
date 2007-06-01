Return-Path: <lars.ellenberg@linbit.com>
Resent-Message-ID: <20070605093704.GB8891@aug>
Date: Fri, 1 Jun 2007 07:27:41 -0700 (PDT)
From: Ernest Montrose <ct246@yahoo.com>
Subject: RE: [Drbd-dev] DRBD8: Resync stalled at 100% due to race condition
To: philipp.reisner@linbit.com, drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <660030.76828.qm@web30503.mail.mud.yahoo.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Phil,
Thanks! But be aware that I had sent multiple messages about this since we are having
email issues here. I don't know which email you've seen.  But at least one of the emails
have a proposed patch that would simply acquire the req_lok earlier.  But that would
deadlock, so ignore that patch. Just an FYI.

EM--
-----Original Message-----
From: drbd-dev-bounces@linbit.com [mailto:drbd-dev-bounces@linbit.com] On Behalf Of Philipp Reisner
Sent: Friday, June 01, 2007 10:19 AM
To: drbd-dev@linbit.com
Subject: Re: [Drbd-dev] DRBD8: Resync stalled at 100% due to race condition
 
On Thursday 24 May 2007 14:41:53 Montrose, Ernest wrote:
> Hi all,
> We are seeing a problem where a resync hangs on the SyncSource at the
> end.  The SyncTarget finished OK and shows Connected. The signature on
> the SyncSource is:
[...]
 
Hi Ernest,
 
I will try to go trough this early next week (hopefully Monday).
 
-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
_______________________________________________
drbd-dev mailing list
drbd-dev@lists.linbit.com
http://lists.linbit.com/mailman/listinfo/drbd-dev


       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC

