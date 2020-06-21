'\" t
.\" @(#)svl.l - VASY and CONVECS teams - 2020/02/12
.TH SVL LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
svl \- compilation and execution of SVL scripts

.SH SYNOPSIS
.P
\fBsvl\fP \fIoptions\fP [ \fIfile\fP[\fB.svl\fP] [\fIscript-parameters\fP]]
.br
\fBsvl\fP -script \fIoptions\fP [ \fIfile1\fP[\fB.svl\fP] ] [ -output \fIfile2\fP ]
.br
\fBsvl\fP -expand [-case] [-indent \fIn\fP] [ \fIfile1\fP[\fB.svl\fP]\fP ] [ -output \fIfile2\fP ]
.br
\fBsvl\fP -clean [ \fIfile\fP[\fB.svl\fP] ]
.br
\fBsvl\fP -sweep [ \fIfile\fP[\fB.svl\fP] ]
.br
\fBsvl\fP -help
.br
\fBsvl\fP -version
.br
where the following \fIoptions\fP are available:
.br
-case, -debug, -ignore, -sh \fIsh-options\fP, -silent, -v \fIvariable\fP=\fIvalue\fP.

.SH DESCRIPTION 
.P
In the simplest form (first line of the synopsis), taking as input \fIfile\fP\fB.svl\fP, which contains a verification script in SVL (Script Verification Language), \fBsvl\fP produces actions invoking CADP tools.
See
.BR svl-lang (LOCAL)
for a description of the SVL language.
.P
\fBsvl\fP runs a given script through the following steps:
.IP -
The program is compiled to a Bourne shell-script that contains a sequence of invocations to the appropriate CADP tools.
.IP -
The generated script is executed with optional \fIscript-parameters\fP, which can be used within the SVL script as Bourne shell parameters $1, $2, ...
.IP -
Finally, the generated script is erased.
.P
During script execution, several temporary intermediate files may be created, and removed as soon as possible in order to minimize disk space consumption. \fBsvl\fP also maintains a log file named \fIfile\fP\fB.log\fP that contains a full diagnostic of the script execution.

.SH COMMANDS

\fBsvl\fP can also be used for alternative actions, using the commands described below:

.ne 12v
.TP
.B -script
Stop after generation of the Bourne shell script. If the parameter \fIfile2\fP is specified, then write the generated script to this file. Otherwise display it on the standard output.

.TP
.B -expand
Stop after the expansion phase i.e., after propagating meta-operators inside expressions. If the parameter \fIfile2\fP is specified, then write the expanded SVL program to this file. Otherwise display the expanded program on the standard output.

.ne 9v
.TP 
.B -clean
Remove the generated shell script and all files created during the latest execution of \fIfile\fP\fB.svl\fP. Note that dynamic libraries of BCG files are erased at the same time as the BCG files themselves, and that files created by user written shell commands are not removed. For this command to be effective, both \fIfile\fP\fB.log\fP and \fIfile\fP\fB.svl\fP must exist in the current directory.

.TP
.B -sweep
Remove temporary files reminiscent of a run in \fB-debug\fP mode (see options below). Note that files created by user written shell commands are not removed. The log file and the output files are not removed either.

.TP
.B -help
Display the available options of \fBsvl\fP.

.ne 5v
.TP
.B -version
Display the current version number of \fBsvl\fP.
.P
Note that \fIfile\fP\fB.svl\fP (or \fIfile1\fP\fB.svl\fP) can be omitted if there exists a unique file with extension \fB.svl\fP in the current directory, in which case this file is considered as the input.

.ne 6v
.SH OPTIONS

The following options are currently available:

.TP
.B -case
The default behaviour of \fBsvl\fP is to not distinguish lowercase and uppercase characters in identifiers that are not enclosed in double quotes (all characters are turned to uppercase). The \fB-case\fP option forces the distinction.

.ne 4v
.TP 
.B -debug
Stop execution has soon as an invoked tool returns a non-zero exit status.
Do not erase intermediate files during execution of the generated script, and do not erase the script file after execution. Use command \fB-sweep\fP or \fB-clean\fP to erase these files afterwards.

.TP
.B -ignore
Do not stop execution of the script after an error is issued, continue execution until all instructions of the script are executed (possibly with errors).

.TP
.B -indent \fIn\fP
Set indentation to \fIn\fP blank characters for expanded SVL script display (command \fB-expand\fP).
Default value for \fIn\fP is 3.

.TP
.BI -sh \ sh-options
Pass \fIsh-options\fP to the Bourne shell interpreter of the generated script. Note that \fIsh-options\fP must count as a single argument, hence it may be necessary to use quotes to group several options.

.TP
.B -silent
Do not comment actions of the script during execution. This is not a default option.

