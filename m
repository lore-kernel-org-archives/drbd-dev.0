Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E160F1056477
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id DB20D2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KDB2ffwS6hhX for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BAA6247E279
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mAhEm_KVTpQZ for <drbd-dev@lists.linbit.com>;
	Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 94A7B2AE03B
	for <drbd-dev@lists.linbit.com>; Mon,  3 Oct 2016 16:46:27 +0200 (CEST)
Resent-Message-ID: <20161003144627.GI3302@soda.linbit>
Received: from mail3-relais-sop.national.inria.fr
	(mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 4B7C6105646D
	for <drbd-dev@lists.linbit.com>; Sat,  1 Oct 2016 22:14:59 +0200 (CEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-metag@vger.kernel.org
Date: Sat,  1 Oct 2016 21:46:17 +0200
Message-Id: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-mtd@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH 00/15] improve function-level documentation
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

These patches fix cases where the documentation above a function definition
is not consistent with the function header.  Issues are detected using the
semantic patch below (http://coccinelle.lip6.fr/).  Basically, the semantic
patch parses a file to find comments, then matches each function header,
and checks that the name and parameter list in the function header are
compatible with the comment that preceeds it most closely.

// <smpl>
@initialize:ocaml@
@@

let tbl = ref []
let fnstart = ref []
let success = Hashtbl.create 101
let thefile = ref ""
let parsed = ref []
let nea = ref []

let parse file =
  thefile := List.nth (Str.split (Str.regexp "linux-next/") file) 1;
  let i = open_in file in
  let startline = ref 0 in
  let fn = ref "" in
  let ids = ref [] in
  let rec inside n =
    let l = input_line i in
    let n = n + 1 in
    match Str.split_delim (Str.regexp_string "*/") l with
      before::after::_ ->
	(if not (!fn = "")
	then tbl := (!startline,n,!fn,List.rev !ids)::!tbl);
	startline := 0;
	fn := "";
	ids := [];
	outside n
    | _ ->
	(match Str.split (Str.regexp "[ \t]+") l with
	  "*"::name::rest ->
	    let len = String.length name in
	    (if !fn = "" && len > 2 && String.sub name (len-2) 2 = "()"
	    then fn := String.sub name 0 (len-2)
	    else if !fn = "" && (not (rest = [])) && List.hd rest = "-"
	    then
	      if String.get name (len-1) = ':'
	      then fn := String.sub name 0 (len-1)
	      else fn := name
	    else if not(!fn = "") && len > 2 &&
	      String.get name 0 = '@' && String.get name (len-1) = ':'
	    then ids := (String.sub name 1 (len-2)) :: !ids);
	| _ -> ());
	inside n
  and outside n =
    let l = input_line i in
    let n = n + 1 in
    if String.length l > 2 && String.sub l 0 3 = "/**"
    then
      begin
	startline := n;
	inside n
      end
    else outside n in
  try outside 0 with End_of_file -> ()

let hashadd tbl k v =
  let cell =
    try Hashtbl.find tbl k
    with Not_found ->
      let cell = ref [] in
      Hashtbl.add tbl k cell;
      cell in
  cell := v :: !cell

@script:ocaml@
@@

tbl := [];
fnstart := [];
Hashtbl.clear success;
parsed := [];
nea := [];
parse (List.hd (Coccilib.files()))

@r@
identifier f;
position p;
@@

f@p(...) { ... }

@script:ocaml@
p << r.p;
f << r.f;
@@

parsed := f :: !parsed;
fnstart := (List.hd p).line :: !fnstart

@param@
identifier f;
type T;
identifier i;
parameter list[n] ps;
parameter list[n1] ps1;
position p;
@@

f@p(ps,T i,ps1) { ... }

@script:ocaml@
@@

tbl := List.rev (List.sort compare !tbl)

@script:ocaml@
p << param.p;
f << param.f;
@@

let myline = (List.hd p).line in
let prevline =
  List.fold_left
    (fun prev x ->
      if x < myline
      then max x prev
      else prev)
    0 !fnstart in
let _ =
  List.exists
    (function (st,fn,nm,ids) ->
      if prevline < st && myline > st && prevline < fn && myline > fn
      then
	begin
	  (if not (String.lowercase f = String.lowercase nm)
	  then
	    Printf.printf "%s:%d %s doesn't match preceding comment: %s\n"
	      !thefile myline f nm);
	  true
	end
      else false)
    !tbl in
()

@script:ocaml@
p << param.p;
n << param.n;
n1 << param.n1;
i << param.i;
f << param.f;
@@

let myline = (List.hd p).line in
let prevline =
  List.fold_left
    (fun prev x ->
      if x < myline
      then max x prev
      else prev)
    0 !fnstart in
let _ =
  List.exists
    (function (st,fn,nm,ids) ->
      if prevline < st && myline > st && prevline < fn && myline > fn
      then
	begin
	  (if List.mem i ids then hashadd success (st,fn,nm) i);
	  (if ids = [] (* arg list seems not obligatory *)
	  then ()
	  else if not (List.mem i ids)
	  then
	    Printf.printf "%s:%d %s doesn't appear in ids: %s\n"
	      !thefile myline i (String.concat " " ids)
	  else if List.length ids <= n || List.length ids <= n1
	  then
	    (if not (List.mem f !nea)
	    then
	      begin
		nea := f :: !nea;
		Printf.printf "%s:%d %s not enough args\n" !thefile myline f;
	      end)
	  else
	    let foundid = List.nth ids n in
	    let efoundid = List.nth (List.rev ids) n1 in
	    if not(foundid = i || efoundid = i)
	    then
	      Printf.printf "%s:%d %s wrong arg in position %d: %s\n"
		!thefile myline i n foundid);
	  true
	end
      else false)
    !tbl in
()

@script:ocaml@
@@
List.iter
  (function (st,fn,nm,ids) ->
    if List.mem nm !parsed
    then
      let entry =
	try !(Hashtbl.find success (st,fn,nm))
	with Not_found -> [] in
      List.iter
	(fun id ->
	  if not (List.mem id entry) && not (id = "...")
	  then Printf.printf "%s:%d %s not used\n" !thefile st id)
	ids)
  !tbl
// </smpl>


---

 drivers/clk/keystone/pll.c               |    4 ++--
 drivers/clk/sunxi/clk-mod0.c             |    2 +-
 drivers/clk/tegra/cvb.c                  |   10 +++++-----
 drivers/dma-buf/sw_sync.c                |    6 +++---
 drivers/gpu/drm/gma500/intel_i2c.c       |    3 +--
 drivers/gpu/drm/omapdrm/omap_drv.c       |    4 ++--
 drivers/irqchip/irq-metag-ext.c          |    1 -
 drivers/irqchip/irq-vic.c                |    1 -
 drivers/mfd/tc3589x.c                    |    4 ++--
 drivers/power/supply/ab8500_fg.c         |    8 ++++----
 drivers/power/supply/abx500_chargalg.c   |    1 +
 drivers/power/supply/intel_mid_battery.c |    2 +-
 drivers/power/supply/power_supply_core.c |    4 ++--
 fs/crypto/crypto.c                       |    4 ++--
 fs/crypto/fname.c                        |    4 ++--
 fs/ubifs/file.c                          |    2 +-
 fs/ubifs/gc.c                            |    2 +-
 fs/ubifs/lprops.c                        |    2 +-
 fs/ubifs/lpt_commit.c                    |    4 +---
 fs/ubifs/replay.c                        |    2 +-
 lib/kobject_uevent.c                     |    6 +++---
 lib/lru_cache.c                          |    4 ++--
 lib/nlattr.c                             |    2 +-
 23 files changed, 39 insertions(+), 43 deletions(-)
