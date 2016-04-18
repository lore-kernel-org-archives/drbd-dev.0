Return-Path: <jhkim@mantech.co.kr>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id F26A11051881
	for <drbd-dev@lists.linbit.com>; Mon, 18 Apr 2016 16:05:39 +0200 (CEST)
Received: by mail-vk0-f51.google.com with SMTP id e185so220894525vkb.1
	for <drbd-dev@lists.linbit.com>; Mon, 18 Apr 2016 07:05:39 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 Apr 2016 23:05:38 +0900
Message-ID: <CAF6H8oE5pdNi9ZKeRCwYXz78ZOBM+2vEP1CXZw6DJriKXXPdtQ@mail.gmail.com>
From: Jaeheon Kim <jhkim@mantech.co.kr>
To: drbd-dev@lists.linbit.com
Content-Type: multipart/alternative; boundary=001a113b0a9cef21a90530c2da9f
Subject: Re: [Drbd-dev] [CASE-41] After re-connected,
 despite of OOS remaining primary does not start re-synchronization
 or continues AHEAD mode.
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

--001a113b0a9cef21a90530c2da9f
Content-Type: text/plain; charset=UTF-8

Dear Phil,

We made a code to avoid OOS remainder problem.
If the status is L_AHEAD at conn_try_disconnect(), we have to wait until
 the state changes to SyncSource and meta-data be flushed by drbd_md_sync().

What do think about our temporary workaround?

Thanks.



PS. source code:

1. drbd/drbd_int.h ========================================

    struct {/* sender todo per peer_device */
        bool was_ahead;
    } todo;
#ifdef _WIN32_OOS_TEST
    wait_queue_head_t resync_start_wait;
    int resync_start_flag;
#endif
};

struct submit_worker {



2. drbd/drbd_main.c ======================================

    peer_device->resync_finished_pdsk = D_UNKNOWN;

    INIT_WORK(&peer_device->send_acks_work, drbd_send_acks_wf);

#ifdef _WIN32_OOS_TEST
    init_waitqueue_head(&peer_device->resync_start_wait);
    peer_device->resync_start_flag = 0;
#endif
    return peer_device;
}


3. drbd/drbd_nl.c ======================================

static enum drbd_state_rv conn_try_disconnect(struct drbd_connection
*connection, bool force)
{
struct drbd_resource *resource = connection->resource;
enum drbd_state_rv rv;

#ifdef _WIN32_OOS_TEST
// First, Check whether reresync-action occurred or not after AHEAD
{
struct drbd_peer_device *peer_device = conn_peer_device(connection, 0);

DbgPrint("_WIN32_OOS_TEST:conn_try_disconnect: Please check whether
resync-action occurred or not.");
if (peer_device->repl_state[NOW] == L_AHEAD) // check AHEAD status only
{
if (peer_device->resync_start_flag > 0)
{
DbgPrint("_WIN32_OOS_TEST: resync action started already. flag=%d\n",
peer_device->resync_start_flag);
}
else
{
DbgPrint("_WIN32_OOS_TEST: Wait for resync start...\n");// It will update
status and meta data on each node, maybe.

long t = 0; // if 5 seconds exceeding, drbdadm disconnect CLI will be
timeout.
wait_event_timeout(t, peer_device->resync_start_wait,
(peer_device->resync_start_flag > 0), 3000);

if (t == 0)
{
DbgPrint("_WIN32_OOS_TEST: timeout! t=%d. No resync_start_wait event. So,
You can see AHEAD pending problem\n", t);
}
else
{
DbgPrint("_WIN32_OOS_TEST: OK! got it! time=%d\n", t);
}
}
peer_device->resync_start_flag = 0; // reset
}
else
{
DbgPrint("_WIN32_OOS_TEST: repl mode=(%s).",
drbd_repl_str(peer_device->repl_state[NOW]));
}
}
#endif

    repeat:



4. drbd/drbd_sender.c ======================================

Part
1)---------------------------------------------------------------------------
            drbd_khelper(NULL, connection, "unfence-peer");
    }

#ifdef _WIN32_OOS_TEST
    if (peer_device->resync_start_flag > 0)
    {
        DbgPrint("_WIN32_OOS_TEST:drbd_resync_finished:
resync_start_flag=%d. reset!", peer_device->resync_start_flag);
        peer_device->resync_start_flag = 0;
    }
#endif

    return 1;
}

Part
2)-----------------------------------------------------------------------------

    spin_lock_irq(&device->resource->req_lock);
    repl_state = peer_device->repl_state[NOW];
    spin_unlock_irq(&device->resource->req_lock);

