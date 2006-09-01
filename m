Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 1 Sep 2006 13:52:13 -0400
Message-ID: <342BAC0A5467384983B586A6B0B376710377B6EA@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Confused by drbd_cmd structure definition in
	drbdsetup.c...
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've been noticing some crashes in drbdsetup when it is printing out the
list of commands and I find myself confused by the new drbd_cmd struct -
embedded in this, you have a union of a cp and a gp struct BUT the code
that prints command usage always just uses the cp element of the union -
I think this leads to segfaults because of this in
print_command_usage():

	if ((args =3D commands[i].cp.args)) {
		while (args->name) {
			col +=3D snprintf(line+col, maxcol-col, " %s",
args->name);
			args++;
		}
				=09
	}

Some elements (such as the "state" command entry) use the gp element of
the command to hold a function pointer which means that cp.args.name is
non-NULL and we try to dereference the function pointer as an argument
definition (and also attempt to move on to further argument definitions
which don't exist).

I'm a bit confused as to why this is defined as a union - is the fix to
remove the union wrapper?
Simon
