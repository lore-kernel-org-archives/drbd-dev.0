Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [Drbd-dev] Re: [john.cagle@hp.com: FW: device number request for drbd]
Date: Wed, 28 Jul 2004 16:55:18 +0200
Cc: drbd-dev@lists.linbit.com
References: <20040728080645.GB7918@tmathiasen> <200407281408.00730.philipp.reisner@linbit.com> <20040728141220.GV26564@marowsky-bree.de>
In-Reply-To: <20040728141220.GV26564@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W57BBKSpGaBhzxT"
Message-Id: <200407281655.18277.philipp.reisner@linbit.com>
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

--Boundary-00=_W57BBKSpGaBhzxT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wednesday 28 July 2004 16:12, Lars Marowsky-Bree wrote:
> On 2004-07-28T14:08:00,
>
>    Philipp Reisner <philipp.reisner@linbit.com> said:
> > > or just "default" to 147 for now?
> >
> > Yes I think so. The users should move to 147 with 0.7.1.
> > Do you like to do the removal of module param ?
>
> You want to move the _device major_ within a stable series?!? I can see
> the next local patch for SUSE coming right up ;-)
>

Yes I want to do this. Rolling upgrades are possible. 
I do not think that anybody actually cares about the major number 
or the name of the device node. 

-Philipp




-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_W57BBKSpGaBhzxT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="upgrade_0.6.x_to_0.7.0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="upgrade_0.6.x_to_0.7.0.txt"


DRBD upgrade instructions from 0.6.x to 0.7.0

* Since drbd-0.7.x is protocol incompatile to drbd-0.6.x you need
  to do a offline upgrade. I.e. no "rolling" upgrade possible.

  Make sure that the devices are in sync, make both sides secondary
  first and then stop DRBD on both nodes.

* In drbd-0.7.0 each DRBD resource needs 128MB of storage on
  some block device for its meta data. (With this /var/lib/drbd
  disappeared.)

  In order to do this upgrade you either need to

   A) shrink your filesystems on the DRBD devices by at least 128MB
   B) grow the backing_storage of the DRBD devices by at leas 128MB
   C) have one seperate block_device for all meta data

  A)
  ext2/ext3   resize2fs
  reiserfs    resize_reiserfs     
  xfs         xfsdump, xfsrestore ; xfs can only grow

  B)
  lvresize    in case you run DRBD on LVM
  (fdisk)     (Only do this if you know what you are doing.)

  C)
  The device needs to be n*128MB, where n is the number of 
  DRBD resources.

* Update you configurate file:
  - Change it to the new syntax.
  - Remove the disk-size parameter from you drbd.conf
  - Add the meta-disk settings
  - Remove tl-size
  - Change sync-min & sync-max to sync { rate }
  - Add the al-extents setting

* Start DRBD on both nodes

* Tune the al-extents setting to balance the number of updates
  to the metadata per minute (see cat /proc/drbd umber "al:") vs
  the expected resync time. 

--Boundary-00=_W57BBKSpGaBhzxT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="upgrade_0.7.0_to_0.7.1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="upgrade_0.7.0_to_0.7.1.txt"


DRBD upgrade instructions from 0.7.0 to 0.7.1

With drbd-0.7.1 we have our own major number, and our own device
files. (=No longer misuse /dev/nbX)

* Start on the node, on which all devices are secondary.
* /etc/init.d/drbd stop
* Install drbd-0.7.1
* Run these commands as root:

sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/drbd.conf > /etc/drbd.conf_new
mv /etc/drbd.conf /etc/drbd.conf_old ; mv /etc/drbd.conf_new /etc/drbd.conf
sed -e "s/\/dev\/nb/\/dev\/drbd/" < /etc/fstab > /etc/fstab_new
mv /etc/fstab /etc/fstab_old ; mv /etc/fstab_new /etc/fstab
for ((i=0;i<16;i++)); do mknod /dev/drbd$i b 147 $i; done

* /etc/init.d/drbd start
* migrate all services to the just upgraded node and 
  upgrade the other node.

--Boundary-00=_W57BBKSpGaBhzxT--
