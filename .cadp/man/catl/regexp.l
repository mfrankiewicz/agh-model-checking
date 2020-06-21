


UNIX MANUAL PAGES                                   regexp(LOCAL)



RRRREEEEGGGGUUUULLLLAAAARRRR EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     This page is an excerpt of the UNIX  manual  page  rrrreeeeggggeeeexxxxpppp(5)
     that defines the syntax and semantics of regular expressions
     used by the sssseeeeqqqq(LOCAL) format of CADP, the  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL)
     tool, and the OOOOPPPPEEEENNNN////CCCCAAAAEEEESSSSAAAARRRR application programming interfaces
     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) and ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL).


RRRREEEEGGGGUUUULLLLAAAARRRR EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     A regular expression specifies a set of  character  strings.
     A member of this set of strings is said to be matched by the
     regular expression.  Some characters  have  special  meaning
     when  used  in  a regular expression; other characters stand
     for themselves.

     The following _o_n_e-_c_h_a_r_a_c_t_e_r _R_Es match a _s_i_n_g_l_e character:

     1.1  An ordinary character (_n_o_t one of  those  discussed  in
          1.2 below) is a one-character RE that matches itself.

     1.2  A backslash (\\\\) followed by any special character is  a
          one-character  RE  that  matches  the special character
          itself.  The special characters are:

          a.   ...., ****, [[[[, and  \\\\  (period,  asterisk,  left  square
               bracket,  and  backslash, respectively), which are
               always special, _e_x_c_e_p_t  when  they  appear  within
               square brackets ([[[[]]]]; see 1.4 below).

          b.   ^ (caret or circumflex), which is special  at  the
               _b_e_g_i_n_n_i_n_g of an _e_n_t_i_r_e RE (see 4.1 and 4.3 below),
               or when it immediately follows the left of a  pair
               of square brackets ([[[[]]]]) (see 1.4 below).

          c.   $$$$ (dollar sign), which is special at the eeeennnndddd of an
               _e_n_t_i_r_e RE (see 4.2 below).

          d.   The character used to bound (that is, delimit)  an
               entire RE, which is special for that RE (for exam-
               ple, see how slash (////) is used in the  gggg  command,
               below.)

     1.3  A period (....) is a one-character  RE  that  matches  any
          character except new-line.

     1.4  A non-empty string of  characters  enclosed  in  square
          brackets  ([[[[]]]])  is  a one-character RE that matches _a_n_y
          _o_n_e character in that string.  If, however,  the  first
          character  of  the string is a circumflex (^), the one-
          character RE matches any character _e_x_c_e_p_t new-line  and
          the remaining characters in the string.  The ^ has this
          special meaning _o_n_l_y if it occurs first in the  string.



                     Last change: 2019/01/08                    1






UNIX MANUAL PAGES                                   regexp(LOCAL)



          The  minus  (----) may be used to indicate a range of con-
          secutive characters; for example, [[[[0000----9999]]]]  is  equivalent
          to  [[[[0000111122223333444455556666777788889999]]]].   The ---- loses this special meaning if
          it occurs first (after an initial ^, if any) or last in
          the string.  The right square bracket (]]]]) does not ter-
          minate such a string when it  is  the  first  character
          within  it  (after  an initial ^, if any); for example,
          [[[[]]]]aaaa----ffff]]]] matches either a right square bracket (]]]]) or one
          of  the  ASCII letters aaaa through ffff inclusive.  The four
          characters listed in 1.2.a above stand  for  themselves
          within such a string of characters.

     The following rules may be used to construct REs  from  one-
     character REs:

     2.1  A one-character RE is a RE that  matches  whatever  the
          one-character RE matches.

     2.2  A one-character RE followed by an asterisk (****) is a  RE
          that matches 0000 or more occurrences of the one-character
          RE.  If there  is  any  choice,  the  longest  leftmost
          string that permits a match is chosen.

     2.3  A  one-character  RE  followed  by  \\\\{{{{_m\\\\}}}},  \\\\{{{{_m,\\\\}}}},  or
          \\\\{{{{_m,_n\\\\}}}}  is a RE that matches a _r_a_n_g_e of occurrences of
          the one-character RE.  The values of _m and  _n  must  be
          non-negative  integers  less  than  256;  \\\\{{{{_m\\\\}}}} matches
          _e_x_a_c_t_l_y  _m  occurrences;  \\\\{{{{_m,\\\\}}}}  matches  _a_t  _l_e_a_s_t  _m
          occurrences;  \\\\{{{{_m,_n\\\\}}}} matches _a_n_y _n_u_m_b_e_r of occurrences
          _b_e_t_w_e_e_n _m and _n inclusive.  Whenever a  choice  exists,
          the RE matches as many occurrences as possible.

     2.4  The concatenation of REs is a RE that matches the  con-
          catenation  of the strings matched by each component of
          the RE.

     2.5  A RE enclosed between the character sequences \\\\(((( and \\\\))))
          is a RE that matches whatever the unadorned RE matches.

     2.6  The expression \\\\_n matches the same string of characters
          as was matched by an expression enclosed between \\\\(((( and
          \\\\)))) _e_a_r_l_i_e_r in the same RE.  Here  _n  is  a  digit;  the
          sub-expression  specified is that beginning with the _n-
          th occurrence of \\\\(((( counting from the left.  For  exam-
          ple,  the expression ^\\\\((((....****\\\\))))\\\\1111$$$$ matches a line consist-
          ing of two repeated appearances of the same string.

     A RE may be constrained to match words.

     3.1  \\\\<<<< constrains a RE to match the beginning of  a  string
          or  to  follow  a character that is not a digit, under-
          score, or letter.  The first character matching the  RE



                     Last change: 2019/01/08                    2






UNIX MANUAL PAGES                                   regexp(LOCAL)



          must be a digit, underscore, or letter.

     3.2  \\\\>>>> constrains a RE to match the end of a string  or  to
          precede a character that is not a digit, underscore, or
          letter.

     An _e_n_t_i_r_e _R_E may be constrained to  match  only  an  initial
     segment or final segment of a line (or both).

     4.1  A circumflex (^) at the beginning of an entire RE  con-
          strains that RE to match an _i_n_i_t_i_a_l segment of a line.

     4.2  A dollar sign ($$$$) at the end of an entire RE constrains
          that RE to match a _f_i_n_a_l segment of a line.

     4.3  The construction ^_e_n_t_i_r_e _R_E$$$$ constrains the  entire  RE
          to match the entire line.

     The null RE (for example, ////////) is equivalent to the  last  RE
     encountered.


CCCCHHHHAAAARRRRAAAACCCCTTTTEEEERRRRSSSS WWWWIIIITTTTHHHH SSSSPPPPEEEECCCCIIIIAAAALLLL MMMMEEEEAAAANNNNIIIINNNNGGGG
     Characters that have special meaning except when they appear
     within square brackets ([[[[]]]]) or are preceded by \\\\ are:  ...., ****,
     [[[[, \\\\.  Other special characters,  such  as  $$$$  have  special
     meaning in more restricted contexts.

     The character ^^^^ at the beginning of an expression permits  a
     successful  match  only immediately after a newline, and the
     character $$$$ at the end of an expression requires a  trailing
     newline.

     Two characters have special meaning only  when  used  within
     square  brackets.   The  character ---- denotes a range, [[[[_c----_c]]]],
     unless it is just after the open bracket or before the clos-
     ing  bracket,  [[[[----_c]]]]  or [[[[_c----]]]] in which case it has no special
     meaning.  When used within brackets, the character ^^^^ has the
     meaning  _c_o_m_p_l_e_m_e_n_t  _o_f  if  it immediately follows the open
     bracket (example: [[[[^^^^_c]]]]); elsewhere between  brackets  (exam-
     ple: [[[[_c^^^^]]]]) it stands for the ordinary character ^^^^.

     The special meaning of the \\\\ operator can be escaped only by
     preceding it with another \\\\, for example \\\\\\\\.











                     Last change: 2019/01/08                    3



