/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_file_1.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.20
 *   Date               :       2009/07/05 13:07:33
 *****************************************************************************/

#ifndef BCG_FILE_1_INTERFACE

#define BCG_FILE_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"
#include "bcg_version.h"

#define BCG_TO_END_OF_BYTE	((BCG_TYPE_NATURAL) 255)

#define BCG_SEEK_SET    (SEEK_SET)
#define BCG_SEEK_CUR    (SEEK_CUR)
#define BCG_SEEK_END    (SEEK_END)

#define BCG_STDIN	((BCG_TYPE_FILE_NAME) stdin)
#define BCG_STDOUT	((BCG_TYPE_FILE_NAME) stdout)
#define BCG_STDERR	((BCG_TYPE_FILE_NAME) stderr)

typedef enum {
     bcg_no_operation,
     bcg_read_operation,
     bcg_seek_operation,
     bcg_write_operation
}    bcg_type_file_operation;

typedef struct {

     BCG_TYPE_8_BITS_INT bcg_buffer;
     BCG_TYPE_BUFFER_INDEX bcg_buffer_index;
     BCG_TYPE_BOOLEAN bcg_buffer_modified;
     BCG_TYPE_BOOLEAN bcg_buffer_read;
     BCG_TYPE_OPEN_TYPE bcg_open_type;
     BCG_TYPE_FILE_NAME bcg_file_name;
     BCG_TYPE_BOOLEAN bcg_read_file;
     BCG_TYPE_BOOLEAN bcg_write_file;
     bcg_type_file_operation bcg_last_operation;
     /*
      * Dans le reste de cette structure, on stocke des attributs
      * "semantiques"  qui seront utilises par les couches superieures (y
      * compris des pointeurs vers d'autres structures qui seront definies et
      * utilisees dans les couches superieures)
      */
     BCG_TYPE_VERSION bcg_version;
     BCG_TYPE_8_BITS_INT bcg_offset_size;	
     BCG_TYPE_8_BITS_INT bcg_long_natural_size; 

     struct bcg_struct_area_file_info *bcg_area_file_info;

     struct bcg_struct_state_info *bcg_state_file_info;

     struct bcg_struct_edge_info *bcg_edge_file_info;
}    bcg_type_intern_file;

#define bcg_stack_size 10

extern BCG_TYPE_BCG_FILE BCG_READ_FILE_STACK[bcg_stack_size];
extern BCG_TYPE_BCG_FILE BCG_WRITE_FILE_STACK[bcg_stack_size];

extern BCG_TYPE_NATURAL BCG_READ_TOP;
extern BCG_TYPE_NATURAL BCG_WRITE_TOP;

#define BCG_CURRENT_READ_FILE() (BCG_READ_FILE_STACK[BCG_READ_TOP])
#define BCG_CURRENT_WRITE_FILE() (BCG_WRITE_FILE_STACK[BCG_WRITE_TOP])

extern bcg_type_intern_file *BCG_ARRAY_BCG_FILE;

extern void BCG_INIT_BINARY BCG_ARG_0 ();

extern BCG_TYPE_BOOLEAN BCG_EXTENSION BCG_ARG_2 (BCG_TYPE_FILE_NAME, BCG_TYPE_C_STRING);

extern BCG_TYPE_BCG_FILE BCG_OPEN_BINARY BCG_ARG_2 (BCG_TYPE_FILE_NAME, BCG_TYPE_OPEN_TYPE);

extern void BCG_CLOSE_BINARY BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_SWITCH_READ BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_SWITCH_WRITE BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern BCG_TYPE_OFFSET BCG_TELL BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_SEEK BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_OFFSET, BCG_TYPE_GENUINE_INT);

extern void BCG_BINARY_SEEK BCG_ARG_4 (BCG_TYPE_BCG_FILE, BCG_TYPE_OFFSET, BCG_TYPE_NATURAL, BCG_TYPE_GENUINE_INT);

extern void BCG_FLUSH BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern BCG_TYPE_BOOLEAN BCG_SAME_FILE BCG_ARG_2 (BCG_TYPE_FILE_NAME, BCG_TYPE_FILE_NAME);

extern void BCG_RENAME_FILE BCG_ARG_2 (BCG_TYPE_FILE_NAME, BCG_TYPE_FILE_NAME);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
