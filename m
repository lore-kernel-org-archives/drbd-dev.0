Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [213.46.255.17])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id A8907142FF
	for <drbd-dev@lists.linbit.com>; Fri, 20 Aug 2004 16:10:00 +0200 (CEST)
Received: from wollmersdorfer.at ([212.186.65.148])
          by viefep16-int.chello.at
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20040820140955.JGHS14200.viefep16-int.chello.at@wollmersdorfer.at>
          for <drbd-dev@lists.linbit.com>; Fri, 20 Aug 2004 16:09:55 +0200
Message-ID: <41260639.7030806@wollmersdorfer.at>
Date: Fri, 20 Aug 2004 16:10:01 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd Frage zu secondary vs primary; drbddisk status
 problem
References: <20040819110202.GO9601@marowsky-bree.de> <20040819113205.GP9601@marowsky-bree.de> <R+ahoCHARbsLOMKIahWH0/Q=lge@web.de> <200408201452.52512.philipp.reisner@linbit.com>
In-Reply-To: <200408201452.52512.philipp.reisner@linbit.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: drbd-dev-admin@lists.linbit.com
Errors-To: drbd-dev-admin@lists.linbit.com
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev/>

Philipp Reisner wrote:
[...]
> Which policies do we want to offer ?
> 
>  * The node that was primary before split brain (current behaviour)
>  * The node that becaume primary during split brain 
>  * The node that modified more of it's data during the split-brain
>    situation  [ Do not think about implementation yet, just about
>                 the policy ]
>  * others ?...

    * The node preferred by the user,
      if both nodes can be Primary.
      This makes sense, when the standby node provides not
      the same performance.

    * The more stable node - "stable" TBD [To Be Defined]

Helmut Wollmersdorfer
