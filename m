Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (213-229-1-138.sdsl-line.inode.at [213.229.1.138])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id EA5561432E
	for <drbd-dev@lists.linbit.com>; Wed,  6 Oct 2004 13:54:59 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [RFC] (CRM and) DRBD (0.8) states and transistions,
	recovery strategies
Date: Wed, 6 Oct 2004 13:55:40 +0200
References: <yZEXPsg2gvkm1jq9tjYKNcg=lge@web.de>
	<200409291458.47753.philipp.reisner@linbit.com>
	<gp+4keo9JvnjO0Q6qwMw9f0=lge@web.de>
In-Reply-To: <gp+4keo9JvnjO0Q6qwMw9f0=lge@web.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_809YB6s876ZXpjG"
Message-Id: <200410061355.40551.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--Boundary-00=_809YB6s876ZXpjG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wednesday 29 September 2004 19:07, Lars Ellenberg wrote:
> / 2004-09-29 14:58:47 +0200
>
> \ Philipp Reisner:
> > > [...]
> > >
> > > >     Currently this covers only the states, and outlines the
> > > > transitions. It should help to define the actions to be taken on
> > > > every possible "input" to the DRBD internal "state machine".
> > >
> > > While reading through this giant e-mail I lost my confidence that it
> > > could be a good idea to have a "central" state switching function in
> > > DRBD, but of course I will see what this discussions gives...
> >
> > Thought about this a bit more... and came to the conclusion that it
> > would be a good idea. What do you think of this skeleton -
> > pseude code (it compiles actually).
>
> I think it probably should come out more like a real state machine,
> with a defined set of possible INPUTS,
> a defined set of states (which should not have the same detail depth as
> the actual drbd internal state set with all its different attributes),
> a set of actions, and a defined state[INPUT] => action => newstate
> matrix.
>
> maybe that is overkill.

Currently I want to go the way that was outlined with the new_st.c
skeleton.

Regarding: only worker should do state changes.
  We have quite a lot of inputs that are asynchronous by their nature.
  E.g. Disk fails. It does not make any sense to synchronize an advance
  in the disk-state state-machine with anything.

While it makes a lot of sense to synchronize changes to the node
state machine. 

At first I drew a directed graph of the cstates we have in 
drbd-0.7 (see cstates-7.ps)

You will immediately realize that the differentiation between
Unconfigured and StandAllone is a leftover from drbd-0.6

Then I drew directed graphs of the "state machines" as I see
them for drbd-0.8

conn-states-8.ps, disk-states-8.ps, node-states-8.ps (has 2 pages)

PS: The program is graphviz

-Philipp
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Schönbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :

--Boundary-00=_809YB6s876ZXpjG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="conn-states-8.dot"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="conn-states-8.dot"

digraph conn_states {
	StandAllone  -> WFConnection   [ label = "ioctl_set_net()" ]
	WFConnection -> Unconnected    [ label = "unable to bind()" ]
	WFConnection -> WFReportParams [ label = "in connect() after accept" ]
	WFReportParams -> StandAllone  [ label = "checks in receive_param()" ]
	WFReportParams -> Connected    [ label = "in receive_param()" ]
	WFReportParams -> WFBitMapS    [ label = "sync_handshake()" ]
	WFReportParams -> WFBitMapT    [ label = "sync_handshake()" ]
	WFBitMapS -> SyncSource        [ label = "receive_bitmap()" ]
	WFBitMapT -> SyncTarget        [ label = "receive_bitmap()" ]
	SyncSource -> Connected
	SyncTarget -> Connected
	SyncSource -> PausedSyncS
	SyncTarget -> PausedSyncT
	PausedSyncS -> SyncSource
	PausedSyncT -> SyncTarget
	Connected   -> WFConnection    [ label = "* on network error" ]
}

--Boundary-00=_809YB6s876ZXpjG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="disk-states-8.dot"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="disk-states-8.dot"

digraph disk_states {
	Diskless -> Inconsistent       [ label = "ioctl_set_disk()" ]
	Diskless -> Consistent         [ label = "ioctl_set_disk()" ]
	Diskless -> Outdated           [ label = "ioctl_set_disk()" ]
	Consistent -> Outdated         [ label = "receive_param()" ]
	Consistent -> UpToDate         [ label = "receive_param()" ]
	Consistent -> Inconsistent     [ label = "start resync" ]
	Outdated   -> Inconsistent     [ label = "start resync" ]
	UpToDate   -> Inconsistent     [ label = "ioctl_replicate" ]
	Inconsistent -> UpToDate       [ label = "resync completed" ]
	Consistent -> Failed           [ label = "io completion error" ]
	Outdated   -> Failed           [ label = "io completion error" ]
	UpToDate   -> Failed           [ label = "io completion error" ]
	Inconsistent -> Failed         [ label = "io completion error" ]
	Failed -> Diskless             [ label = "sending notify to peer" ]
}

--Boundary-00=_809YB6s876ZXpjG
Content-Type: application/postscript;
  name="disk-states-8.ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="disk-states-8.ps"

%!PS-Adobe-2.0
%%Creator: dot version 1.10.20030915.0415 (Fri Sep 19 09:37:53 MDT 2003)
%%For: (phil) Philipp Reisner,,,
%%Title: disk_state
%%Pages: (atend)
%%BoundingBox: 35 35 1074 591
%%EndComments
save
%%BeginProlog
/DotDict 200 dict def
DotDict begin

/setupLatin1 {
mark
/EncodingVector 256 array def
 EncodingVector 0

ISOLatin1Encoding 0 255 getinterval putinterval

EncodingVector
  dup 306 /AE
  dup 301 /Aacute
  dup 302 /Acircumflex
  dup 304 /Adieresis
  dup 300 /Agrave
  dup 305 /Aring
  dup 303 /Atilde
  dup 307 /Ccedilla
  dup 311 /Eacute
  dup 312 /Ecircumflex
  dup 313 /Edieresis
  dup 310 /Egrave
  dup 315 /Iacute
  dup 316 /Icircumflex
  dup 317 /Idieresis
  dup 314 /Igrave
  dup 334 /Udieresis
  dup 335 /Yacute
  dup 376 /thorn
  dup 337 /germandbls
  dup 341 /aacute
  dup 342 /acircumflex
  dup 344 /adieresis
  dup 346 /ae
  dup 340 /agrave
  dup 345 /aring
  dup 347 /ccedilla
  dup 351 /eacute
  dup 352 /ecircumflex
  dup 353 /edieresis
  dup 350 /egrave
  dup 355 /iacute
  dup 356 /icircumflex
  dup 357 /idieresis
  dup 354 /igrave
  dup 360 /dcroat
  dup 361 /ntilde
  dup 363 /oacute
  dup 364 /ocircumflex
  dup 366 /odieresis
  dup 362 /ograve
  dup 365 /otilde
  dup 370 /oslash
  dup 372 /uacute
  dup 373 /ucircumflex
  dup 374 /udieresis
  dup 371 /ugrave
  dup 375 /yacute
  dup 377 /ydieresis  

% Set up ISO Latin 1 character encoding
/starnetISO {
        dup dup findfont dup length dict begin
        { 1 index /FID ne { def }{ pop pop } ifelse
        } forall
        /Encoding EncodingVector def
        currentdict end definefont
} def
/Times-Roman starnetISO def
/Times-Italic starnetISO def
/Times-Bold starnetISO def
/Times-BoldItalic starnetISO def
/Helvetica starnetISO def
/Helvetica-Oblique starnetISO def
/Helvetica-Bold starnetISO def
/Helvetica-BoldOblique starnetISO def
/Courier starnetISO def
/Courier-Oblique starnetISO def
/Courier-Bold starnetISO def
/Courier-BoldOblique starnetISO def
cleartomark
} bind def

%%BeginResource: procset
/coord-font-family /Times-Roman def
/default-font-family /Times-Roman def
/coordfont coord-font-family findfont 8 scalefont def

/InvScaleFactor 1.0 def
/set_scale {
	dup 1 exch div /InvScaleFactor exch def
	dup scale
} bind def

% styles
/solid { [] 0 setdash } bind def
/dashed { [9 InvScaleFactor mul dup ] 0 setdash } bind def
/dotted { [1 InvScaleFactor mul 6 InvScaleFactor mul] 0 setdash } bind def
/invis {/fill {newpath} def /stroke {newpath} def /show {pop newpath} def} bind def
/bold { 2 setlinewidth } bind def
/filled { } bind def
/unfilled { } bind def
/rounded { } bind def
/diagonals { } bind def

