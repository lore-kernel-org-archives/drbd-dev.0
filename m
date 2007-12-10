Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Drbd-dev] [PATCH] Proposed fix to 8.0.x to ALWAYS schedule
	afterstate processing
Date: Sun, 9 Dec 2007 21:05:10 -0500
Message-ID: <342BAC0A5467384983B586A6B0B376710761317C@EXNA.corp.stratus.com>
In-Reply-To: 342BAC0A5467384983B586A6B0B3767107613174@EXNA.corp.stratus.com
References: 342BAC0A5467384983B586A6B0B3767107613174@EXNA.corp.stratus.com
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: "Graham, Simon" <Simon.Graham@stratus.com>,
	<drbd-dev@lists.linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> As you may recall, I ran into a problem recently with some state
> changes
> being delivered via netlink out of order because some state changes do
> not get their after-state-change processing deferred to the worker
> thread - this is a big problem if you have code trying to track the
> state changes via the netlink mechanism. The suggested solution was to
> make the change to schedule ALL after state change processing to the
> worker thread and the attached patch does this, including the
> following:

We have found one issue with this patch -- we are now seeing occasional
messages:

BUG! md_sync_timer expired! Worker calls drbd_md_sync()

I _think_ this is because the meta data can be marked dirty in the after
state change processing and we now have some situations where this
happens after the code runs that writes the meta data -- I'm not sure
how terrible it is, but I think we should move the code that marks the
meta data dirty into _drbd_set_state() so it happens inline -- I don't
see any reason why it has to be done in the worker thread... what do you
think?

Simon
