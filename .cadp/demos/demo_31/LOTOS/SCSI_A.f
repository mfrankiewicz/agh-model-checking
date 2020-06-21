#define CAESAR_ADT_EXPERT_F 5.6

/*
 * This ``.f'' file is a programming trick used to speed up the state space
 * exploration. As we know that devices 3, 4, 5, 6 will be absent from the
 * system, there is no need to iterate on all the possible values for the
 * corresponding fields of the WIRE tuple: Setting these fields directly to 0
 * (instead making them enumerate the domain {0, 1}) is sufficient. This
 * reduces the number of possible WIRE values from 256 to 16, without
 * altering the result (the generated state space would have the same size,
 * but its generation would be about 10 times slower)
 */

/* ------------------------------------------------------------------------- */

#define W1 (CAESAR_ADT_GET_1_WIRE (*W))
#define W2 (CAESAR_ADT_GET_2_WIRE (*W))
#define W3 (CAESAR_ADT_GET_3_WIRE (*W))
#define W4 (CAESAR_ADT_GET_4_WIRE (*W))
#define W5 (CAESAR_ADT_GET_5_WIRE (*W))
#define W6 (CAESAR_ADT_GET_6_WIRE (*W))
#define W7 (CAESAR_ADT_GET_7_WIRE (*W))
#define W8 (CAESAR_ADT_GET_8_WIRE (*W))

/* ------------------------------------------------------------------------- */

int  ADT_ENUM_NEXT_FUNCTION_WIRE (W)
CAESAR_ADT_TYPE_WIRE *W;
{
     if (!W8) {
	  *W = WIRE (W1, W2, W3, W4, W5, W6, W7, 1);
	  return 1;
     }
#ifdef __SKIP_THIS__
     if (!W7) {
	  *W = WIRE (W1, W2, W3, W4, W5, W6, 1, 0);
	  return 1;
     }
     if (!W6) {
	  *W = WIRE (W1, W2, W3, W4, W5, 1, 0, 0);
	  return 1;
     }
     if (!W5) {
	  *W = WIRE (W1, W2, W3, W4, 1, 0, 0, 0);
	  return 1;
     }
     if (!W4) {
	  *W = WIRE (W1, W2, W3, 1, 0, 0, 0, 0);
	  return 1;
     }
#endif				/* __SKIP_THIS__ */
     if (!W3) {
	  *W = WIRE (W1, W2, 1, 0, 0, 0, 0, 0);
	  return 1;
     }
     if (!W2) {
	  *W = WIRE (W1, 1, 0, 0, 0, 0, 0, 0);
	  return 1;
     }
     if (!W1) {
	  *W = WIRE (1, 0, 0, 0, 0, 0, 0, 0);
	  return 1;
     }
     return 0;
}

/* ------------------------------------------------------------------------- */

