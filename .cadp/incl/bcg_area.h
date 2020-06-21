/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_area.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.10
 *   Date               :       2014/11/29 19:48:24
 *****************************************************************************/

#ifndef BCG_AREA_INTERFACE

#define BCG_AREA_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

typedef unsigned int BCG_TYPE_AREA_CODE;
typedef unsigned int BCG_TYPE_AREA_LIST;
typedef unsigned int BCG_TYPE_AREA_NUMBER;

#define bcg_nb_areas 10

#define BCG_INCLUDE_AREA	((BCG_TYPE_AREA_CODE) 1)
#define BCG_TYPE_AREA		((BCG_TYPE_AREA_CODE) 2)
#define BCG_FUNCTION_AREA	((BCG_TYPE_AREA_CODE) 4)
#define BCG_PROFILE_AREA	((BCG_TYPE_AREA_CODE) 8)
#define BCG_FILE_AREA		((BCG_TYPE_AREA_CODE) 16)
#define BCG_NAME_AREA		((BCG_TYPE_AREA_CODE) 32)
#define BCG_EDGE_AREA		((BCG_TYPE_AREA_CODE) 64)
#define BCG_LABEL_AREA		((BCG_TYPE_AREA_CODE) 128)
#define BCG_STATE_AREA		((BCG_TYPE_AREA_CODE) 256)
#define BCG_CLASS_AREA		((BCG_TYPE_AREA_CODE) 512)

#define BCG_NO_AREA		((BCG_TYPE_AREA_LIST) 0)
#define BCG_ALL_AREA		((BCG_TYPE_AREA_LIST) 1023)

typedef struct bcg_struct_area_file_info {

     BCG_TYPE_AREA_CODE bcg_writing_area_code;

     BCG_TYPE_AREA_CODE bcg_reading_area_code;

     BCG_TYPE_NATURAL bcg_area_format_code;
}    bcg_body_area_file_info, *bcg_type_area_file_info;

extern void BCG_INIT BCG_ARG_0 ();

extern void BCG_OPEN BCG_ARG_3 (BCG_TYPE_BCG_FILE *, BCG_TYPE_FILE_NAME, BCG_TYPE_OPEN_TYPE);

extern void BCG_CLOSE BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_BEGIN_READ_AREA BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_AREA_CODE, BCG_TYPE_NATURAL *);

extern void BCG_END_READ_AREA BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_CHECK_END_OF_AREA BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_BEGIN_WRITE_AREA BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_AREA_CODE, BCG_TYPE_NATURAL);

extern void BCG_END_WRITE_AREA BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_COPY_UPGRADE_AREA BCG_ARG_5 (BCG_TYPE_BCG_FILE, BCG_TYPE_BCG_FILE, BCG_TYPE_AREA_LIST, BCG_TYPE_READ_PROFILE_FUNCTION, BCG_TYPE_WRITE_PROFILE_FUNCTION);

extern void BCG_DELETE_AREA BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_AREA_LIST);

extern void BCG_WRITE_COMMENT BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_C_STRING);

extern void BCG_READ_COMMENT BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_C_STRING *);

extern void BCG_APPEND_COMMENT BCG_ARG_3 (BCG_TYPE_C_STRING, BCG_TYPE_C_STRING, BCG_TYPE_C_STRING *);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