% hooks for setting color 
/nodecolor { sethsbcolor } bind def
/edgecolor { sethsbcolor } bind def
/graphcolor { sethsbcolor } bind def
/nopcolor {pop pop pop} bind def

/beginpage {	% i j npages
	/npages exch def
	/j exch def
	/i exch def
	/str 10 string def
	npages 1 gt {
		gsave
			coordfont setfont
			0 0 moveto
			(\() show i str cvs show (,) show j str cvs show (\)) show
		grestore
	} if
} bind def

/set_font {
	findfont exch
	scalefont setfont
} def

% draw aligned label in bounding box aligned to current point
/alignedtext {			% width adj text
	/text exch def
	/adj exch def
	/width exch def
	gsave
		width 0 gt {
			text stringwidth pop adj mul 0 rmoveto
		} if
		[] 0 setdash
		text show
	grestore
} def

/boxprim {				% xcorner ycorner xsize ysize
		4 2 roll
		moveto
		2 copy
		exch 0 rlineto
		0 exch rlineto
		pop neg 0 rlineto
		closepath
} bind def

/ellipse_path {
	/ry exch def
	/rx exch def
	/y exch def
	/x exch def
	matrix currentmatrix
	newpath
	x y translate
	rx ry scale
	0 0 1 0 360 arc
	setmatrix
} bind def

/endpage { showpage } bind def
/showpage { } def

/layercolorseq
	[	% layer color sequence - darkest to lightest
		[0 0 0]
		[.2 .8 .8]
		[.4 .8 .8]
		[.6 .8 .8]
		[.8 .8 .8]
	]
def

/layerlen layercolorseq length def

/setlayer {/maxlayer exch def /curlayer exch def
	layercolorseq curlayer 1 sub layerlen mod get
	aload pop sethsbcolor
	/nodecolor {nopcolor} def
	/edgecolor {nopcolor} def
	/graphcolor {nopcolor} def
} bind def

/onlayer { curlayer ne {invis} if } def

/onlayers {
	/myupper exch def
	/mylower exch def
	curlayer mylower lt
	curlayer myupper gt
	or
	{invis} if
} def

/curlayer 0 def

%%EndResource
%%EndProlog
%%BeginSetup
14 default-font-family set_font
1 setmiterlimit
% /arrowlength 10 def
% /arrowwidth 5 def