.TP
.B -v \fIvariable\fP=\fIvalue\fP
Add the shell variable definition ``\fIvariable\fP=\fIvalue\fP'' to the generated shell script.
This variable definition will occur just after the inclusion of the \fBstandard\fP file (see Section ENVIRONMENT VARIABLES below), so that the initializations done in \fBstandard\fP cannot overwrite the definition of \fIvariable\fP.
.br
Option \fB-v\fP can be used multiple times on the same command line.
The corresponding variable definitions will then occur in the generated shell script in the same order as they occur on the command line.
.br
Note that if \fIvalue\fP contains shell-interpreted characters that should be left unchanged by the command-line interpreter, then it should either be written between single quotes, or every shell-interpreted character should be escaped by a backslash (\`\\') character.
.br
See Section LOCAL SHELL VARIABLES in the
.BR svl-lang (LOCAL)
manual page for a complete list of the shell variables used by SVL scripts.

.SH ENVIRONMENT VARIABLES

The following environment variables are used:

.TP
.B $CADP
Needed. This variable contains the path of directory where CADP is installed.

.TP
.B $CADP/com
This directory should be put in the \fB$PATH\fP variable.

.TP
.B $SVL 
Optional. The first action of the generated script is to include the file \fB$CADP/src/svl/standard\fP, containing a list of predefined shell functions and variables. However, if the environment variable \fBSVL\fP is defined, the included file is \fB$SVL/src/svl/standard\fP. Moreover, the kernel program \fBsvl_kernel\fP will be searched in \fB$SVL/bin.`arch`\fP instead of \fB$CADP/bin.`arch`\fP.

.SH EXIT STATUS

When the source is erroneous, error messages are issued. Exit status is 0 if everything is alright, 1 otherwise.

.ne 4v
.SH AUTHORS
.P
\fBsvl\fP version 2.0 and later: Hubert Garavel, Frederic Lang, Marc Herbert.
.P
\fBsvl\fP versions 1.0 to 1.6 (kept for internal use and never distributed officially): Mark Jorgensen, Christophe Discours, Hubert Garavel.
.P
The authors owe thanks to Radu Mateescu and Charles Pecheur for their feedback about \fBsvl\fP 1.* and to Laurent Mounier for his useful advices. 

.ne 18v
.SH FILES

The following files and extensions are handled by \fBsvl\fP, either as inputs, outputs, or as temporary intermediate files.
.nf
.cs R 23
.cs B 23
+--------------+-------------------------+-----+-----+-----+
|  Extension   |       Description       | In  | Out | Tmp |
+--------------+-------------------------+-----+-----+-----+
| \fB.lnt\fP         | LNT program             |  X  |     |     |
| \fB.lotos\fP \fB.lot\fP  | LOTOS program           |  X  |     |     |
| \fB.lts\fP         | FSP program             |  X  |     |     |
| \fB.aut\fP         | LTS in AUT format |  X  |  X  |  X  |
| \fB.bcg\fP         | LTS in BCG format       |  X  |  X  |  X  |
| \fB.fc2\fP         | LTS in FC2 format       |  X  |  X  |  X  |
| \fB.seq\fP         | LTS in sequence format  |  X  |  X  |     |
| \fB.exp\fP         | network of LTSs         |  X  |  X  |  X  |
| \fB.hide\fP \fB.hid\fP   | labels to hide          |  X  |     |  X  |
| \fB.cut\fP         | labels to cut           |  X  |     |  X  |
| \fB.rename\fP \fB.ren\fP | labels to rename        |  X  |     |  X  |
| \fB.sync\fP        | labels to synchronize   |  X  |     |  X  |
| \fB.mcl\fP         | temporal logic formula  |  X  |     |     |
| \fB.log\fP         | log of execution        |     |  X  |     |
+--------------+-------------------------+-----+-----+-----+
.cs R
.cs B
.fi

Note: \fBsvl\fP generates temporary files in the current directory. To avoid clashes with existing files, file names generated by \fBsvl\fP are prefixed with a string of the form \fBsvl\fP\fIxxx\fP\fB_\fP, where \fIxxx\fP is a 3 digits number. Hence it is recommended to avoid naming user files this way.

.SH BIBLIOGRAPHY

.P
[GL01] Hubert Garavel and Frederic Lang.
SVL: a Scripting Language for Compositional Verification.
In Myungchul Kim, Byoungmoon Chin, Sungwon Kang, and Danhyung Lee (editors), Proceedings of the 21st International Conference on Formal Techniques for Networked and Distributed Systems FORTE'2001 (Cheju Island, Korea), IFIP Conference Proceedings volume 197, pages 377-394, Kluwer, August 2001.
Available from http://cadp.inria.fr/publications/Garavel-Lang-01.html
.P
[GLM15] Hubert Garavel, Frederic Lang, and Radu Mateescu.
Compositional Verification of Asynchronous Concurrent Systems using CADP.
Acta Informatica, Special Issue on Combining Compositionality and Concurrency: Part 2, 52(4-5):337-392, 2015.
Available from http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-15.html
.P
[KM97] Jean-Pierre Krimm and Laurent Mounier.
Compositional State Space Generation from LOTOS Programs.
In Ed Brinksma (editor), Proceedings of TACAS'97 Tools and Algorithms for the Construction and Analysis of Systems (University of Twente, Enschede, The Netherlands), Lecture Notes in Computer Science volume 1217, Springer, April 1997.
Available from http://cadp.inria.fr/publications/Krimm-Mounier-97.html
.P
[Lan02] Frederic Lang.
Compositional Verification using SVL Scripts.
In Joost-Pieter Katoen and Perdita Stevens (editors), Proceedings of the International Conference on Tools and Algorithms for Construction and Analysis of Systems TACAS'2002 (Grenoble, France), Lecture Notes in Computer Science volume 2280, pages 465-469, Springer, April 2002.
Available from http://cadp.inria.fr/publications/Lang-02.html

.SH SEE ALSO

.BR aldebaran (LOCAL),
.BR aut (LOCAL),
.BR bcg (LOCAL),
.BR bcg_cmp (LOCAL),
.BR bcg_graph (LOCAL),
.BR bcg_io (LOCAL),
.BR bcg_labels (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR evaluator5 (LOCAL),
.BR exhibitor (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR generator (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos.open (LOCAL),
.BR mcl (LOCAL),
.BR mcl3 (LOCAL),
.BR mcl4 (LOCAL),
.BR mcl5 (LOCAL),
.BR projector (LOCAL),
.BR reductor (LOCAL),
.BR regexp (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL),
.BR svl-lang (LOCAL),
.BR xtl (LOCAL),
.BR xtl-lang (LOCAL)
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report any bug to cadp@inria.fr

