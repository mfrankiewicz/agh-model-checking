/******************************************************************************
 *                     P R O D U C T I O N    C E L L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       gate_functions.c
 *   Auteurs            :       Hubert GARAVEL et Wendelin SERWE
 *   Version            :       1.8
 *   Date               :       2016/11/23 10:05:00
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/*---------------------------------------------------------------------------*/

#include "caesar_kernel.h"

#define CAESAR_ADT_INTERFACE
#include "cell.h"

/*---------------------------------------------------------------------------*/

static CAESAR_TYPE_BOOLEAN JUST_AFTER_REACT = CAESAR_FALSE;
/*
 * this variable is true immediately after a REACT and will become false
 * after the next GET_STATUS
 */

/*---------------------------------------------------------------------------*/

#define exit_if(C) if (C) { exit (0); }

/*---------------------------------------------------------------------------*/

#define INPUT_SIZE 1024
char INPUT[INPUT_SIZE];

/*---------------------------------------------------------------------------*/

void REACT ()
{
     /* note: there is no gate REACT in the LOTOS / LNT specification */
     fprintf (stdout, "react\n");
     fflush (stdout);
     JUST_AFTER_REACT = CAESAR_TRUE;	/* to enable GET_STATUS */
}

/*---------------------------------------------------------------------------*/