% make sure pdfmark is harmless for PS-interpreters other than Distiller
/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse
% make '<<' and '>>' safe on PS Level 1 devices
/languagelevel where {pop languagelevel}{1} ifelse
2 lt {
    userdict (<<) cvn ([) cvn load put
    userdict (>>) cvn ([) cvn load put
} if

%%EndSetup
%%Page: 1 1
%%PageBoundingBox: 36 36 1074 591
%%PageOrientation: Portrait
gsave
35 35 1039 556 boxprim clip newpath
36 36 translate
0 0 1 beginpage
0 0 translate 0 rotate
0.000 0.000 0.000 graphcolor
14.00 /Times-Roman set_font

%	Diskless
gsave 10 dict begin
283 528 38 18 ellipse_path
stroke
gsave 10 dict begin
283 523 moveto 54 -0.5 (Diskless) alignedtext
end grestore
end grestore

%	Inconsistent
gsave 10 dict begin
214 252 51 18 ellipse_path
stroke
gsave 10 dict begin
214 247 moveto 81 -0.5 (Inconsistent) alignedtext
end grestore
end grestore

%	Diskless -> Inconsistent
newpath 267 511 moveto
245 488 209 445 195 400 curveto
182 359 194 309 204 279 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 206 280 moveto
207 270 lineto
201 279 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 206 280 moveto
207 270 lineto
201 279 lineto
closepath
stroke
end grestore
gsave 10 dict begin
254 385 moveto 104 -0.5 (ioctl_set_disk\(\)) alignedtext
end grestore

%	Consistent
gsave 10 dict begin
503 436 46 18 ellipse_path
stroke
gsave 10 dict begin
503 431 moveto 70 -0.5 (Consistent) alignedtext
end grestore
end grestore

%	Diskless -> Consistent
newpath 312 516 moveto
350 500 418 471 462 453 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 463 455 moveto
471 449 lineto
461 451 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 463 455 moveto
471 449 lineto
461 451 lineto
closepath
stroke
end grestore
gsave 10 dict begin
471 477 moveto 104 -0.5 (ioctl_set_disk\(\)) alignedtext
end grestore

%	Outdated
gsave 10 dict begin
58 344 42 18 ellipse_path
stroke
gsave 10 dict begin
58 339 moveto 63 -0.5 (Outdated) alignedtext
end grestore
end grestore

%	Diskless -> Outdated
newpath 248 521 moveto
192 509 86 484 63 454 curveto
45 430 47 394 52 370 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 54 372 moveto
53 362 lineto
49 372 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 54 372 moveto
53 362 lineto
49 372 lineto
closepath
stroke
end grestore
gsave 10 dict begin
125 431 moveto 104 -0.5 (ioctl_set_disk\(\)) alignedtext
end grestore

%	UpToDate
gsave 10 dict begin
407 160 47 18 ellipse_path
stroke
gsave 10 dict begin
407 155 moveto 72 -0.5 (UpToDate) alignedtext
end grestore
end grestore

%	Inconsistent -> UpToDate
newpath 215 234 moveto
216 221 220 205 231 196 curveto
267 163 292 188 340 178 curveto
347 177 354 175 361 173 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 360 176 moveto
369 171 lineto
359 171 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 360 176 moveto
369 171 lineto
359 171 lineto
closepath
stroke
end grestore
gsave 10 dict begin
298 201 moveto 120 -0.5 (resync completed) alignedtext
end grestore

%	Failed
gsave 10 dict begin
407 68 31 18 ellipse_path
stroke
gsave 10 dict begin
407 63 moveto 41 -0.5 (Failed) alignedtext
end grestore
end grestore

%	Inconsistent -> Failed
newpath 206 234 moveto
197 211 186 169 206 142 curveto
225 114 316 89 369 76 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 369 79 moveto
378 74 lineto
368 74 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 369 79 moveto
378 74 lineto
368 74 lineto
closepath
stroke
end grestore
gsave 10 dict begin
278 155 moveto 131 -0.5 (io completion error) alignedtext
end grestore

%	Consistent -> Inconsistent
newpath 504 418 moveto
504 406 502 390 493 380 curveto
475 360 461 371 437 362 curveto
369 334 294 295 251 272 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 252 270 moveto
242 267 lineto
250 274 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 252 270 moveto
242 267 lineto
250 274 lineto
closepath
stroke
end grestore
gsave 10 dict begin
490 339 moveto 79 -0.5 (start resync) alignedtext
end grestore

%	Consistent -> Outdated
newpath 463 427 moveto
434 421 396 411 363 400 curveto
341 392 338 386 317 380 curveto
246 360 163 351 110 347 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 110 345 moveto
100 346 lineto
110 349 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 110 345 moveto
100 346 lineto
110 349 lineto
closepath
stroke
end grestore
gsave 10 dict begin
432 385 moveto 112 -0.5 (receive_param\(\)) alignedtext
end grestore

%	Consistent -> UpToDate
newpath 513 418 moveto
520 403 530 382 534 362 curveto
548 288 552 252 503 196 curveto
491 183 475 175 460 170 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 461 168 moveto
451 167 lineto
460 173 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 461 168 moveto
451 167 lineto
460 173 lineto
closepath
stroke
end grestore
gsave 10 dict begin
605 293 moveto 112 -0.5 (receive_param\(\)) alignedtext
end grestore

%	Consistent -> Failed
newpath 542 426 moveto
619 409 698 425 698 344 curveto
698 344 698 344 698 160 curveto
698 108 526 81 447 72 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 448 70 moveto
438 71 lineto
448 75 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 448 70 moveto
438 71 lineto
448 75 lineto
closepath
stroke
end grestore
gsave 10 dict begin
770 247 moveto 131 -0.5 (io completion error) alignedtext
end grestore

%	Outdated -> Inconsistent
newpath 64 326 moveto
69 313 76 297 88 288 curveto
100 278 131 269 160 263 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 160 266 moveto
169 261 lineto
159 261 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 160 266 moveto
169 261 lineto
159 261 lineto
closepath
stroke
end grestore
gsave 10 dict begin
135 293 moveto 79 -0.5 (start resync) alignedtext
end grestore

%	Outdated -> Failed
newpath 50 326 moveto
39 296 22 237 46 196 curveto
126 64 215 91 367 70 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 366 73 moveto
376 69 lineto
366 68 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 366 73 moveto
376 69 lineto
366 68 lineto
closepath
stroke
end grestore
gsave 10 dict begin
118 201 moveto 131 -0.5 (io completion error) alignedtext
end grestore

%	UpToDate -> Inconsistent
newpath 401 178 moveto
396 190 388 206 375 216 curveto
358 228 311 237 272 243 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 271 241 moveto
262 245 lineto
272 245 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 271 241 moveto
262 245 lineto
272 245 lineto
closepath
stroke
end grestore
gsave 10 dict begin
444 201 moveto 95 -0.5 (ioctl_replicate) alignedtext
end grestore

%	UpToDate -> Failed
newpath 407 142 moveto
407 129 407 110 407 95 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 410 96 moveto
407 86 lineto
405 96 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 410 96 moveto
407 86 lineto
405 96 lineto
closepath
stroke
end grestore
gsave 10 dict begin
479 109 moveto 131 -0.5 (io completion error) alignedtext
end grestore

%	Failed -> Diskless
newpath 438 69 moveto
445 69 451 69 454 70 curveto
483 72 490 75 519 80 curveto
677 105 871 0 871 160 curveto
871 436 871 436 871 436 curveto
871 491 470 518 330 525 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 331 522 moveto
321 526 lineto
331 527 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 331 522 moveto
321 526 lineto
331 527 lineto
closepath
stroke
end grestore
gsave 10 dict begin
954 293 moveto 152 -0.5 (sending notify to peer) alignedtext
end grestore
endpage
showpage
grestore
%%PageTrailer
%%EndPage: 1
%%Trailer
%%Pages: 1
end
restore
%%EOF

--Boundary-00=_809YB6s876ZXpjG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="node-states-8.dot"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node-states-8.dot"

digraph node_states {
	Secondary -> Primary           [ label = "ioctl_set_state()" ]
	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
}

digraph peer_states {
	Secondary -> Primary           [ label = "recv state packet" ]
	Primary   -> Secondary 	       [ label = "recv state packet" ]
	Primary   -> Unknown 	       [ label = "connection lost" ]
	Secondary  -> Unknown  	       [ label = "connection lost" ]
	Unknown   -> Primary           [ label = "connected" ]
	Unknown   -> Secondary         [ label = "connected" ]
}


--Boundary-00=_809YB6s876ZXpjG
Content-Type: application/postscript;
  name="node-states-8.ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node-states-8.ps"

%!PS-Adobe-2.0
%%Creator: dot version 1.10.20030915.0415 (Fri Sep 19 09:37:53 MDT 2003)
%%For: (phil) Philipp Reisner,,,
%%Title: node_states
%%Pages: (atend)
%%BoundingBox: 35 35 331 181
%%EndComments
save
%%BeginProlog
/DotDict 200 dict def
DotDict begin

/setupLatin1 {
mark
/EncodingVector 256 array def
 EncodingVector 0

ISOLatin1Encoding 0 255 getinterval putinterval

EncodingVector
  dup 306 /AE
  dup 301 /Aacute
  dup 302 /Acircumflex
  dup 304 /Adieresis
  dup 300 /Agrave
  dup 305 /Aring
  dup 303 /Atilde
  dup 307 /Ccedilla
  dup 311 /Eacute
  dup 312 /Ecircumflex
  dup 313 /Edieresis
  dup 310 /Egrave
  dup 315 /Iacute
  dup 316 /Icircumflex
  dup 317 /Idieresis
  dup 314 /Igrave
  dup 334 /Udieresis
  dup 335 /Yacute
  dup 376 /thorn
  dup 337 /germandbls
  dup 341 /aacute
  dup 342 /acircumflex
  dup 344 /adieresis
  dup 346 /ae
  dup 340 /agrave
  dup 345 /aring
  dup 347 /ccedilla
  dup 351 /eacute
  dup 352 /ecircumflex
  dup 353 /edieresis
  dup 350 /egrave
  dup 355 /iacute
  dup 356 /icircumflex
  dup 357 /idieresis
  dup 354 /igrave
  dup 360 /dcroat
  dup 361 /ntilde
  dup 363 /oacute
  dup 364 /ocircumflex
  dup 366 /odieresis
  dup 362 /ograve
  dup 365 /otilde
  dup 370 /oslash
  dup 372 /uacute
  dup 373 /ucircumflex
  dup 374 /udieresis
  dup 371 /ugrave
  dup 375 /yacute
  dup 377 /ydieresis  

% Set up ISO Latin 1 character encoding
/starnetISO {
        dup dup findfont dup length dict begin
        { 1 index /FID ne { def }{ pop pop } ifelse
        } forall
        /Encoding EncodingVector def
        currentdict end definefont
} def
/Times-Roman starnetISO def
/Times-Italic starnetISO def
/Times-Bold starnetISO def
/Times-BoldItalic starnetISO def
/Helvetica starnetISO def
/Helvetica-Oblique starnetISO def
/Helvetica-Bold starnetISO def
/Helvetica-BoldOblique starnetISO def
/Courier starnetISO def
/Courier-Oblique starnetISO def
/Courier-Bold starnetISO def
/Courier-BoldOblique starnetISO def
cleartomark
} bind def

%%BeginResource: procset
/coord-font-family /Times-Roman def
/default-font-family /Times-Roman def
/coordfont coord-font-family findfont 8 scalefont def

/InvScaleFactor 1.0 def
/set_scale {
	dup 1 exch div /InvScaleFactor exch def
	dup scale
} bind def

% styles
/solid { [] 0 setdash } bind def
/dashed { [9 InvScaleFactor mul dup ] 0 setdash } bind def
/dotted { [1 InvScaleFactor mul 6 InvScaleFactor mul] 0 setdash } bind def
/invis {/fill {newpath} def /stroke {newpath} def /show {pop newpath} def} bind def
/bold { 2 setlinewidth } bind def
/filled { } bind def
/unfilled { } bind def
/rounded { } bind def
/diagonals { } bind def

% hooks for setting color 
/nodecolor { sethsbcolor } bind def
/edgecolor { sethsbcolor } bind def
/graphcolor { sethsbcolor } bind def
/nopcolor {pop pop pop} bind def

/beginpage {	% i j npages
	/npages exch def
	/j exch def
	/i exch def
	/str 10 string def
	npages 1 gt {
		gsave
			coordfont setfont
			0 0 moveto
			(\() show i str cvs show (,) show j str cvs show (\)) show
		grestore
	} if
} bind def

/set_font {
	findfont exch
	scalefont setfont
} def

% draw aligned label in bounding box aligned to current point
/alignedtext {			% width adj text
	/text exch def
	/adj exch def
	/width exch def
	gsave
		width 0 gt {
			text stringwidth pop adj mul 0 rmoveto
		} if
		[] 0 setdash
		text show
	grestore
} def

/boxprim {				% xcorner ycorner xsize ysize
		4 2 roll
		moveto
		2 copy
		exch 0 rlineto
		0 exch rlineto
		pop neg 0 rlineto
		closepath
} bind def

/ellipse_path {
	/ry exch def
	/rx exch def
	/y exch def
	/x exch def
	matrix currentmatrix
	newpath
	x y translate
	rx ry scale
	0 0 1 0 360 arc
	setmatrix
} bind def

/endpage { showpage } bind def
/showpage { } def

/layercolorseq
	[	% layer color sequence - darkest to lightest
		[0 0 0]
		[.2 .8 .8]
		[.4 .8 .8]
		[.6 .8 .8]
		[.8 .8 .8]
	]
def

/layerlen layercolorseq length def

/setlayer {/maxlayer exch def /curlayer exch def
	layercolorseq curlayer 1 sub layerlen mod get
	aload pop sethsbcolor
	/nodecolor {nopcolor} def
	/edgecolor {nopcolor} def
	/graphcolor {nopcolor} def
} bind def

/onlayer { curlayer ne {invis} if } def

/onlayers {
	/myupper exch def
	/mylower exch def
	curlayer mylower lt
	curlayer myupper gt
	or
	{invis} if
} def

/curlayer 0 def

%%EndResource
%%EndProlog
%%BeginSetup
14 default-font-family set_font
1 setmiterlimit
% /arrowlength 10 def
% /arrowwidth 5 def

% make sure pdfmark is harmless for PS-interpreters other than Distiller
/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse
% make '<<' and '>>' safe on PS Level 1 devices
/languagelevel where {pop languagelevel}{1} ifelse
2 lt {
    userdict (<<) cvn ([) cvn load put
    userdict (>>) cvn ([) cvn load put
} if

%%EndSetup
%%Page: 1 1
%%PageBoundingBox: 36 36 331 181
%%PageOrientation: Portrait
gsave
35 35 296 146 boxprim clip newpath
36 36 translate
0 0 1 beginpage
0 0 translate 0 rotate
0.000 0.000 0.000 graphcolor
14.00 /Times-Roman set_font

%	Secondary
gsave 10 dict begin
96 118 46 18 ellipse_path
stroke
gsave 10 dict begin
96 113 moveto 71 -0.5 (Secondary) alignedtext
end grestore
end grestore

%	Primary
gsave 10 dict begin
96 26 39 18 ellipse_path
stroke
gsave 10 dict begin
96 21 moveto 57 -0.5 (Primary) alignedtext
end grestore
end grestore

%	Secondary -> Primary
newpath 61 106 moveto
50 101 39 93 32 82 curveto
28 74 28 69 32 62 curveto
37 53 46 46 54 41 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 55 43 moveto
63 36 lineto
53 39 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 55 43 moveto
63 36 lineto
53 39 lineto
closepath
stroke
end grestore
gsave 10 dict begin
95 67 moveto 106 -0.5 (ioctl_set_state\(\)) alignedtext
end grestore

%	Primary -> Secondary
newpath 127 37 moveto
138 43 150 51 156 62 curveto
160 69 160 74 156 82 curveto
152 89 145 96 138 101 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 137 99 moveto
129 106 lineto
139 103 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 137 99 moveto
129 106 lineto
139 103 lineto
closepath
stroke
end grestore
gsave 10 dict begin
219 67 moveto 106 -0.5 (ioctl_set_state\(\)) alignedtext
end grestore
endpage
showpage
grestore
%%PageTrailer
%%EndPage: 1
%%Page: 2 2
%%PageBoundingBox: 36 36 609 273
%%PageOrientation: Portrait
gsave
35 35 574 238 boxprim clip newpath
36 36 translate
0 0 1 beginpage
0 0 translate 0 rotate
0.000 0.000 0.000 graphcolor
14.00 /Times-Roman set_font

%	Secondary
gsave 10 dict begin
260 210 46 18 ellipse_path
stroke
gsave 10 dict begin
260 205 moveto 71 -0.5 (Secondary) alignedtext
end grestore
end grestore

%	Primary
gsave 10 dict begin
129 118 39 18 ellipse_path
stroke
gsave 10 dict begin
129 113 moveto 57 -0.5 (Primary) alignedtext
end grestore
end grestore

%	Secondary -> Primary
newpath 215 206 moveto
152 200 44 187 32 174 curveto
13 152 49 136 83 127 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 84 129 moveto
93 125 lineto
83 125 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 84 129 moveto
93 125 lineto
83 125 lineto
closepath
stroke
end grestore
gsave 10 dict begin
100 159 moveto 114 -0.5 (recv state packet) alignedtext
end grestore

%	Unknown
gsave 10 dict begin
283 26 46 18 ellipse_path
stroke
gsave 10 dict begin
283 21 moveto 71 -0.5 (Unknown) alignedtext
end grestore
end grestore

%	Secondary -> Unknown
newpath 297 199 moveto
309 193 321 185 328 174 curveto
339 155 369 156 324 62 curveto
321 57 318 52 314 48 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 316 47 moveto
307 42 lineto
313 50 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 316 47 moveto
307 42 lineto
313 50 lineto
closepath
stroke
end grestore
gsave 10 dict begin
405 113 moveto 102 -0.5 (connection lost) alignedtext
end grestore

%	Primary -> Secondary
newpath 147 134 moveto
160 146 178 161 196 174 curveto
205 180 215 186 224 192 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 222 194 moveto
232 196 lineto
224 189 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 222 194 moveto
232 196 lineto
224 189 lineto
closepath
stroke
end grestore
gsave 10 dict begin
263 159 moveto 114 -0.5 (recv state packet) alignedtext
end grestore

%	Primary -> Unknown
newpath 107 103 moveto
93 91 79 75 90 62 curveto
107 41 177 32 228 29 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 227 32 moveto
237 28 lineto
227 27 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 227 32 moveto
237 28 lineto
227 27 lineto
closepath
stroke
end grestore
gsave 10 dict begin
150 67 moveto 102 -0.5 (connection lost) alignedtext
end grestore

%	Unknown -> Secondary
newpath 328 31 moveto
391 45 429 40 467 100 curveto
475 113 475 122 467 136 curveto
425 199 383 191 314 204 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 314 201 moveto
305 206 lineto
315 206 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 314 201 moveto
305 206 lineto
315 206 lineto
closepath
stroke
end grestore
gsave 10 dict begin
514 113 moveto 68 -0.5 (connected) alignedtext
end grestore

%	Unknown -> Primary
newpath 264 42 moveto
250 54 229 70 210 82 curveto
197 89 182 97 168 103 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 168 100 moveto
159 106 lineto
169 105 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 168 100 moveto
159 106 lineto
169 105 lineto
closepath
stroke
end grestore
gsave 10 dict begin
279 67 moveto 68 -0.5 (connected) alignedtext
end grestore
endpage
showpage
grestore
%%PageTrailer
%%EndPage: 2
%%Trailer
%%Pages: 2
end
restore
%%EOF

--Boundary-00=_809YB6s876ZXpjG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cstates-7.dot"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cstates-7.dot"

digraph cstate {
	Unconfigured -> StandAllone    [ label = "ioctl_set_disk()" ]
	StandAllone  -> Unconnected    [ label = "ioctl_set_net()" ]
	Unconfigured -> Unconnected    [ label = "ioctl_set_net()" ]
	Unconnected  -> WFConnection   [ label = "connect()[1]" ]
	WFConnection -> Unconnected    [ label = "unable to bind()" ]
	WFConnection -> WFReportParams [ label = "in connect() after accept" ]
	WFReportParams -> StandAllone  [ label = "checks in receive_param()" ]
	WFReportParams -> Connected    [ label = "in receive_param()" ]
	WFReportParams -> WFBitMapS    [ label = "sync_handshake()" ]
	WFReportParams -> WFBitMapT    [ label = "sync_handshake()" ]
	WFBitMapS -> SyncSource        [ label = "receive_bitmap()" ]
	WFBitMapT -> SyncTarget        [ label = "receive_bitmap()" ]
	SyncSource -> Connected
	SyncTarget -> Connected
	SyncSource -> PausedSyncS
	SyncTarget -> PausedSyncT
	PausedSyncS -> SyncSource
	PausedSyncT -> SyncTarget
	Connected   -> BrokenPipe       [ label = "* recv error" ]
	BrokenPipe  -> WFConnection     [ label = "connect()[1]" ]
	Connected   -> NetworkFailure   [ label = "* set by asender()" ]
	NetworkFailure -> WFConnection  [ label = "connect()[1]" ]
	Connected   -> Timeout          [ label = "* set drbd_send()" ]
	Timeout     -> WFConnection     [ label = "connect()[1]" ]
}

--Boundary-00=_809YB6s876ZXpjG
Content-Type: application/postscript;
  name="conn-states-8.ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="conn-states-8.ps"

%!PS-Adobe-2.0
%%Creator: dot version 1.10.20030915.0415 (Fri Sep 19 09:37:53 MDT 2003)
%%For: (phil) Philipp Reisner,,,
%%Title: conn_states
%%Pages: (atend)
%%BoundingBox: 35 35 772 531
%%EndComments
save
%%BeginProlog
/DotDict 200 dict def
DotDict begin

/setupLatin1 {
mark
/EncodingVector 256 array def
 EncodingVector 0

ISOLatin1Encoding 0 255 getinterval putinterval

EncodingVector
  dup 306 /AE
  dup 301 /Aacute
  dup 302 /Acircumflex
  dup 304 /Adieresis
  dup 300 /Agrave
  dup 305 /Aring
  dup 303 /Atilde
  dup 307 /Ccedilla
  dup 311 /Eacute
  dup 312 /Ecircumflex
  dup 313 /Edieresis
  dup 310 /Egrave
  dup 315 /Iacute
  dup 316 /Icircumflex
  dup 317 /Idieresis
  dup 314 /Igrave
  dup 334 /Udieresis
  dup 335 /Yacute
  dup 376 /thorn
  dup 337 /germandbls
  dup 341 /aacute
  dup 342 /acircumflex
  dup 344 /adieresis
  dup 346 /ae
  dup 340 /agrave
  dup 345 /aring
  dup 347 /ccedilla
  dup 351 /eacute
  dup 352 /ecircumflex
  dup 353 /edieresis
  dup 350 /egrave
  dup 355 /iacute
  dup 356 /icircumflex
  dup 357 /idieresis
  dup 354 /igrave
  dup 360 /dcroat
  dup 361 /ntilde
  dup 363 /oacute
  dup 364 /ocircumflex
  dup 366 /odieresis
  dup 362 /ograve
  dup 365 /otilde
  dup 370 /oslash
  dup 372 /uacute
  dup 373 /ucircumflex
  dup 374 /udieresis
  dup 371 /ugrave
  dup 375 /yacute
  dup 377 /ydieresis  

% Set up ISO Latin 1 character encoding
/starnetISO {
        dup dup findfont dup length dict begin
        { 1 index /FID ne { def }{ pop pop } ifelse
        } forall
        /Encoding EncodingVector def
        currentdict end definefont
} def
/Times-Roman starnetISO def
/Times-Italic starnetISO def
/Times-Bold starnetISO def
/Times-BoldItalic starnetISO def
/Helvetica starnetISO def
/Helvetica-Oblique starnetISO def
/Helvetica-Bold starnetISO def
/Helvetica-BoldOblique starnetISO def
/Courier starnetISO def
/Courier-Oblique starnetISO def
/Courier-Bold starnetISO def
/Courier-BoldOblique starnetISO def
cleartomark
} bind def

%%BeginResource: procset
/coord-font-family /Times-Roman def
/default-font-family /Times-Roman def
/coordfont coord-font-family findfont 8 scalefont def

/InvScaleFactor 1.0 def
/set_scale {
	dup 1 exch div /InvScaleFactor exch def
	dup scale
} bind def

% styles
/solid { [] 0 setdash } bind def
/dashed { [9 InvScaleFactor mul dup ] 0 setdash } bind def
/dotted { [1 InvScaleFactor mul 6 InvScaleFactor mul] 0 setdash } bind def
/invis {/fill {newpath} def /stroke {newpath} def /show {pop newpath} def} bind def
/bold { 2 setlinewidth } bind def
/filled { } bind def
/unfilled { } bind def
/rounded { } bind def
/diagonals { } bind def

% hooks for setting color 
/nodecolor { sethsbcolor } bind def
/edgecolor { sethsbcolor } bind def
/graphcolor { sethsbcolor } bind def
/nopcolor {pop pop pop} bind def

/beginpage {	% i j npages
	/npages exch def
	/j exch def
	/i exch def
	/str 10 string def
	npages 1 gt {
		gsave
			coordfont setfont
			0 0 moveto
			(\() show i str cvs show (,) show j str cvs show (\)) show
		grestore
	} if
} bind def

/set_font {
	findfont exch
	scalefont setfont
} def

% draw aligned label in bounding box aligned to current point
/alignedtext {			% width adj text
	/text exch def
	/adj exch def
	/width exch def
	gsave
		width 0 gt {
			text stringwidth pop adj mul 0 rmoveto
		} if
		[] 0 setdash
		text show
	grestore
} def

/boxprim {				% xcorner ycorner xsize ysize
		4 2 roll
		moveto
		2 copy
		exch 0 rlineto
		0 exch rlineto
		pop neg 0 rlineto
		closepath
} bind def

/ellipse_path {
	/ry exch def
	/rx exch def
	/y exch def
	/x exch def
	matrix currentmatrix
	newpath
	x y translate
	rx ry scale
	0 0 1 0 360 arc
	setmatrix
} bind def

/endpage { showpage } bind def
/showpage { } def

/layercolorseq
	[	% layer color sequence - darkest to lightest
		[0 0 0]
		[.2 .8 .8]
		[.4 .8 .8]
		[.6 .8 .8]
		[.8 .8 .8]
	]
def

/layerlen layercolorseq length def

/setlayer {/maxlayer exch def /curlayer exch def
	layercolorseq curlayer 1 sub layerlen mod get
	aload pop sethsbcolor
	/nodecolor {nopcolor} def
	/edgecolor {nopcolor} def
	/graphcolor {nopcolor} def
} bind def

/onlayer { curlayer ne {invis} if } def

/onlayers {
	/myupper exch def
	/mylower exch def
	curlayer mylower lt
	curlayer myupper gt
	or
	{invis} if
} def

/curlayer 0 def

%%EndResource
%%EndProlog
%%BeginSetup
14 default-font-family set_font
1 setmiterlimit
% /arrowlength 10 def
% /arrowwidth 5 def

% make sure pdfmark is harmless for PS-interpreters other than Distiller
/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse
% make '<<' and '>>' safe on PS Level 1 devices
/languagelevel where {pop languagelevel}{1} ifelse
2 lt {
    userdict (<<) cvn ([) cvn load put
    userdict (>>) cvn ([) cvn load put
} if

%%EndSetup
%%Page: 1 1
%%PageBoundingBox: 36 36 772 531
%%PageOrientation: Portrait
gsave
35 35 737 496 boxprim clip newpath
36 36 translate
0 0 1 beginpage
0 0 translate 0 rotate
0.000 0.000 0.000 graphcolor
14.00 /Times-Roman set_font

%	StandAllone
gsave 10 dict begin
101 468 53 18 ellipse_path
stroke
gsave 10 dict begin
101 463 moveto 85 -0.5 (StandAllone) alignedtext
end grestore
end grestore

%	WFConnection
gsave 10 dict begin
296 376 63 18 ellipse_path
stroke
gsave 10 dict begin
296 371 moveto 105 -0.5 (WFConnection) alignedtext
end grestore
end grestore

%	StandAllone -> WFConnection
newpath 132 453 moveto
165 437 218 413 255 395 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 255 398 moveto
263 391 lineto
253 393 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 255 398 moveto
263 391 lineto
253 393 lineto
closepath
stroke
end grestore
gsave 10 dict begin
271 417 moveto 97 -0.5 (ioctl_set_net\(\)) alignedtext
end grestore

%	Unconnected
gsave 10 dict begin
289 284 56 18 ellipse_path
stroke
gsave 10 dict begin
289 279 moveto 91 -0.5 (Unconnected) alignedtext
end grestore
end grestore

%	WFConnection -> Unconnected
newpath 295 358 moveto
294 345 293 326 292 311 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 295 312 moveto
291 302 lineto
290 312 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 295 312 moveto
291 302 lineto
290 312 lineto
closepath
stroke
end grestore
gsave 10 dict begin
354 325 moveto 110 -0.5 (unable to bind\(\)) alignedtext
end grestore

%	WFReportParams
gsave 10 dict begin
73 284 73 18 ellipse_path
stroke
gsave 10 dict begin
73 279 moveto 125 -0.5 (WFReportParams) alignedtext
end grestore
end grestore

%	WFConnection -> WFReportParams
newpath 249 364 moveto
239 362 229 360 219 358 curveto
169 348 148 368 107 340 curveto
96 333 88 321 83 310 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 86 310 moveto
79 302 lineto
81 312 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 86 310 moveto
79 302 lineto
81 312 lineto
closepath
stroke
end grestore
gsave 10 dict begin
200 325 moveto 166 -0.5 (in connect\(\) after accept) alignedtext
end grestore

%	WFReportParams -> StandAllone
newpath 57 302 moveto
40 324 17 361 30 394 curveto
39 415 56 433 71 446 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 69 447 moveto
78 452 lineto
72 444 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 69 447 moveto
78 452 lineto
72 444 lineto
closepath
stroke
end grestore
gsave 10 dict begin
127 371 moveto 180 -0.5 (checks in receive_param\(\)) alignedtext
end grestore

%	Connected
gsave 10 dict begin
330 26 47 18 ellipse_path
stroke
gsave 10 dict begin
330 21 moveto 72 -0.5 (Connected) alignedtext
end grestore
end grestore

%	WFReportParams -> Connected
newpath 132 273 moveto
163 267 197 258 210 248 curveto
244 221 296 104 319 52 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 321 54 moveto
323 44 lineto
316 52 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 321 54 moveto
323 44 lineto
316 52 lineto
closepath
stroke
end grestore
gsave 10 dict begin
351 141 moveto 130 -0.5 (in receive_param\(\)) alignedtext
end grestore

%	WFBitMapS
gsave 10 dict begin
62 192 54 18 ellipse_path
stroke
gsave 10 dict begin
62 187 moveto 87 -0.5 (WFBitMapS) alignedtext
end grestore
end grestore

%	WFReportParams -> WFBitMapS
newpath 71 266 moveto
69 253 67 234 65 219 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 68 220 moveto
64 210 lineto
63 220 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 68 220 moveto
64 210 lineto
63 220 lineto
closepath
stroke
end grestore
gsave 10 dict begin
137 233 moveto 125 -0.5 (sync_handshake\(\)) alignedtext
end grestore

%	WFBitMapT
gsave 10 dict begin
658 192 55 18 ellipse_path
stroke
gsave 10 dict begin
658 187 moveto 89 -0.5 (WFBitMapT) alignedtext
end grestore
end grestore

%	WFReportParams -> WFBitMapT
newpath 138 276 moveto
256 260 504 227 589 210 curveto
595 209 601 207 607 206 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 606 209 moveto
615 204 lineto
605 204 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 606 209 moveto
615 204 lineto
605 204 lineto
closepath
stroke
end grestore
gsave 10 dict begin
543 233 moveto 125 -0.5 (sync_handshake\(\)) alignedtext
end grestore

%	Connected -> WFConnection
newpath 361 40 moveto
394 55 441 80 441 100 curveto
441 284 441 284 441 284 curveto
441 310 439 321 420 340 curveto
410 349 383 357 357 364 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 357 361 moveto
348 366 lineto
358 366 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 357 361 moveto
348 366 lineto
358 366 lineto
closepath
stroke
end grestore
gsave 10 dict begin
513 187 moveto 130 -0.5 (* on network error) alignedtext
end grestore

%	SyncSource
gsave 10 dict begin
83 100 50 18 ellipse_path
stroke
gsave 10 dict begin
83 95 moveto 79 -0.5 (SyncSource) alignedtext
end grestore
end grestore

%	WFBitMapS -> SyncSource
newpath 66 174 moveto
69 161 73 142 77 127 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 79 128 moveto
79 118 lineto
74 127 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 79 128 moveto
79 118 lineto
74 127 lineto
closepath
stroke
end grestore
gsave 10 dict begin
138 141 moveto 116 -0.5 (receive_bitmap\(\)) alignedtext
end grestore

%	SyncTarget
gsave 10 dict begin
553 100 50 18 ellipse_path
stroke
gsave 10 dict begin
553 95 moveto 78 -0.5 (SyncTarget) alignedtext
end grestore
end grestore

%	WFBitMapT -> SyncTarget
newpath 632 176 moveto
623 170 613 163 605 156 curveto
594 146 582 134 573 124 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 575 123 moveto
567 117 lineto
572 126 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 575 123 moveto
567 117 lineto
572 126 lineto
closepath
stroke
end grestore
gsave 10 dict begin
670 141 moveto 116 -0.5 (receive_bitmap\(\)) alignedtext
end grestore

%	SyncSource -> Connected
newpath 122 88 moveto
165 76 238 54 285 40 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 285 43 moveto
293 37 lineto
283 38 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 285 43 moveto
293 37 lineto
283 38 lineto
closepath
stroke
end grestore

%	PausedSyncS
gsave 10 dict begin
83 26 56 18 ellipse_path
stroke
gsave 10 dict begin
83 21 moveto 90 -0.5 (PausedSyncS) alignedtext
end grestore
end grestore

%	SyncSource -> PausedSyncS
newpath 77 82 moveto
76 73 76 63 76 53 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 78 54 moveto
77 44 lineto
73 54 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 78 54 moveto
77 44 lineto
73 54 lineto
closepath
stroke
end grestore

%	SyncTarget -> Connected
newpath 518 87 moveto
498 79 485 72 455 62 curveto
429 53 401 45 378 38 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 379 36 moveto
369 36 lineto
378 41 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 379 36 moveto
369 36 lineto
378 41 lineto
closepath
stroke
end grestore

%	PausedSyncT
gsave 10 dict begin
553 26 57 18 ellipse_path
stroke
gsave 10 dict begin
553 21 moveto 92 -0.5 (PausedSyncT) alignedtext
end grestore
end grestore

%	SyncTarget -> PausedSyncT
newpath 547 82 moveto
546 73 546 63 546 53 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 548 54 moveto
547 44 lineto
543 54 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 548 54 moveto
547 44 lineto
543 54 lineto
closepath
stroke
end grestore

%	PausedSyncS -> SyncSource
newpath 89 44 moveto
90 52 90 62 90 72 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 88 72 moveto
89 82 lineto
92 72 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 88 72 moveto
89 82 lineto
92 72 lineto
closepath
stroke
end grestore

%	PausedSyncT -> SyncTarget
newpath 559 44 moveto
560 52 560 62 560 72 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 558 72 moveto
559 82 lineto
562 72 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 558 72 moveto
559 82 lineto
562 72 lineto
closepath
stroke
end grestore
endpage
showpage
grestore
%%PageTrailer
%%EndPage: 1
%%Trailer
%%Pages: 1
end
restore
%%EOF

--Boundary-00=_809YB6s876ZXpjG
Content-Type: application/postscript;
  name="cstates-7.ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cstates-7.ps"

%!PS-Adobe-2.0
%%Creator: dot version 1.10.20030915.0415 (Fri Sep 19 09:37:53 MDT 2003)
%%For: (phil) Philipp Reisner,,,
%%Title: cstate
%%Pages: (atend)
%%BoundingBox: 35 35 944 807
%%EndComments
save
%%BeginProlog
/DotDict 200 dict def
DotDict begin

/setupLatin1 {
mark
/EncodingVector 256 array def
 EncodingVector 0

ISOLatin1Encoding 0 255 getinterval putinterval

EncodingVector
  dup 306 /AE
  dup 301 /Aacute
  dup 302 /Acircumflex
  dup 304 /Adieresis
  dup 300 /Agrave
  dup 305 /Aring
  dup 303 /Atilde
  dup 307 /Ccedilla
  dup 311 /Eacute
  dup 312 /Ecircumflex
  dup 313 /Edieresis
  dup 310 /Egrave
  dup 315 /Iacute
  dup 316 /Icircumflex
  dup 317 /Idieresis
  dup 314 /Igrave
  dup 334 /Udieresis
  dup 335 /Yacute
  dup 376 /thorn
  dup 337 /germandbls
  dup 341 /aacute
  dup 342 /acircumflex
  dup 344 /adieresis
  dup 346 /ae
  dup 340 /agrave
  dup 345 /aring
  dup 347 /ccedilla
  dup 351 /eacute
  dup 352 /ecircumflex
  dup 353 /edieresis
  dup 350 /egrave
  dup 355 /iacute
  dup 356 /icircumflex
  dup 357 /idieresis
  dup 354 /igrave
  dup 360 /dcroat
  dup 361 /ntilde
  dup 363 /oacute
  dup 364 /ocircumflex
  dup 366 /odieresis
  dup 362 /ograve
  dup 365 /otilde
  dup 370 /oslash
  dup 372 /uacute
  dup 373 /ucircumflex
  dup 374 /udieresis
  dup 371 /ugrave
  dup 375 /yacute
  dup 377 /ydieresis  

% Set up ISO Latin 1 character encoding
/starnetISO {
        dup dup findfont dup length dict begin
        { 1 index /FID ne { def }{ pop pop } ifelse
        } forall
        /Encoding EncodingVector def
        currentdict end definefont
} def
/Times-Roman starnetISO def
/Times-Italic starnetISO def
/Times-Bold starnetISO def
/Times-BoldItalic starnetISO def
/Helvetica starnetISO def
/Helvetica-Oblique starnetISO def
/Helvetica-Bold starnetISO def
/Helvetica-BoldOblique starnetISO def
/Courier starnetISO def
/Courier-Oblique starnetISO def
/Courier-Bold starnetISO def
/Courier-BoldOblique starnetISO def
cleartomark
} bind def

%%BeginResource: procset
/coord-font-family /Times-Roman def
/default-font-family /Times-Roman def
/coordfont coord-font-family findfont 8 scalefont def

/InvScaleFactor 1.0 def
/set_scale {
	dup 1 exch div /InvScaleFactor exch def
	dup scale
} bind def

% styles
/solid { [] 0 setdash } bind def
/dashed { [9 InvScaleFactor mul dup ] 0 setdash } bind def
/dotted { [1 InvScaleFactor mul 6 InvScaleFactor mul] 0 setdash } bind def
/invis {/fill {newpath} def /stroke {newpath} def /show {pop newpath} def} bind def
/bold { 2 setlinewidth } bind def
/filled { } bind def
/unfilled { } bind def
/rounded { } bind def
/diagonals { } bind def

% hooks for setting color 
/nodecolor { sethsbcolor } bind def
/edgecolor { sethsbcolor } bind def
/graphcolor { sethsbcolor } bind def
/nopcolor {pop pop pop} bind def

/beginpage {	% i j npages
	/npages exch def
	/j exch def
	/i exch def
	/str 10 string def
	npages 1 gt {
		gsave
			coordfont setfont
			0 0 moveto
			(\() show i str cvs show (,) show j str cvs show (\)) show
		grestore
	} if
} bind def

/set_font {
	findfont exch
	scalefont setfont
} def

% draw aligned label in bounding box aligned to current point
/alignedtext {			% width adj text
	/text exch def
	/adj exch def
	/width exch def
	gsave
		width 0 gt {
			text stringwidth pop adj mul 0 rmoveto
		} if
		[] 0 setdash
		text show
	grestore
} def

/boxprim {				% xcorner ycorner xsize ysize
		4 2 roll
		moveto
		2 copy
		exch 0 rlineto
		0 exch rlineto
		pop neg 0 rlineto
		closepath
} bind def

/ellipse_path {
	/ry exch def
	/rx exch def
	/y exch def
	/x exch def
	matrix currentmatrix
	newpath
	x y translate
	rx ry scale
	0 0 1 0 360 arc
	setmatrix
} bind def

/endpage { showpage } bind def
/showpage { } def

/layercolorseq
	[	% layer color sequence - darkest to lightest
		[0 0 0]
		[.2 .8 .8]
		[.4 .8 .8]
		[.6 .8 .8]
		[.8 .8 .8]
	]
def

/layerlen layercolorseq length def

/setlayer {/maxlayer exch def /curlayer exch def
	layercolorseq curlayer 1 sub layerlen mod get
	aload pop sethsbcolor
	/nodecolor {nopcolor} def
	/edgecolor {nopcolor} def
	/graphcolor {nopcolor} def
} bind def

/onlayer { curlayer ne {invis} if } def

/onlayers {
	/myupper exch def
	/mylower exch def
	curlayer mylower lt
	curlayer myupper gt
	or
	{invis} if
} def

/curlayer 0 def

%%EndResource
%%EndProlog
%%BeginSetup
14 default-font-family set_font
1 setmiterlimit
% /arrowlength 10 def
% /arrowwidth 5 def

% make sure pdfmark is harmless for PS-interpreters other than Distiller
/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse
% make '<<' and '>>' safe on PS Level 1 devices
/languagelevel where {pop languagelevel}{1} ifelse
2 lt {
    userdict (<<) cvn ([) cvn load put
    userdict (>>) cvn ([) cvn load put
} if

%%EndSetup
%%Page: 1 1
%%PageBoundingBox: 36 36 944 807
%%PageOrientation: Portrait
gsave
35 35 909 772 boxprim clip newpath
36 36 translate
0 0 1 beginpage
0 0 translate 0 rotate
0.000 0.000 0.000 graphcolor
14.00 /Times-Roman set_font

%	Unconfigured
gsave 10 dict begin
175 744 60 18 ellipse_path
stroke
gsave 10 dict begin
175 739 moveto 98 -0.5 (Unconfigured) alignedtext
end grestore
end grestore

%	StandAllone
gsave 10 dict begin
102 652 53 18 ellipse_path
stroke
gsave 10 dict begin
102 647 moveto 85 -0.5 (StandAllone) alignedtext
end grestore
end grestore

%	Unconfigured -> StandAllone
newpath 141 729 moveto
132 724 123 717 116 708 curveto
110 700 107 689 105 679 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 108 679 moveto
103 670 lineto
103 680 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 108 679 moveto
103 670 lineto
103 680 lineto
closepath
stroke
end grestore
gsave 10 dict begin
178 693 moveto 104 -0.5 (ioctl_set_disk\(\)) alignedtext
end grestore

%	Unconnected
gsave 10 dict begin
248 560 56 18 ellipse_path
stroke
gsave 10 dict begin
248 555 moveto 91 -0.5 (Unconnected) alignedtext
end grestore
end grestore

%	Unconfigured -> Unconnected
newpath 213 730 moveto
222 724 232 717 238 708 curveto
261 671 258 620 253 588 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 255 588 moveto
252 578 lineto
251 588 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 255 588 moveto
252 578 lineto
251 588 lineto
closepath
stroke
end grestore
gsave 10 dict begin
311 647 moveto 97 -0.5 (ioctl_set_net\(\)) alignedtext
end grestore

%	StandAllone -> Unconnected
newpath 105 634 moveto
107 622 113 606 123 596 curveto
133 586 162 578 190 571 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 190 574 moveto
199 569 lineto
189 569 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 190 574 moveto
199 569 lineto
189 569 lineto
closepath
stroke
end grestore
gsave 10 dict begin
179 601 moveto 97 -0.5 (ioctl_set_net\(\)) alignedtext
end grestore

%	WFConnection
gsave 10 dict begin
366 468 63 18 ellipse_path
stroke
gsave 10 dict begin
366 463 moveto 105 -0.5 (WFConnection) alignedtext
end grestore
end grestore

%	Unconnected -> WFConnection
newpath 248 542 moveto
249 530 252 514 262 504 curveto
269 496 289 488 309 482 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 308 485 moveto
317 480 lineto
307 480 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 308 485 moveto
317 480 lineto
307 480 lineto
closepath
stroke
end grestore
gsave 10 dict begin
307 509 moveto 75 -0.5 (connect\(\)[1]) alignedtext
end grestore

%	WFConnection -> Unconnected
newpath 367 486 moveto
366 498 364 513 355 524 curveto
347 532 324 540 302 546 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 302 543 moveto
293 549 lineto
303 548 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 302 543 moveto
293 549 lineto
303 548 lineto
closepath
stroke
end grestore
gsave 10 dict begin
424 509 moveto 110 -0.5 (unable to bind\(\)) alignedtext
end grestore

%	WFReportParams
gsave 10 dict begin
347 376 73 18 ellipse_path
stroke
gsave 10 dict begin
347 371 moveto 125 -0.5 (WFReportParams) alignedtext
end grestore
end grestore

%	WFConnection -> WFReportParams
newpath 362 450 moveto
360 437 356 418 353 403 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 356 403 moveto
351 394 lineto
351 404 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 356 403 moveto
351 394 lineto
351 404 lineto
closepath
stroke
end grestore
gsave 10 dict begin
448 417 moveto 166 -0.5 (in connect\(\) after accept) alignedtext
end grestore

%	WFReportParams -> StandAllone
newpath 281 384 moveto
210 396 102 427 51 504 curveto
25 543 57 596 80 626 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 78 627 moveto
86 634 lineto
82 624 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 78 627 moveto
86 634 lineto
82 624 lineto
closepath
stroke
end grestore
gsave 10 dict begin
148 509 moveto 180 -0.5 (checks in receive_param\(\)) alignedtext
end grestore

%	Connected
gsave 10 dict begin
356 118 47 18 ellipse_path
stroke
gsave 10 dict begin
356 113 moveto 72 -0.5 (Connected) alignedtext
end grestore
end grestore

%	WFReportParams -> Connected
newpath 348 358 moveto
350 313 354 198 355 145 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 358 146 moveto
355 136 lineto
353 146 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 358 146 moveto
355 136 lineto
353 146 lineto
closepath
stroke
end grestore
gsave 10 dict begin
423 233 moveto 130 -0.5 (in receive_param\(\)) alignedtext
end grestore

%	WFBitMapS
gsave 10 dict begin
181 284 54 18 ellipse_path
stroke
gsave 10 dict begin
181 279 moveto 87 -0.5 (WFBitMapS) alignedtext
end grestore
end grestore

%	WFReportParams -> WFBitMapS
newpath 282 367 moveto
246 361 206 352 194 340 curveto
186 332 183 321 181 311 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 184 312 moveto
180 302 lineto
179 312 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 184 312 moveto
180 302 lineto
179 312 lineto
closepath
stroke
end grestore
gsave 10 dict begin
266 325 moveto 125 -0.5 (sync_handshake\(\)) alignedtext
end grestore

%	WFBitMapT
gsave 10 dict begin
527 284 55 18 ellipse_path
stroke
gsave 10 dict begin
527 279 moveto 89 -0.5 (WFBitMapT) alignedtext
end grestore
end grestore

%	WFReportParams -> WFBitMapT
newpath 379 360 moveto
409 344 456 320 489 303 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 489 306 moveto
497 299 lineto
487 301 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 489 306 moveto
497 299 lineto
487 301 lineto
closepath
stroke
end grestore
gsave 10 dict begin
523 325 moveto 125 -0.5 (sync_handshake\(\)) alignedtext
end grestore

%	BrokenPipe
gsave 10 dict begin
112 26 51 18 ellipse_path
stroke
gsave 10 dict begin
112 21 moveto 81 -0.5 (BrokenPipe) alignedtext
end grestore
end grestore

%	Connected -> BrokenPipe
newpath 322 105 moveto
279 89 205 61 157 43 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 157 40 moveto
147 39 lineto
155 45 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 157 40 moveto
147 39 lineto
155 45 lineto
closepath
stroke
end grestore
gsave 10 dict begin
311 67 moveto 79 -0.5 (* recv error) alignedtext
end grestore

%	NetworkFailure
gsave 10 dict begin
674 26 66 18 ellipse_path
stroke
gsave 10 dict begin
674 21 moveto 110 -0.5 (NetworkFailure) alignedtext
end grestore
end grestore

%	Connected -> NetworkFailure
newpath 396 109 moveto
439 99 500 85 512 82 curveto
551 70 594 55 627 44 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 627 47 moveto
635 41 lineto
625 42 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 627 47 moveto
635 41 lineto
625 42 lineto
closepath
stroke
end grestore
gsave 10 dict begin
636 67 moveto 118 -0.5 (* set by asender\(\)) alignedtext
end grestore

%	Timeout
gsave 10 dict begin
454 26 40 18 ellipse_path
stroke
gsave 10 dict begin
454 21 moveto 58 -0.5 (Timeout) alignedtext
end grestore
end grestore

%	Connected -> Timeout
newpath 359 100 moveto
361 88 367 72 377 62 curveto
386 52 399 45 410 39 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 411 41 moveto
419 35 lineto
409 37 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 411 41 moveto
419 35 lineto
409 37 lineto
closepath
stroke
end grestore
gsave 10 dict begin
442 67 moveto 117 -0.5 (* set drbd_send\(\)) alignedtext
end grestore

%	SyncSource
gsave 10 dict begin
208 192 50 18 ellipse_path
stroke
gsave 10 dict begin
208 187 moveto 79 -0.5 (SyncSource) alignedtext
end grestore
end grestore

%	WFBitMapS -> SyncSource
newpath 185 266 moveto
187 255 191 240 195 228 curveto
195 225 196 222 197 219 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 199 220 moveto
201 210 lineto
195 218 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 199 220 moveto
201 210 lineto
195 218 lineto
closepath
stroke
end grestore
gsave 10 dict begin
260 233 moveto 116 -0.5 (receive_bitmap\(\)) alignedtext
end grestore

%	SyncTarget
gsave 10 dict begin
503 192 50 18 ellipse_path
stroke
gsave 10 dict begin
503 187 moveto 78 -0.5 (SyncTarget) alignedtext
end grestore
end grestore

%	WFBitMapT -> SyncTarget
newpath 522 266 moveto
519 253 514 234 510 219 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 513 219 moveto
508 210 lineto
508 220 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 513 219 moveto
508 210 lineto
508 220 lineto
closepath
stroke
end grestore
gsave 10 dict begin
581 233 moveto 116 -0.5 (receive_bitmap\(\)) alignedtext
end grestore

%	SyncSource -> Connected
newpath 237 177 moveto
260 165 294 149 319 136 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 319 139 moveto
327 132 lineto
317 134 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 319 139 moveto
327 132 lineto
317 134 lineto
closepath
stroke
end grestore

%	PausedSyncS
gsave 10 dict begin
208 118 56 18 ellipse_path
stroke
gsave 10 dict begin
208 113 moveto 90 -0.5 (PausedSyncS) alignedtext
end grestore
end grestore

%	SyncSource -> PausedSyncS
newpath 202 174 moveto
201 165 201 155 201 145 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 203 146 moveto
202 136 lineto
198 146 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 203 146 moveto
202 136 lineto
198 146 lineto
closepath
stroke
end grestore

%	SyncTarget -> Connected
newpath 471 178 moveto
441 164 412 148 390 137 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 393 136 moveto
383 133 lineto
390 140 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 393 136 moveto
383 133 lineto
390 140 lineto
closepath
stroke
end grestore

%	PausedSyncT
gsave 10 dict begin
503 118 57 18 ellipse_path
stroke
gsave 10 dict begin
503 113 moveto 92 -0.5 (PausedSyncT) alignedtext
end grestore
end grestore

%	SyncTarget -> PausedSyncT
newpath 497 174 moveto
496 165 496 155 496 145 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 498 146 moveto
497 136 lineto
493 146 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 498 146 moveto
497 136 lineto
493 146 lineto
closepath
stroke
end grestore

%	PausedSyncS -> SyncSource
newpath 214 136 moveto
215 144 215 154 215 164 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 213 164 moveto
214 174 lineto
217 164 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 213 164 moveto
214 174 lineto
217 164 lineto
closepath
stroke
end grestore

%	PausedSyncT -> SyncTarget
newpath 509 136 moveto
510 144 510 154 510 164 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 508 164 moveto
509 174 lineto
512 164 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 508 164 moveto
509 174 lineto
512 164 lineto
closepath
stroke
end grestore

%	BrokenPipe -> WFConnection
newpath 94 43 moveto
77 60 56 88 56 118 curveto
56 376 56 376 56 376 curveto
56 425 206 450 297 461 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 296 463 moveto
306 462 lineto
296 458 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 296 463 moveto
306 462 lineto
296 458 lineto
closepath
stroke
end grestore
gsave 10 dict begin
101 233 moveto 75 -0.5 (connect\(\)[1]) alignedtext
end grestore

%	NetworkFailure -> WFConnection
newpath 726 37 moveto
768 49 818 73 818 118 curveto
818 376 818 376 818 376 curveto
818 462 528 458 439 466 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 439 464 moveto
429 466 lineto
439 469 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 439 464 moveto
429 466 lineto
439 469 lineto
closepath
stroke
end grestore
gsave 10 dict begin
863 233 moveto 75 -0.5 (connect\(\)[1]) alignedtext
end grestore

%	Timeout -> WFConnection
newpath 493 31 moveto
556 39 676 55 683 62 curveto
701 79 693 92 693 118 curveto
693 376 693 376 693 376 curveto
693 428 533 452 436 462 curveto
stroke
gsave 10 dict begin
solid
1 setlinewidth
0.000 0.000 0.000 edgecolor
newpath 437 459 moveto
427 463 lineto
437 464 lineto
closepath
fill
0.000 0.000 0.000 edgecolor
newpath 437 459 moveto
427 463 lineto
437 464 lineto
closepath
stroke
end grestore
gsave 10 dict begin
738 233 moveto 75 -0.5 (connect\(\)[1]) alignedtext
end grestore
endpage
showpage
grestore
%%PageTrailer
%%EndPage: 1
%%Trailer
%%Pages: 1
end
restore
%%EOF

--Boundary-00=_809YB6s876ZXpjG--
