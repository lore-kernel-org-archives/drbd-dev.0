Return-Path: <mmazur@kernel.pl>
Received: from srv.axeos.nl (srv.axeos.nl [83.98.196.54])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 4CE21101AC75
	for <drbd-dev@lists.linbit.com>; Thu,  3 Jul 2014 15:07:28 +0200 (CEST)
From: Mariusz Mazur <mmazur@kernel.pl>
To: drbd-dev@lists.linbit.com
Date: Thu, 3 Jul 2014 15:07:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201407031507.18336.mmazur@kernel.pl>
Cc: Jacek Konieczny <jkonieczny@eggsoft.pl>
Subject: [Drbd-dev] stonith-related regression introduced around kernel 3.13,
	with 3.15.3 still affected
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

My setup is two nodes with drbd double master, corosync, pacemaker, clvmd, xen 
4.4.0.

Here's what happens when I reboot -f one of the nodes and the surviving node 
is kernel 3.12.23 or earlier (oldest tested was 3.6.something):

 [10512.040601] d-con vpbx_dev3: PingAck did not arrive in time.
 [10512.136930] d-con vpbx_dev3: peer( Primary -> Unknown ) conn( Connected -> 
NetworkFailure ) pdsk( UpToDate -> DUnknown ) susp( 0 -> 1 ) 
 [10512.346951] d-con vpbx_dev3: asender terminated
 [10512.443875] d-con vpbx_dev3: Terminating drbd_a_vpbx_dev
 [10512.540918] d-con vpbx_dev3: Connection closed
 [10512.636365] d-con vpbx_dev3: conn( NetworkFailure -> Unconnected ) 
 [10512.733924] d-con vpbx_dev3: receiver terminated
 [10512.829033] d-con vpbx_dev3: helper command: /sbin/drbdadm fence-peer 
vpbx_dev3
 [10512.924943] d-con vpbx_dev3: Restarting receiver thread
 [10513.022739] d-con vpbx_dev3: receiver (re)started
 [10513.116863] d-con vpbx_dev3: conn( Unconnected -> WFConnection ) 
 [10518.874822] dlm: closing connection to node 2
 [10519.468190] d-con vpbx_dev3: helper command: /sbin/drbdadm fence-peer 
vpbx_dev3 exit code 5 (0x500)
 [10519.604612] d-con vpbx_dev3: fence-peer helper returned 5 (peer is 
unreachable, assumed to be dead)                                                                                                           
 [10519.700071] d-con vpbx_dev3: pdsk( DUnknown -> Outdated )                                                                                                                                                     
 [10519.810474] block drbd0: new current UUID 
0E52D87F8EBDA1BB:A20A6CC6D7B5E6ED:2E667D8F22B5DA49:2E657D8F22B5DA49                                                                                                 
 [10519.943527] d-con vpbx_dev3: susp( 1 -> 0 )                                                                                                                                                                   
 [10522.114574] dlm: clvmd: dlm_recover 3                                                                                                                                                                         
 [10522.114619] dlm: clvmd: remove member 2                                                                                                                                                                       
 [10522.114623] dlm: clvmd: dlm_recover_members 1 nodes                                                                                                                                                           
 [10522.114626] dlm: clvmd: generation 17 slots 1 1:1                                                                                                                                                             
 [10522.114627] dlm: clvmd: dlm_recover_directory                                                                                                                                                                 
 [10522.114629] dlm: clvmd: dlm_recover_directory 0 in 0 new                                                                                                                                                      
 [10522.114631] dlm: clvmd: dlm_recover_directory 0 out 0 messages                                                                                                                                                
 [10522.114633] dlm: clvmd: dlm_recover_masters                                                                                                                                                                   
 [10522.114634] dlm: clvmd: dlm_recover_masters 0 of 0                                                                                                                                                            
 [10522.114636] dlm: clvmd: dlm_recover_locks 0 out                                                                                                                                                               
 [10522.114637] dlm: clvmd: dlm_recover_locks 0 in                                                                                                                                                                
 [10522.114662] dlm: clvmd: dlm_recover 3 generation 17 done: 0 ms                     

Everything seems fine, drbd remains accessible.

And here's what happens if the surviving node is running 3.13.6 (or 3.14.8 or 
3.15.3).

 [  382.002770] d-con vpbx_dev3: PingAck did not arrive in time.                                                                                                                                                  
 [  382.079354] d-con vpbx_dev3: peer( Primary -> Unknown ) conn( Connected -> 
NetworkFailure ) pdsk( UpToDate -> DUnknown ) susp( 0 -> 1 )                                                                       
 [  382.245092] d-con vpbx_dev3: asender terminated                                                                                                                                                               
 [  382.322803] d-con vpbx_dev3: Terminating drbd_a_vpbx_dev                                                                                                                                                      
 [  382.400862] d-con vpbx_dev3: Connection closed                                                                                                                                
 [  382.484773] d-con vpbx_dev3: out of mem, failed to invoke fence-peer 
helper                                                                                                   
 [  382.562487] d-con vpbx_dev3: conn( NetworkFailure -> Unconnected )                                                                                                            
 [  382.640106] d-con vpbx_dev3: receiver terminated                                                                                                                              
 [  382.717000] d-con vpbx_dev3: Restarting receiver thread                                                                                                                       
 [  382.793857] d-con vpbx_dev3: receiver (re)started                                                                                                                             
 [  382.869857] d-con vpbx_dev3: conn( Unconnected -> WFConnection )                                                                                                              
 [  384.326309] dlm: closing connection to node 1                                                                                                                                 
 [  387.172256] dlm: clvmd: dlm_recover 3                                                                                                                                         
 [  387.172303] dlm: clvmd: remove member 1                                                                                                                                       
 [  387.172306] dlm: clvmd: dlm_recover_members 1 nodes                                                                                                                           
 [  387.172309] dlm: clvmd: generation 19 slots 1 2:2                                                                                                                             
 [  387.172311] dlm: clvmd: dlm_recover_directory                                                                                                                                 
 [  387.172312] dlm: clvmd: dlm_recover_directory 0 in 0 new                                                                                                                    
 [  387.172314] dlm: clvmd: dlm_recover_directory 0 out 0 messages
 [  387.172316] dlm: clvmd: dlm_recover_masters
 [  387.172318] dlm: clvmd: dlm_recover_masters 0 of 0
 [  387.172320] dlm: clvmd: dlm_recover_locks 0 out
 [  387.172321] dlm: clvmd: dlm_recover_locks 0 in
 [  387.172345] dlm: clvmd: dlm_recover 3 generation 19 done: 0 ms

With the result being:
[root@dev3n2 ~]# cat /proc/drbd 
version: 8.4.3 (api:1/proto:86-101)
srcversion: F97798065516C94BE0F27DC 
 0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C s---d-
    ns:0 nr:0 dw:0 dr:264 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

And I need to reboot the node before drbd becomes operational again.

I won't have time to properly bisect this for a few weeks, though if somebody 
has a guess at what's wrong I can test a patch or provide more info.

--mmazur