int  PRESS_UPWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "press_upward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  PRESS_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "press_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  PRESS_DOWNWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "press_downward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM1_FORWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm1_forward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM1_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm1_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM1_BACKWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm1_backward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM2_FORWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm2_forward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM2_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm2_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM2_BACKWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm2_backward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM1_MAG_ON (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm1_mag_on\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM1_MAG_OFF (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm1_mag_off\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM2_MAG_ON (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm2_mag_on\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ARM2_MAG_OFF (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "arm2_mag_off\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ROBOT_LEFT (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "robot_left\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ROBOT_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "robot_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  ROBOT_RIGHT (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "robot_right\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_LEFT (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_left\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_STOP_H (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_stop_h\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_RIGHT (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_right\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_UPWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_upward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_STOP_V (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_stop_v\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  TABLE_DOWNWARD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "table_downward\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_TO_BELT2 (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_to_belt2\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_STOP_H (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_stop_h\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_TO_BELT1 (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_to_belt1\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_LIFT (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_lift\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_STOP_V (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_stop_v\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_LOWER (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_lower\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_MAG_ON (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_mag_on\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRANE_MAG_OFF (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "crane_mag_off\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  BELT1_START (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "belt1_start\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  BELT1_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "belt1_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  BELT2_START (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "belt2_start\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  BELT2_STOP (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "belt2_stop\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

int  BLANK_ADD (EOL)
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_EOL (EOL);
     fprintf (stdout, "blank_add\n");
     fflush (stdout);
     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_RESULT (1);
     return (1);
}

/*---------------------------------------------------------------------------*/

void PARSE_ERROR_LIST (F, S)
CAESAR_TYPE_FILE F;
char *S;
{
     /*
      * This function is called by GET_STATUS() below to parse string S; if
      * this string is different from "{0}", it denotes an error message that
      * will be dumped to file F
      */

     exit_if (S == NULL);	/* corrupted input, should not occur */
     exit_if (*S != '{');	/* corrupted input, should not occur */

     ++S;
     while (1) {
	  switch (*S) {
	  case '0':
	       /* no error */
	       return;
	  case '2':
	       fprintf (F, "collision between feed belt and table\n");
	       break;
	  case '3':
	       fprintf (F, "table reached right stop\n");
	       break;
	  case '4':
	       fprintf (F, "robot reached left stop\n");
	       break;
	  case '5':
	       fprintf (F, "robot reached right stop\n");
	       break;
	  case '6':
	       fprintf (F, "arm1 dropped a blank\n");
	       break;
	  case '7':
	       fprintf (F, "collision between arm1 and press\n");
	       break;
	  case '8':
	       fprintf (F, "arm2 dropped a blank\n");
	       break;
	  case '9':
	       fprintf (F, "collision between arm2 and press\n");
	       break;
	  case '1':
	       ++S;
	       switch (*S) {
	       case ' ':
	       case '}':
		    fprintf (F, "blank dropped between feed belt and table\n");
		    break;
	       case '0':
		    fprintf (F, "blank from the deposit belt\n");
		    break;
	       case '1':
		    fprintf (F, "collision between crane and deposit belt\n");
		    break;
	       case '2':
		    fprintf (F, "collision between crane and feed belt\n");
		    break;
	       case '3':
		    fprintf (F, "crane dropped a blank\n");
		    break;
	       case '4':
		    fprintf (F, "crane reached stop over feed belt\n");
		    break;
	       case '5':
		    fprintf (F, "crane reached stop over deposit belt\n");
		    break;
	       }
	       --S;
	       break;
	  case ' ':
	       /* continue with next character */
	       break;
	  case '}':
	       /* no further error code */
	       exit (1);
	  }
	  ++S;
     }
}

/*---------------------------------------------------------------------------*/

int  GET_STATUS (INPUT1, BOOL1, S1,
		      INPUT2, BOOL2, S2,
		      INPUT3, BOOL3, S3,
		      INPUT4, REAL1, S4,
		      INPUT5, REAL2, S5,
		      INPUT6, REAL3, S6,
		      INPUT7, BOOL4, S7,
		      INPUT8, BOOL5, S8,
		      INPUT9, REAL4, S9,
		      INPUT10, BOOL6, S10,
		      INPUT11, BOOL7, S11,
		      INPUT12, REAL5, S12,
		      INPUT13, BOOL8, S13,
		      INPUT14, BOOL9, S14,
		      INPUT15, STRING, S15,
		      EOL)
CAESAR_KERNEL_OFFER INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7;
CAESAR_KERNEL_OFFER INPUT8, INPUT9, INPUT10, INPUT11, INPUT12, INPUT13;
CAESAR_KERNEL_OFFER INPUT14, INPUT15;
char *BOOL1, *BOOL2, *BOOL3, *BOOL4, *BOOL5, *BOOL6, *BOOL7, *BOOL8, *BOOL9;
char *REAL1, *REAL2, *REAL3, *REAL4, *REAL5, *STRING;
ADT_REAL *S4, *S5, *S6, *S9, *S12;
ADT_BOOL *S1, *S2, *S3, *S7, *S8, *S10, *S11, *S13, *S14;
ADT_STRING *S15;
CAESAR_KERNEL_OFFER EOL;
{
     char *RESULT;

     CAESAR_KERNEL_ASSERT_INPUT (INPUT1);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT2);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT3);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT4);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT5);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT6);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT7);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT8);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT9);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT10);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT11);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT12);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT13);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT14);
     CAESAR_KERNEL_ASSERT_INPUT (INPUT15);

     CAESAR_KERNEL_ASSERT_TYPE (BOOL1, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL2, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL3, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL4, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL5, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL6, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL7, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL8, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_TYPE (BOOL9, "ADT_BOOL");

     CAESAR_KERNEL_ASSERT_TYPE (REAL1, "ADT_REAL");
     CAESAR_KERNEL_ASSERT_TYPE (REAL2, "ADT_REAL");
     CAESAR_KERNEL_ASSERT_TYPE (REAL3, "ADT_REAL");
     CAESAR_KERNEL_ASSERT_TYPE (REAL4, "ADT_REAL");
     CAESAR_KERNEL_ASSERT_TYPE (REAL5, "ADT_REAL");

     CAESAR_KERNEL_ASSERT_TYPE (STRING, "ADT_STRING");

     CAESAR_KERNEL_ASSERT_EOL (EOL);

     if (JUST_AFTER_REACT == CAESAR_FALSE) {
	  /* GET_STATUS is only permitted after a REACT */
	  CAESAR_KERNEL_LOG_GATE (__func__);
	  CAESAR_KERNEL_LOG_RESULT (0);
	  return (0);
     }
     fprintf (stdout, "do_get_status\n");
     fflush (stdout);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S1 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S2 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S3 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     INPUT[strlen (INPUT) - 1] = '\0';
     *S4 = (ADT_REAL) atof (INPUT);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     INPUT[strlen (INPUT) - 1] = '\0';
     *S5 = (ADT_REAL) atof (INPUT);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     INPUT[strlen (INPUT) - 1] = '\0';
     *S6 = (ADT_REAL) atof (INPUT);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S7 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S8 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     INPUT[strlen (INPUT) - 1] = '\0';
     *S9 = (ADT_REAL) atof (INPUT);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S10 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S11 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     INPUT[strlen (INPUT) - 1] = '\0';
     *S12 = (ADT_REAL) atof (INPUT);

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S13 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     *S14 = (ADT_BOOL) ((INPUT[0] == '1') ? ADT_TRUE () : ADT_FALSE ());

     RESULT = fgets (INPUT, INPUT_SIZE, stdin);
     exit_if (RESULT == NULL);	/* end-of-file on stdin (broken pipe) */
     PARSE_ERROR_LIST (stderr, INPUT);

     *S15 = INPUT;

     CAESAR_KERNEL_LOG_GATE (__func__);
     CAESAR_KERNEL_LOG_OFFER (INPUT1, BOOL1, *S1, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT2, BOOL2, *S2, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT3, BOOL3, *S3, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT4, REAL1, *S4, ADT_PRINT_REAL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT5, REAL2, *S5, ADT_PRINT_REAL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT6, REAL3, *S6, ADT_PRINT_REAL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT7, BOOL4, *S7, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT8, BOOL5, *S8, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT9, REAL4, *S9, ADT_PRINT_REAL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT10, BOOL6, *S10, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT11, BOOL7, *S11, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT12, REAL5, *S12, ADT_PRINT_REAL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT13, BOOL8, *S13, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT14, BOOL9, *S14, ADT_PRINT_BOOL, 1);
     CAESAR_KERNEL_LOG_OFFER (INPUT15, STRING, *S15, ADT_PRINT_STRING, 1);
     CAESAR_KERNEL_LOG_RESULT (1);

     JUST_AFTER_REACT = CAESAR_FALSE;

     return (1);
}

/*---------------------------------------------------------------------------*/
