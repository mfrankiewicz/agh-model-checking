/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_push_pull.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.8
 *   Date               :       2014/10/21 22:34:05
 *****************************************************************************/

#ifndef BCG_PUSH_PULL_INTERFACE

#define BCG_PUSH_PULL_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#ifdef PUSH_PULL_DEBUG

#define BCG_PUSH_PULL_DEBUG(BCG_STRING,BCG_TOP_BEFORE,BCG_TOP_AFTER) \
   if (BCG_GET_DEBUG ()) \
   fprintf (stderr, BCG_STRING, BCG_TOP_BEFORE, BCG_TOP_AFTER, __FILE__, __LINE__);

#else

#define BCG_PUSH_PULL_DEBUG(BCG_STRING,BCG_TOP_BEFORE,BCG_TOP_AFTER)	

#endif

#define BCG_PUSH_READ_FILE(bcg_new_file) { \
	BCG_PUSH_PULL_DEBUG ("push_read %d => %d [%s:%d]\n", BCG_READ_TOP, BCG_READ_TOP+1); \
	BCG_READ_TOP++; \
        BCG_CURRENT_READ_FILE() = bcg_new_file; \
	}

#define BCG_PUSH_WRITE_FILE(bcg_new_file) { \
		BCG_PUSH_PULL_DEBUG ("push_write %d => %d [%s:%d]\n", BCG_WRITE_TOP, BCG_WRITE_TOP+1); \
	BCG_WRITE_TOP++; \
        BCG_CURRENT_WRITE_FILE() = bcg_new_file; \
	}

#define BCG_PUSH_FILES(bcg_new_file) { \
	BCG_PUSH_READ_FILE(bcg_new_file); \
	BCG_PUSH_WRITE_FILE(bcg_new_file); \
	}

#define BCG_PULL_READ_FILE() { \
	BCG_PUSH_PULL_DEBUG ("pull_read %d => %d [%s:%d]\n", BCG_READ_TOP, BCG_READ_TOP-1); \
	BCG_CURRENT_READ_FILE() = NULL;  \
	BCG_READ_TOP--; \
	}

#define BCG_PULL_WRITE_FILE() { \
	BCG_PUSH_PULL_DEBUG ("pull_write %d => %d [%s:%d]\n", BCG_WRITE_TOP, BCG_WRITE_TOP-1); \
	BCG_CURRENT_WRITE_FILE() = NULL;  \
	BCG_WRITE_TOP--; \
	}

#define BCG_PULL_FILES() { \
	BCG_PULL_READ_FILE(); \
	BCG_PULL_WRITE_FILE(); \
	}

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
