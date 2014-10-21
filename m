Return-Path: <jack@suse.cz>
Date: Tue, 21 Oct 2014 16:12:26 +0200
From: Jan Kara <jack@suse.cz>
To: Lars Ellenberg <drbd-dev@lists.linbit.com>
Message-ID: <20141021141226.GA9223@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: drbd-user@lists.linbit.com
Subject: [Drbd-dev] Bug in drbd_adm_attach()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

  Hello,

  Coverity has spotted a problem in drbd_adm_attach() which does:

        connection = peer_device ? peer_device->connection : NULL;
        conn_reconfig_start(connection);

and conn_reconfig_start() just blindly dereferences 'connection'. So either
peer_device cannot be NULL (and then the test is superfluous) or there's a
bug...

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
