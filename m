Return-Path: <Lars.Ellenberg@linbit.com>
Received: from minna.local (dialin-145-254-060-221.arcor-ip.net
	[145.254.60.221])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 4742D1430A
	for <drbd-dev@lists.linbit.com>; Thu, 21 Oct 2004 01:26:39 +0200 (CEST)
Date: Thu, 21 Oct 2004 01:26:26 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20041020232626.GA2091@minna.local>
References: <gt0q2bPC2BjLTdYvoniqOkA=lge@web.de>
	<200410180959.08288.philipp.reisner@linbit.com>
	<n/0nVbG2W2wQDG4jMwN41Pc=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n/0nVbG2W2wQDG4jMwN41Pc=lge@web.de>
Subject: [Drbd-dev] Re: DRBD IOCTLs nicht 64bit clean...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

resent to the list just so this is in the archives, too.

	lge

/ 2004-10-18 18:41:00 +0200
\ Lars Ellenberg:
> na dann, ran...
> es ind ja nicht mehr viele.
> gnaugenommen nur eben dieser.
> alle anderen benutzen doch sowieso structs, und die sind doch sowieso
> all u32/u64, oder täusch ich mich da jetzt?

hm.
eigentlich ist doch ein "int" immer 32 bit gross,
auch auf einer 64 bit box. interessant sind also nur pointer und longs.

und enums, wenn da der basistyp nicht klar ist.


#define DRBD_IOCTL_GET_VERSION      _IOR( DRBD_IOCTL_LETTER, 0x00, int )
  hat bisher immer funktioniert.
  wenn kernel_int == userspace_int == 32bit, sollte das auch immer so sein.

#define DRBD_IOCTL_SET_STATE        _IOW( DRBD_IOCTL_LETTER, 0x02, Drbd_State )
  enum, allerdings nur kleine werte.
  falls basistyp "long" ist, und long einmal 64, einmal 32 hat,
  könnte das obere "wort" ignoriert werden...  muss man mal nachlesen.


#define DRBD_IOCTL_SET_DISK_CONFIG  _IOW( DRBD_IOCTL_LETTER, 0x06, struct ioctl_disk_config )
  struct disk_config {
	  IN int      lower_device;
	  IN __u64    disk_size;
	  IN enum io_error_handler on_io_error;
	  IN int      meta_device;
	  IN int      meta_index;
  };

  likely alignment problems...

  ich neheme jetzt mal an, dass enums basistyp int sind, und dass ints
  immer 32bit sind. dann sollte entweder __packed__ dabei stehen,
  oder besser:

  struct disk_config {
	  IN __u64    disk_size;
	  IN enum io_error_handler on_io_error;
	  IN int      lower_device;
	  IN int      meta_device;
	  IN int      meta_index;
  };



#define DRBD_IOCTL_SET_NET_CONFIG   _IOW( DRBD_IOCTL_LETTER, 0x07, struct ioctl_net_config )
  struct net_config {
  #define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
					   16 for IP, 16 for IPX,
					   24 for IPv6,
					   about 80 for AX.25 
					   must be at least one bigger than
					   the AF_UNIX size (see net/unix/af_unix.c
					   :unix_mkname()).  
					 */
	  IN char     my_addr[MAX_SOCK_ADDR];
	  IN int      my_addr_len;
==> alignment problem <<==
	  IN char     other_addr[MAX_SOCK_ADDR];
	  IN int      other_addr_len;
	  IN int      timeout;          // deci seconds
	  IN int      wire_protocol;
	  IN int      try_connect_int;  /* seconds */
	  IN int      ping_int;         /* seconds */
	  IN int      max_epoch_size;
	  IN int      max_buffers;
	  IN int      sndbuf_size;  /* socket send buffer size */
	  IN unsigned int ko_count;
	  IN enum disconnect_handler on_disconnect;
  };

#define DRBD_IOCTL_UNCONFIG_NET     _IO ( DRBD_IOCTL_LETTER, 0x08 )
  egal

#define DRBD_IOCTL_GET_CONFIG       _IOW( DRBD_IOCTL_LETTER, 0x0A, struct ioctl_get_config )
  möglicherweise schlecht aligned, bin jetzt zu faul genau zu schauen ...

#define DRBD_IOCTL_INVALIDATE       _IO ( DRBD_IOCTL_LETTER, 0x0D )
#define DRBD_IOCTL_INVALIDATE_REM   _IO ( DRBD_IOCTL_LETTER, 0x0E )
  egal

#define DRBD_IOCTL_SET_SYNC_CONFIG  _IOW( DRBD_IOCTL_LETTER, 0x0F, struct ioctl_syncer_config )
  struct syncer_config {
	  int      rate; /* KB/sec */
	  int      use_csums;   /* use checksum based syncing*/
	  int      skip;
	  int      group;
	  int      al_extents;
  };

  sollte passen. evtl. alignment problem in zusammen gesetzten
  structs wie get_config...

#define DRBD_IOCTL_SET_DISK_SIZE    _IOW( DRBD_IOCTL_LETTER, 0x10, unsigned int )
  sollte passen, aber lieber explizit __u32

#define DRBD_IOCTL_WAIT_CONNECT     _IOR( DRBD_IOCTL_LETTER, 0x11, struct ioctl_wait )
#define DRBD_IOCTL_WAIT_SYNC        _IOR( DRBD_IOCTL_LETTER, 0x12, struct ioctl_wait )
  struct ioctl_wait {
	  IN int wfc_timeout;
	  IN int degr_wfc_timeout;
	  OUT int ret_code;
  };
  sollte passen. evtl. alignment problem in zusammen gesetzten
  structs wie get_config...

#define DRBD_IOCTL_UNCONFIG_DISK    _IO ( DRBD_IOCTL_LETTER, 0x13 )
  egal

#define DRBD_IOCTL_SET_STATE_FLAGS  _IOW( DRBD_IOCTL_LETTER, 0x14, Drbd_State )
  enum. siehe SET_STATE
