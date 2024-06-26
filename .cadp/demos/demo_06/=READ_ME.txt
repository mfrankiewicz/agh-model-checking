-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Aug 21 16:13:51 CEST 2018]

This directory contains a formal specification in LNT of the Transport Layer
Security (TLS 2.3) handshake protocol. The reference definition, in natural
language, of this protocol is given in document [draft-ietf-tls-tls13-24].
The formal specification in LNT is presented in the following article:
[Bozic-Marsso-Mateescu-Wotawa-18.pdf].

The LNT specification of the TLS 1.3 handshake protocol is given in the
following files:

   handshake.lnt                           main LNT file
   handshake_interactions.lnt              LNT process definitions
   handshake_types.lnt                     LNT type definitions
   doc/draft-ietf-tls-tls13-24.pdf         Reference TLS 1.3 specification
   doc/Bozic-Marsso-Mateescu-Wotawa-18.pdf Article on the formal specification

The demo shows how, from this LNT specification, directed test cases for
conformance testing can be automatically generated by the TGV tool of CADP.
These tests are directed by three test purposes, themselves specified in LNT:

   test_purpose_1.lnt       normal execution of the protocol in correct order
   test_purpose_2.lnt       execution in correct order with a wrong shared key
   test_purpose_3.lnt       aborted execution due to client renegotiation
   test_purpose_common.lnt  common process definitions for the test purposes 
   handshake.io             list of input/output actions of the protocol
   demo.svl                 generation of the three test cases

Note: In [Bozic-Marsso-Mateescu-Wotawa-18.pdf], the (more recent) TESTOR
(not yet included in CADP) tool was used in place of TGV.

Note: Compared to [Bozic-Marsso-Mateescu-Wotawa-18.pdf], some files have
been renamed when preparing this CADP demo. For instance:
 - handshake_types.lnt renames HANDSHAKETYPES.lnt
 - test_purpose_1.lnt renames handshake_TP.lnt
 - test_purpose_2.lnt renames handshake_helloRequest_TP.lnt
 - test_purpose_3.lnt renames handshake_alert_TP.lnt
 - test_purpose_common.lnt renames common_TP_interactions.lnt
Also, some minor corrections of the LNT specifications have been brought.

Typing the command 
$	svl demo.svl
wil generate, for each of the three test purposes, a corresponding test case
named "test_case_i.bcg", where i belongs to {1, 2, 3}.

After execution of the SVL script, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean

