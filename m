Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 38C5C14332
	for <drbd-dev@lists.linbit.com>; Fri,  8 Oct 2004 14:31:20 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] How Locking in GFS works...
Date: Fri, 8 Oct 2004 14:32:09 +0200
References: <200410041456.21841.philipp.reisner@linbit.com>
	<200410041617.21258.philipp.reisner@linbit.com>
	<2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
In-Reply-To: <2AuBE4UNaPcGXlPlToSVgHc=lge@web.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JjoZBTZvvlTG/Q7"
Message-Id: <200410081432.09710.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_JjoZBTZvvlTG/Q7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Friends,

In reallity it is much more complex than we thought in the first
place.

I think that the solution with the "coordinator node" and the write
now packet would be simpler, but it's drawback is the additional
write now packet means that we have more packets on the wirte....

... But please read it first!

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_JjoZBTZvvlTG/Q7
Content-Type: application/pdf;
  name="GFS-mode-arbitration2-c.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="GFS-mode-arbitration2-c.pdf"

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
bmRvYmoNCg0KNCAwIG9iag0KICA0MDg1DQplbmRvYmoNCg0KNiAwIG9iag0KPDwgL1R5cGUgL0Zv
bnQNCiAgIC9TdWJ0eXBlIC9UeXBlMQ0KICAgL0Jhc2VGb250IC9IZWx2ZXRpY2ENCiAgIC9FbmNv
ZGluZyAvV2luQW5zaUVuY29kaW5nDQo+Pg0KZW5kb2JqDQoNCjcgMCBvYmoNCjw8IC9GMSA2IDAg
Ug0KICAgPj4NCmVuZG9iag0KDQo4IDAgb2JqDQo8PA0KICAgL0ZvbnQgNyAwIFINCiAgIC9Qcm9j
U2V0IFsgL1BERiBdDQo+Pg0KZW5kb2JqDQoNCjkgMCBvYmoNCjw8IC9UeXBlIC9QYWdlDQogICAv
UGFyZW50IDUgMCBSDQogICAvUmVzb3VyY2VzIDggMCBSDQogICAvTWVkaWFCb3ggWyAwIDAgNTk1
IDg0MiBdDQogICAvQ29udGVudHMgMSAwIFINCj4+DQplbmRvYmoNCg0KMTAgMCBvYmoNCjw8IC9U
eXBlIC9QYWdlDQogICAvUGFyZW50IDUgMCBSDQogICAvUmVzb3VyY2VzIDggMCBSDQogICAvTWVk
aWFCb3ggWyAwIDAgNTk1IDg0MiBdDQogICAvQ29udGVudHMgMyAwIFINCj4+DQplbmRvYmoNCg0K
NSAwIG9iag0KPDwgL1R5cGUgL1BhZ2VzDQogICAvUmVzb3VyY2VzIDggMCBSDQogICAvTWVkaWFC
b3ggWyAwIDAgNTk1IDg0MiBdDQogICAvS2lkcyBbIDkgMCBSDQogICAgICAgICAgIDEwIDAgUg0K
ICAgICAgICAgICBdDQogICAvQ291bnQgMg0KPj4NCmVuZG9iag0KDQoxMSAwIG9iag0KPDwgL1R5
cGUgL0NhdGFsb2cNCiAgIC9QYWdlcyA1IDAgUg0KPj4NCmVuZG9iag0KDQoxMiAwIG9iag0KPDwg
L0NyZWF0b3IgPEZFRkYwMDQ0MDA3MjAwNjEwMDc3Pg0KL1Byb2R1Y2VyIDxGRUZGMDA0RjAwNzAw
MDY1MDA2RTAwNEYwMDY2MDA2NjAwNjkwMDYzMDA2NTAwMkUwMDZGMDA3MjAwNjcwMDIwMDAzMTAw
MkUwMDMxMDAyRTAwMzI+DQovQ3JlYXRpb25EYXRlIChEOjIwMDQxMDA4MTQyODAxKzAyJzAwJykN
Cj4+DQplbmRvYmoNCg0KeHJlZg0KMCAxMw0KMDAwMDAwMDAwMCA2NTUzNSBmDQowMDAwMDAwMDE3
IDAwMDAwIG4NCjAwMDAwMDQ5MzIgMDAwMDAgbg0KMDAwMDAwNDk1OSAwMDAwMCBuDQowMDAwMDA5
MTI5IDAwMDAwIG4NCjAwMDAwMDk2MzMgMDAwMDAgbg0KMDAwMDAwOTE1NiAwMDAwMCBuDQowMDAw
MDA5MjcxIDAwMDAwIG4NCjAwMDAwMDkzMTEgMDAwMDAgbg0KMDAwMDAwOTM3NiAwMDAwMCBuDQow
MDAwMDA5NTA0IDAwMDAwIG4NCjAwMDAwMDk3ODggMDAwMDAgbg0KMDAwMDAwOTg0OCAwMDAwMCBu
DQp0cmFpbGVyDQo8PCAvU2l6ZSAxMw0KICAgL1Jvb3QgMTEgMCBSDQogICAvSW5mbyAxMiAwIFIN
Cj4+DQpzdGFydHhyZWYNCjEwMDQ3DQolJUVPRg0K

