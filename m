Return-Path: <ciprich@linuxbox.cz>
Date: Tue, 1 Jul 2008 10:34:40 +0200
From: Nikola Ciprich <extmaillist@linuxbox.cz>
To: drbd-dev@lists.linbit.com
Message-ID: <20080701083440.GA4432@develbox.linuxbox.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: nikola.ciprich@linuxbox.cz
Subject: [Drbd-dev] [PATCH] Remove proc_root usage (fixes 2.6.26 build)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi,
following patch removes usage of obsolete proc_root by usind NULL instead.
Please apply
BR
nik

diff -Naur drbd-8.0.git/drbd/drbd_main.c drbd-8.0.git-remove-proc-root/drbd/drbd_main.c
--- drbd-8.0.git/drbd/drbd_main.c       2008-06-10 08:02:55.000000000 -0400
+++ drbd-8.0.git-remove-proc-root/drbd/drbd_main.c      2008-07-01 03:27:16.000000000 -0400
@@ -2342,7 +2342,7 @@

        if (minor_table) {
                if (drbd_proc)
-                       remove_proc_entry("drbd",&proc_root);
+                       remove_proc_entry("drbd",NULL);
                i=minor_count;
                while (i--) {
                        drbd_dev        *mdev  = minor_to_mdev(i);
@@ -2579,7 +2579,7 @@
        /*
         * register with procfs
         */
-       drbd_proc = create_proc_entry("drbd",  S_IFREG | S_IRUGO , &proc_root);
+       drbd_proc = create_proc_entry("drbd",  S_IFREG | S_IRUGO , NULL);

        if (!drbd_proc) {
                printk(KERN_ERR DEVICE_NAME": unable to register proc file\n");


-- 
-------------------------------------
Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
