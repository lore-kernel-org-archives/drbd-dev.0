Return-Path: <skhan@linuxfoundation.org>
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
	[209.85.166.46])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id A3B3A4203A1
	for <drbd-dev@lists.linbit.com>; Mon, 21 Nov 2022 23:32:06 +0100 (CET)
Received: by mail-io1-f46.google.com with SMTP id y6so9701291iof.9
	for <drbd-dev@lists.linbit.com>; Mon, 21 Nov 2022 14:32:06 -0800 (PST)
Message-ID: <96114bec-1df7-0dcb-ec99-4f907587658d@linuxfoundation.org>
Date: Mon, 21 Nov 2022 15:32:02 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Benjamin Coddington <bcodding@redhat.com>
References: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
	<cover.1669036433.git.bcodding@redhat.com>
	<382872.1669039019@warthog.procyon.org.uk>
	<51B5418D-34FB-4E87-B87A-6C3FCDF8B21C@redhat.com>
	<4585e331-03ad-959f-e715-29af15f63712@linuxfoundation.org>
	<26d98c8f-372b-b9c8-c29f-096cddaff149@linuxfoundation.org>
	<A860595D-5BAB-461B-B449-8975C0424311@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <A860595D-5BAB-461B-B449-8975C0424311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Latchesar Ionkov <lucho@ionkov.net>, samba-technical@lists.samba.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	linux-nvme@lists.infradead.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	David Howells <dhowells@redhat.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, linux-nfs@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>, linux-afs@lists.infradead.org,
	cluster-devel@redhat.com, Christine Caulfield <ccaulfie@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Anna Schumaker <anna@kernel.org>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
	linux-block@vger.kernel.org, David Teigland <teigland@redhat.com>,
	Joel Becker <jlbec@evilplan.org>, v9fs-developer@lists.sourceforge.net,
	Keith Busch <kbusch@kernel.org>, ceph-devel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
	open-iscsi@googlegroups.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>, Chuck Lever <chuck.lever@oracle.com>,
	Lee Duncan <lduncan@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	"David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Subject: Re: [Drbd-dev] [PATCH v1 2/3] Treewide: Stop corrupting socket's
	task_frag
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

On 11/21/22 15:01, Benjamin Coddington wrote:
> On 21 Nov 2022, at 16:43, Shuah Khan wrote:
> 
>> On 11/21/22 14:40, Shuah Khan wrote:
>>> On 11/21/22 07:34, Benjamin Coddington wrote:
>>>> On 21 Nov 2022, at 8:56, David Howells wrote:
>>>>
>>>>> Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>>
>>>>>> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped setting the
>>>>>> GFP_NOIO flag on sk_allocation which the networking system uses to decide
>>>>>> when it is safe to use current->task_frag.
>>>>>
>>>>> Um, what's task_frag?
>>>>
>>>> Its a per-task page_frag used to coalesce small writes for networking -- see:
>>>>
>>>> 5640f7685831 net: use a per task frag allocator
>>>>
>>>> Ben
>>>>
>>>>
>>>
>>> I am not seeing this in the mainline. Where can find this commit?
>>>
>>
>> Okay. I see this commit in the mainline. However, I don't see the
>> sk_use_task_frag in mainline.
> 
> sk_use_task_frag is in patch 1/3 in this posting.
> 
> https://lore.kernel.org/netdev/26d98c8f-372b-b9c8-c29f-096cddaff149@linuxfoundation.org/T/#m3271959c4cf8dcff1c0c6ba023b2b3821d9e7e99
> 

Aha. I don't have 1/3 in my Inbox - I think it would make
sense to cc people on the first patch so we can understand
the premise for the change.

thanks,
-- Shuah
  

