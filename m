Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Kernel panic - not syncing: drbd5: Sorry,
	I have no access to good data anymore.
Date: Wed, 2 May 2007 10:45:22 +0200
References: <87hcr4rd8a.fsf@informatik.uni-tuebingen.de>
In-Reply-To: <87hcr4rd8a.fsf@informatik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705021045.22954.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Mittwoch, 25. April 2007 11:54 schrieb Goswin von Brederlow:
> Hi,
>
> I just tested a disk failure by pulling a disk and it worked fine. But
> my (clumsy) attempt to add the disk back caused a kernel panic:
>
> Removing disk:
>
> [414277.088580] mptbase: ioc0: LogInfo(0x31140000): Originator={PL},
> Code={IO Executed}, SubCode(0x0000) [414277.088663] sd 6:0:5:0: SCSI error:
> return code = 0x00010000
> [414277.088693] end_request: I/O error, dev sdh, sector 575196672
> [414277.088730] drbd5: Local IO failed. Detaching...
> [414277.088757] drbd5: local read failed, retrying remotely
> [414277.088813] drbd5: Notified peer that my disk is broken.
> [414277.092110] sd 6:0:5:0: SCSI error: return code = 0x00010000
> [414277.092152] end_request: I/O error, dev sdh, sector 624880304
> [414277.092198] drbd5: drbd_md_sync_page_io(,624880304,WRITE) failed!
> [414277.092242] drbd5: meta data update failed!
> [414277.092278] drbd5: Releasing backing storage device.
> [414277.236025] mptsas: ioc0: removing sata device, channel 0, id 29, phy 7
> [414277.236282] Synchronizing SCSI cache for disk sdh:
> [414277.236742] FAILED
>
> Reinserting disk:
>
> [414277.236743]   status = 0, message = 00, host = 1, driver = 00
> [414277.236744]   <6>mptsas: ioc0: attaching sata device, channel 0,
> id 29, phy 7
> [414406.916387] scsi 6:0:8:0: Direct-Access     ATA      ST3320820AS   C   
> PQ: 0 ANSI: 5 [414406.917398] SCSI device sdh: 625142448 512-byte hdwr
> sectors (320073 MB) [414406.918542] sdh: Write Protect is off
> [414406.920814] SCSI device sdh: drive cache: write back
> [414406.921450] SCSI device sdh: 625142448 512-byte hdwr sectors (320073
> MB) [414406.922620] sdh: Write Protect is off
> [414406.924953] SCSI device sdh: drive cache: write back
> [414406.924989]  sdh: unknown partition table
> [414406.938553] sd 6:0:8:0: Attached scsi disk sdh
>
> # drbdadm attach drbd5
> ioctl(,SET_DISK_CONFIG,) failed: Device or resource busy
> Command 'drbdsetup /dev/drbd5 disk /dev/sdh internal -1
> --on-io-error=detach' terminated with exit code 20
> drbdadm aborting
>
> # drbdadm connect drbd5
> Read from remote host 192.168.53.210: Connection reset by peer
>
> [414440.162091] drbd5: drbd_ioctl_set_disk: (mdev->state != Secondary) in
> /usr/src/modules/drbd/drbd/drbd_fs.c:285 [414471.661751] drbd5:
> drbd_ioctl_set_disk: (mdev->state != Secondary) in
> /usr/src/modules/drbd/drbd/drbd_fs.c:285 [414521.697263] drbd5:
> drbd5_receiver [4916]: cstate Connected --> BrokenPipe [414521.697314]
> drbd5: short read expecting header on sock: r=-512 [414521.697366] drbd5:
> worker terminated
> [414521.697376] drbd5: asender terminated
> [414521.697538] drbd5: Sorry, I have no access to good data anymore.
> [414521.697579] Kernel panic - not syncing: drbd5: Sorry, I have no access
> to good data anymore. [414521.697581]
> [414521.698734]  (XEN) Domain 0 crashed: rebooting machine in 5 seconds.
>
>
> This is a 2.6.19 xen kernel with drbd0.7 0.7.21-4 from Debian.
>
>
> Now I have 2 questions:
>
> 1) is this fixed in 0.8?

8.0 does not have any calls to panic() left... 

> 2) how do I replace a disk correctly?
>

Your plan was basically okay. Altough calling connect after a failed
attach does not make a lot of sense...

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