#ifdef _WIN32_OOS_TEST
    int first_state = repl_state;
    DbgPrint("_WIN32_OOS_TEST:(%s) drbd_start_resync: repl(%s) side(%s)",
current->comm, drbd_repl_str(repl_state), drbd_repl_str(side));
#endif

    if (repl_state < L_ESTABLISHED) {
        /* Connection closed meanwhile. */
        return;


Part
3)----------------------------------------------------------------------------

            mod_timer(&peer_device->resync_timer, jiffies);

        drbd_md_sync(device);

#ifdef _WIN32_OOS_TEST
        if (first_state == L_AHEAD)
        {
            peer_device->resync_start_flag++;
            DbgPrint("_WIN32_OOS_TEST: Resync start at AHEAD status.
flag=%d. drbdadm disconnect CLI maybe wake up if exists",
peer_device->resync_start_flag);
            wake_up(&peer_device->resync_start_wait);
        }
        else
        {
            DbgPrint("_WIN32_OOS_TEST: flag=%d\n",
peer_device->resync_start_flag);
        }
#endif

    }
    put_ldev(device);
    out:


------------------------------------------------------------------------------

--001a113b0a9cef21a90530c2da9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear Phil,</div><div><br></div><div>We made a code to=
 avoid OOS remainder problem.</div><div>If the status is L_AHEAD at conn_tr=
y_disconnect(), we have to wait until =C2=A0the state changes to SyncSource=
 and meta-data be flushed by drbd_md_sync().</div><div><br></div><div>What =