--Boundary-00=_JjoZBTZvvlTG/Q7
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ROADMAP.i9"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ROADMAP.i9"

9 Support shared disk semantics  ( for GFS, OCFS etc... )

    All the thoughts in this area, imply that the cluster deals
    with split brain situations as discussed in item 6.

  In order to offer a shared disk mode for GFS, we allow both
  nodes to become primary. (This needs to be enabled with the
  config statement net { allow-two-primaries; } )

 Read after write dependencies

  The shared state is available to clusters using protocol C
  and B. It is not usable with protocol A.

  To support the shared state with protocol B, upon a read
  request the node has to check if a new version of the block
  is in the progress of getting written. (== search for it on
  active_ee and done_ee. [ Since it is on active_ee before the 
  RecvAck is sent. ] )
  
 Global write order

  [ Description of GFS-mode-arbitration2.pdf ]

  1. Basic mirroring with protocol C.
    The file system on N2 issues a write request towards DRBD, 
    which is written to the local disk and sent to N1. Then
    the data bock is written to the local disk here and and
    acknowledge packet is sent back. As soon as both the
    write to the local disk and the ACK from N1 reach N2, 
    DRBD signals the completion of IO to the file system.

    The major pitfall is the handling of concurrent writes to the
    same block. (Concurrent writes to the same blocks should not 
    happen, but we have to assume that it is possible that the
    synchronisation methods of our upper layer [i.e. openGFS] 
    may fail.)

    There are many cases in which such concurrent writes would
    lead to different data on our two copies of the block. 

  2. Concurrent writes, network latency is lower than disk latency
    As we can see on the left side in figure two this could lead
    to N1 has the blue version (=data from FS on N2) while N2
    ends with having the green version (=data from FS on N1).
    The solution is to flag one node (in the example N2 has the
    discard-concurrent-writes-flag).
    As we can see on the right side, now both nodes ends with 
    the blue data.

  3. Concurrent writes, high latency for data packets.
    The problem now is that N2 does can not detect that this was
    a concurrent write, since it got the ACK before the conflicting
    data packets comes in. 
    This can happens since in DRBD, data packets and ACK packets are
    transmitted via two independent TCP connections, therefore the
    ACK packet can overtakes a data packet.
    The solution is to send with the ACK packet a discard info packet,
    which identifies the data packet by it sequence number.
    N2 will keep this discard info as long as it has not seen higher
    sequence numbers by now.
    With this both nodes will end with the blue data.

  4. Concurrent writes, high latency for data packets.
    This is the inverse case to case3 and already handled by the means
    introduced with item 1. 

  5. New write while processing a write from the peer.
    Without further measures this would lead to an inconsistency in 
    our mirror as the figure on the left side shows. 
    If we currently write a conflicting block from the peer, we simply
    discard the write request from our FS and signal IO completion 
    immediately.

  6. High disk latency on N2.
    By IO reordering in the layers below us this could lead to 
    having the blue data on N2 and the green data on N1. 
    The solution to this case is the delay the write to the local
    disk on N2 until the local write is done. This is different from
    case two since we already got the write ACK to the conflicting
    block.

  7. An data packet overtakes an ACK packet on the network.
    Although this case is quite unlikely, we have to take int into 
    account. 

 Proposed solution

  We arbitrary select one node (e.g. the node that did the first
  accept() in the drbd_connect() function) and mark it withe the
  discard-concurrent-writes-flag.

  Each data packet and each ACK packet gets a sequence 
  number, which is increased which every packet sent. 
  (This is a common space of sequence numbers)

  The algorithm which is performed upon the reception of a 
  data packet [drbd_receiver].

  *  If the sequence number of the data packet is higher than
     last_seq+1 sleep until last_seq-1 == seq_num(data packet)

  1. If the packet's sequence number is on the discard list,
     simply drop it.
  2. Do we have a concurrent request? (i.e. Do I have a request
     to the same block in my transfer log.) If not -> write now.
  3. Have I already got an ACK packet for the concurrent 
     request ? (Has the request the RQ_DRBD_SENT bit already set)
     If yes -> write the data from the data packet afterwards.
  4. Do I have the "discard-concurrent-write-flag" ?
     If yes -> discard the data packet.
     If no -> Write data from the data packet afterwards and set
              the RQ_DRBD_SENT bit in the request object ( Since
              will will not get an ACK from our peer )

  The algorithm which is performed upon the reception of an 
  ACK packet [drbd_asender]

  * If we get an ACK, store the sequence number in last_seq.

  The algorithm which is performed upon the reception of an 
  discard info packet [drbd_asender]

  * if the current last_seq is lower the the packet that should
    be discarded, store it in the to discard list.

  BTW, each time we have a concurrent write access, we print
  a warning to the syslog, since this indicates that the layer
  above us is broken!

  Note: In Item 6 we created a hash table over all requests in the
        transfer log, keyed with (sector & ~0x7). This allows us
        to find IO operations starting in the same 4k block of
        data quickly. -> With two lookups the hash table we can
	find any concurrent access.

--Boundary-00=_JjoZBTZvvlTG/Q7--