do think about our temporary workaround?</div><div><br></div><div>Thanks.</=
div><div><br></div><div><br></div><div><br></div><div>PS. source code:</div=
><div><br></div><div>1. drbd/drbd_int.h =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div><br></div><div>=C2=A0 =C2=A0 struct {/* sender todo =
per peer_device */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool was_ahead;</d=
iv><div>=C2=A0 =C2=A0 } todo;</div><div>#ifdef _WIN32_OOS_TEST</div><div>=
=C2=A0 =C2=A0 wait_queue_head_t resync_start_wait;</div><div>=C2=A0 =C2=A0 =
int resync_start_flag;</div><div>#endif</div><div>};</div><div><br></div><d=
iv>struct submit_worker {</div><div><br></div><div><br></div><div><br></div=
><div>2. drbd/drbd_main.c =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><di=
v><br></div><div>=C2=A0 =C2=A0 peer_device-&gt;resync_finished_pdsk =3D D_U=
NKNOWN;</div><div><br></div><div>=C2=A0 =C2=A0 INIT_WORK(&amp;peer_device-&=
gt;send_acks_work, drbd_send_acks_wf);</div><div><br></div><div>#ifdef _WIN=
32_OOS_TEST</div><div>=C2=A0 =C2=A0 init_waitqueue_head(&amp;peer_device-&g=
t;resync_start_wait);</div><div>=C2=A0 =C2=A0 peer_device-&gt;resync_start_=
flag =3D 0;</div><div>#endif</div><div>=C2=A0 =C2=A0 return peer_device;</d=
iv><div>}</div><div><br></div><div><br></div><div>3. drbd/drbd_nl.c =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div>static enum drbd=
_state_rv conn_try_disconnect(struct drbd_connection *connection, bool forc=
e)</div><div>{</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>struct drbd_resource *resource =3D connection-&gt;resource;</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>enum drbd_state_rv rv;</div>=
<div><br></div><div>#ifdef _WIN32_OOS_TEST</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>// First, Check whether reresync-action occurr=
ed or not after AHEAD=C2=A0</div><div><span class=3D"" style=3D"white-space=
:pre">	</span>{</div><div><span class=3D"" style=3D"white-space:pre">		</sp=
an>struct drbd_peer_device *peer_device =3D conn_peer_device(connection, 0)=
;</div><div><br></div><div><span class=3D"" style=3D"white-space:pre">		</s=
pan>DbgPrint(&quot;_WIN32_OOS_TEST:conn_try_disconnect: Please check whethe=
r resync-action occurred or not.&quot;);</div><div><span class=3D"" style=
=3D"white-space:pre">		</span>if (peer_device-&gt;repl_state[NOW] =3D=3D L_=
AHEAD) // check AHEAD status only</div><div><span class=3D"" style=3D"white=
-space:pre">		</span>{</div><div><span class=3D"" style=3D"white-space:pre"=
>			</span>if (peer_device-&gt;resync_start_flag &gt; 0)</div><div><span cl=
ass=3D"" style=3D"white-space:pre">			</span>{</div><div><span class=3D"" s=
tyle=3D"white-space:pre">				</span>DbgPrint(&quot;_WIN32_OOS_TEST: resync =
action started already. flag=3D%d\n&quot;, peer_device-&gt;resync_start_fla=
g);</div><div><span class=3D"" style=3D"white-space:pre">			</span>}</div><=
div><span class=3D"" style=3D"white-space:pre">			</span>else</div><div><sp=
an class=3D"" style=3D"white-space:pre">			</span>{</div><div><span class=
=3D"" style=3D"white-space:pre">				</span>DbgPrint(&quot;_WIN32_OOS_TEST: =
Wait for resync start...\n&quot;);// It will update status and meta data on=
 each node, maybe.</div><div><br></div><div><span class=3D"" style=3D"white=
-space:pre">				</span>long t =3D 0; // if 5 seconds exceeding, drbdadm dis=
connect CLI will be timeout.</div><div><span class=3D"" style=3D"white-spac=
e:pre">				</span>wait_event_timeout(t, peer_device-&gt;resync_start_wait, =
(peer_device-&gt;resync_start_flag &gt; 0), 3000);</div><div><br></div><div=
><span class=3D"" style=3D"white-space:pre">				</span>if (t =3D=3D 0)</div=
><div><span class=3D"" style=3D"white-space:pre">				</span>{</div><div><sp=
an class=3D"" style=3D"white-space:pre">					</span>DbgPrint(&quot;_WIN32_O=
OS_TEST: timeout! t=3D%d. No resync_start_wait event. So, You can see AHEAD=
 pending problem\n&quot;, t);</div><div><span class=3D"" style=3D"white-spa=
ce:pre">				</span>}</div><div><span class=3D"" style=3D"white-space:pre">	=
			</span>else</div><div><span class=3D"" style=3D"white-space:pre">				</s=
pan>{</div><div><span class=3D"" style=3D"white-space:pre">					</span>DbgP=
rint(&quot;_WIN32_OOS_TEST: OK! got it! time=3D%d\n&quot;, t);</div><div><s=
pan class=3D"" style=3D"white-space:pre">				</span>}</div><div><span class=
=3D"" style=3D"white-space:pre">			</span>}</div><div><span class=3D"" styl=
e=3D"white-space:pre">			</span>peer_device-&gt;resync_start_flag =3D 0; //=
 reset</div><div><span class=3D"" style=3D"white-space:pre">		</span>}</div=
><div><span class=3D"" style=3D"white-space:pre">		</span>else</div><div><s=
pan class=3D"" style=3D"white-space:pre">		</span>{</div><div><span class=
=3D"" style=3D"white-space:pre">			</span>DbgPrint(&quot;_WIN32_OOS_TEST: r=
epl mode=3D(%s).&quot;, drbd_repl_str(peer_device-&gt;repl_state[NOW]));</d=
iv><div><span class=3D"" style=3D"white-space:pre">		</span>}</div><div><sp=
an class=3D"" style=3D"white-space:pre">	</span>}</div><div>#endif</div><di=
v><br></div><div>=C2=A0 =C2=A0 repeat:</div><div><br></div><div><br></div><=
div><br></div><div>4. drbd/drbd_sender.c =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</div><div><br></div><div>Part 1)------------------------------------=
---------------------------------------</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 drbd_khelper(NULL, connection, &quot;unfence-peer&quot;);=
</div><div>=C2=A0 =C2=A0 }</div><div><br></div><div>#ifdef _WIN32_OOS_TEST<=
/div><div>=C2=A0 =C2=A0 if (peer_device-&gt;resync_start_flag &gt; 0)</div>=
<div>=C2=A0 =C2=A0 {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 DbgPrint(&quot;_=
WIN32_OOS_TEST:drbd_resync_finished: resync_start_flag=3D%d. reset!&quot;, =
peer_device-&gt;resync_start_flag);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
eer_device-&gt;resync_start_flag =3D 0;</div><div>=C2=A0 =C2=A0 }</div><div=
>#endif</div><div><br></div><div>=C2=A0 =C2=A0 return 1;</div><div>}</div><=
div><br></div><div>Part 2)-------------------------------------------------=
----------------------------</div><div><br></div><div><div>=C2=A0 =C2=A0 sp=
in_lock_irq(&amp;device-&gt;resource-&gt;req_lock);</div><div>=C2=A0 =C2=A0=
 repl_state =3D peer_device-&gt;repl_state[NOW];</div><div>=C2=A0 =C2=A0 sp=
in_unlock_irq(&amp;device-&gt;resource-&gt;req_lock);</div><div><br></div><=
div>#ifdef _WIN32_OOS_TEST</div><div>=C2=A0 =C2=A0 int first_state =3D repl=
_state;</div><div>=C2=A0 =C2=A0 DbgPrint(&quot;_WIN32_OOS_TEST:(%s) drbd_st=
art_resync: repl(%s) side(%s)&quot;, current-&gt;comm, drbd_repl_str(repl_s=
tate), drbd_repl_str(side));</div><div>#endif</div><div><br></div><div>=C2=
=A0 =C2=A0 if (repl_state &lt; L_ESTABLISHED) {</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Connection closed meanwhile. */</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;</div><div><br></div></div><div><br></div><div>Part 3)---=
-------------------------------------------------------------------------</=
div><div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_=
timer(&amp;peer_device-&gt;resync_timer, jiffies);</div><div><br></div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 drbd_md_sync(device);</div><div><br></div><div=
>#ifdef _WIN32_OOS_TEST</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (first_sta=
te =3D=3D L_AHEAD)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 peer_device-&gt;resync_start_flag++;</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DbgPrint(&quot;_WIN32_OOS=
_TEST: Resync start at AHEAD status. flag=3D%d. drbdadm disconnect CLI mayb=
e wake up if exists&quot;, peer_device-&gt;resync_start_flag);</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wake_up(&amp;peer_device-&gt;resy=
nc_start_wait);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 else</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DbgPrint(&quot;_WIN32_OOS_TEST: =
flag=3D%d\n&quot;, peer_device-&gt;resync_start_flag);</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }</div><div>#endif</div><div><br></div><div>=C2=A0 =C2=A0=
 }</div><div>=C2=A0 =C2=A0 put_ldev(device);</div><div>=C2=A0 =C2=A0 out:</=
div><div><br></div></div><div><br></div><div>------------------------------=
------------------------------------------------</div><div><br></div><div><=
br></div></div>

--001a113b0a9cef21a90530c2da9f--
