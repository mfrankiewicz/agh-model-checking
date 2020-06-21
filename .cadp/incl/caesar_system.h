/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	caesar_system.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.74
 *   Date		: 	2019/10/15 07:37:03
 *****************************************************************************/

#ifndef CAESAR_SYSTEM_INTERFACE

#define CAESAR_SYSTEM_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include <stdlib.h>		/* pour avoir ssize_t */
#include <stdio.h>		/* pour avoir FILE et size_t */
#include <string.h>		/* pour avoir strsignal() entre autres */
#include <unistd.h>		/* pour avoir ssize_t sur MacOS */
#include <sys/types.h>
#include <sys/stat.h>		/* pour avoir struct stat */

/*---------------------------------------------------------------------------*/

typedef struct stat stat_t;
/* on sauvegarde la structure stat, car on va redefinir stat plus bas */

/*****************************************************************************/

/**
 * - la macro CAESAR_WITHOUT_PROTOTYPES indique que le code C n'a pas de
 *   prototypes de fonctions, car il a ete ecrit pour les machines "sun3"
 *   et "sun4" (desormais obsoletes)
 * - la macro CAESAR_WITH_OLD_PROTOTYPES indique que le code C a ete ecrit
 *   avec des prototypes en style ancien (c'est le cas du code de tous les
 *   outils CADP et du code C genere par eux, a l'exception de Exp.Open)
 * - la macro CAESAR_WITH_NEW_PROTOTYPES indique que le code C est cense
 *   utiliser des prototypes en style nouveau (on suppose que c'est le
 *   cas du code ecrit par les utilisateurs de CADP)
 * - ces trois macros sont mutuellement exclusives
 * - elles serviront ulterieurement a definir les macros BCG_ARG_xxx(),
 *   CAESAR_ARG_xxx(), BCG_PROMOTE_TO_INT() et CAESAR_PROMOTE_TO_INT()
**/

#if defined (CAESAR_WITHOUT_PROTOTYPES) || \
    defined (CAESAR_WITH_OLD_PROTOTYPES) || \
    defined (CAESAR_WITH_NEW_PROTOTYPES)

/*
 * l'utilisateur a explicitement defini l'une des trois macros avant
 * d'inclure ce fichier ; on ne modifie pas son choix ; ce cas se produit
 * notamment avec Exp.Open qui genere du code C avec des prototypes en style
 * nouveau et definit explicitement la macro CAESAR_WITH_NEW_PROTOTYPES
 */

#elif defined (ARCHITECTURE_SUN_3) || \
      defined (ARCHITECTURE_SUN_4)

#define CAESAR_WITHOUT_PROTOTYPES

#elif defined (ARCHITECTURE_SUN_5) || \
      defined (ARCHITECTURE_SUN64_SOLARIS) || \
      defined (ARCHITECTURE_PC_SOLARIS) || \
      defined (ARCHITECTURE_X64_SOLARIS)

#if defined (__SUNPRO_C)

/* compilateur Sun/Oracle CC sous Solaris (sun5, sun64, sol86, sol64) */
#define CAESAR_WITH_OLD_PROTOTYPES
/**
 * en effet, on devra avoir xxx_PROMOTE_TO_INT(T) = int pour eviter une
 * rafale de messages d'avertissement emis par le compilateur C de Sun :
 *     warning: identifier redeclared: ...
 *     ...
 *     warning: Prototype mismatch in arg ... for function ...
 *     function : old style declaration T promoted to int
 *     prototype: T
**/

#elif defined (__GNUC__)

/* compilateur GCC sous Solaris */
#define CAESAR_WITH_OLD_PROTOTYPES
/*
 * en effet, on devra avoir xxx_PROMOTE_TO_INT(T) = int pour eviter des
 * warnings lorsqu'on invoque "make gcc_hard" sur une machine de
 * developpement (i.e., Solaris), car "make gcc_hard" appelle "gcc" avec
 * l'option -Wconversion
 */

#endif

#elif defined (ARCHITECTURE_PC_LINUX) || \
      defined (ARCHITECTURE_X64_LINUX) || \
      defined (ARCHITECTURE_IA64_LINUX)

#if defined (__INTEL_COMPILER)

/* cas du compilateur ICC d'Intel sous Linux */
#define CAESAR_WITH_OLD_PROTOTYPES
/*
 * en effet, on devra avoir xxx_PROMOTE_TO_INT(T) = int pour eviter une
 * rafale de messages d'avertissement emis par le compilateur ICC 9.* d'Intel
 * : warning #147: declaration is incompatible with ...
 */

#endif

#elif defined (ARCHITECTURE_PC_WIN32) || \
      defined (ARCHITECTURE_MAC_OSX) || \
      defined (ARCHITECTURE_MAC_86) || \
      defined (ARCHITECTURE_MAC_64)

#if defined (__clang__)

/* cas du compilateur CLANG */
#define CAESAR_WITH_OLD_PROTOTYPES
/*
 * en effet, on devra avoir xxx_PROMOTE_TO_INT(T) = int pour eviter une
 * rafale de messages d'avertissement emis par le compilateur CLANG :
 * warning: promoted type 'int' of K&R function parameter is not compatible
 * with the parameter type 'CAESAR_TYPE_FORMAT' (aka 'unsigned char')
 * declared in a previous prototype [-Wknr-promoted-parameter]
 */

#endif

#else

/*
 * aucune des macros ARCHITECTURE_xxx n'est definie ; soit on est dans le cas
 * d'une architecture encore inconnue, soit il s'agit de code ecrit par les
 * utilisateurs de CADP, soit il s'agit de code C genere par les outils CADP
 * mais compile chez l'utilisateur (donc sans positionner aucune variable
 * ARCHITECTURE_xxx)
 */

#endif

#if !defined (CAESAR_WITHOUT_PROTOTYPES) && \
    !defined (CAESAR_WITH_OLD_PROTOTYPES) && \
    !defined (CAESAR_WITH_NEW_PROTOTYPES)
/*
 * on est dans aucun des cas particuliers envisages ci-dessus : on suppose
 * qu'on utilise GCC qui ne pose pas de probleme
 */
#define CAESAR_WITH_NEW_PROTOTYPES
#endif

/*****************************************************************************/

#if defined (WIN32) && ! defined (ARCHITECTURE_PC_WIN32)
#define ARCHITECTURE_PC_WIN32
#endif

/*****************************************************************************/

#if defined (ARCHITECTURE_PC_WIN32)

/* ici, il faut que NO_OLDNAMES ne soit pas #defini pour avoir O_WRONLY */
#include <fcntl.h>

/*
 * ici, on #definit NO_OLDNAMES pour ne plus avoir la fonction obsolete
 * mkdir() avec un seul argument
 */
#define NO_OLDNAMES

#include <stdarg.h>		/* pour avoir va_list */
#include <stdint.h>		/* pour avoir uint32_t, etc. */

/*---------------------------------------------------------------------------*/

#define ftruncate(file,length) chsize(file,length)

/* pas de strsignal() dans Mingwin (alors qu'elle existe en Cygwin) */
#define strsignal(X)  ((char *) "unnamed signal")

#define ftello(stream) ftell (stream)

#define fseeko(stream,offset,whence) fseek (stream,offset,whence)

/*---------------------------------------------------------------------------*/

/*
 * les fonctions getdtablesize() et tmpfile() sont definies ou redefinies
 * dans le bibliotheque $CADP/bin.win32/libm.a ; pour des raisons
 * historiques, elles ne sont pas renommee en own_xxx() comme on pourrait s'y
 * attendre
 */

extern int getdtablesize (void);

/* extern FILE *tmpfile (void); */

/*---------------------------------------------------------------------------*/

/*
 * les fonctions ci-dessous: own_sleep(), own_getenv(), own_creat(),
 * own_fopen(), own_freopen(), own_mkdir(), own_open(), own_remove(),
 * own_rename(), own_rmdir(), own_stat(), own_unlink(), own_system(),
 * own_popen() et own_pclose() sont definies dans $CADP/bin.win32/libm.a
 */

extern unsigned int own_sleep (unsigned int seconds);
#define sleep own_sleep

char *own_getenv (const char *name);
#define getenv own_getenv

extern int own_creat (const char *pathname, mode_t mode);
#define creat own_creat

extern FILE *own_fopen (const char *filename, const char *mode);
#define fopen own_fopen

extern FILE *own_freopen (const char *filename, const char *mode, FILE *stream);
#define freopen own_freopen

extern int own_mkdir (const char *pathname);
#define mkdir(pathname,mode) own_mkdir (pathname)
/*
 * sous Windows et Mingw32, la fonction mkdir()/_mkdir() ne possede qu'un
 * seul argument, contrairement a POSIX qui demande deux arguments
 */

extern int own_open (const char *pathname, int flags,... /* mode_t mode */ );
#define open own_open

extern int own_remove (const char *pathname);
#define remove own_remove

extern int own_rename (const char *oldpath, const char *newpath);
#define rename own_rename

extern int own_rmdir (const char *pathname);
#define rmdir own_rmdir

extern int own_stat (const char *path, struct stat *buf);
#undef stat
#define stat(path,buf) own_stat (path, buf)
/*
 * il est indispensable d'indiquer les deux arguments de la fonction stat()
 * car on veut que la substitution stat->own_stat s'applique a la fonction
 * stat() mais pas a la structure stat
 */

#define lstat(path,buf) own_stat (path, buf)
/* pas de liens symboliques Posix sous Windows */

extern int own_unlink (const char *pathname);
#define unlink own_unlink

extern int own_system (const char *string);
#define system own_system

extern FILE *own_popen (const char *command, const char *mode);
#ifdef popen
/*
 * sous Cygwin 64 bits, les includes du compilateur Gcc 32 bits definissent
 * popen() non comme une fonction, mais comme une macro appelant _popen()
 */
#undef popen
#endif
#define popen own_popen

extern int own_pclose (FILE *stream);
#ifdef pclose
/*
 * sous Cygwin 64 bits, les includes du compilateur Gcc 32 bits definissent
 * pclose() non comme une fonction, mais comme une macro appelant _pclose()
 */
#undef pclose
#endif
#define pclose own_pclose

/*---------------------------------------------------------------------------*/

#ifndef WEXITSTATUS
/* WEXITSTATUS() n'est plus defini dans les versions recentes de Mingwin32 */
#define WEXITSTATUS(x) (((x) >> 8) & 0xff)
#endif

#ifndef WIFEXITED
#define WIFEXITED(w) (((w) & 0xff) == 0)
#endif

/*---------------------------------------------------------------------------*/

/*
 * les fonctions ci-dessous appartenant aux famillles de printf() et scanf()
 * proviennent de la bibliotheque Trio et sont contenues dans
 * $CADP/bin.win32/libm.a
 */

extern int own_printf (const char *format,...);
#define printf         own_printf

extern int own_vprintf (const char *format, va_list args);
#define vprintf        own_vprintf

extern int own_fprintf (FILE *file, const char *format,...);
#define fprintf        own_fprintf

extern int own_vfprintf (FILE *file, const char *format, va_list args);
#define vfprintf       own_vfprintf

extern int own_sprintf (char *buffer, const char *format,...);
#define sprintf        own_sprintf

extern int own_vsprintf (char *buffer, const char *format, va_list args);
#define vsprintf       own_vsprintf

extern int own_snprintf (char *buffer, size_t max, const char *format,...);
#define snprintf       own_snprintf

extern int own_vsnprintf (char *buffer, size_t bufferSize, const char *format, va_list args);
#define vsnprintf      own_vsnprintf

extern int own_scanf (const char *format,...);
#define scanf          own_scanf

extern int own_vscanf (const char *format, va_list args);
#define vscanf         own_vscanf

extern int own_fscanf (FILE *file, const char *format,...);
#define fscanf         own_fscanf

extern int own_vfscanf (FILE *file, const char *format, va_list args);
#define vfscanf        own_vfscanf

extern int own_sscanf (const char *buffer, const char *format,...);
#define sscanf         own_sscanf

extern int own_vsscanf (const char *buffer, const char *format, va_list args);
#define vsscanf        own_vsscanf

#endif

/*****************************************************************************/

#if !defined (ARCHITECTURE_PC_WIN32)

/*
 * on importe les definitions de WEXITSTATUS() et WIFEXITED() qui sont
 * definies ci-dessus par des macros dans le cas de Windows
 */

#include <sys/wait.h>

#endif

/*****************************************************************************/

#if defined (ARCHITECTURE_PC_SOLARIS)

/* on redefinit stat() pour eviter des warnings douteux de lint */

#ifdef lint
#include <sys/stat.h>
#define stat stat64
#endif

#endif

/*****************************************************************************/

#if defined (ARCHITECTURE_PC_LINUX) || \
    defined (ARCHITECTURE_X64_LINUX) || \
    defined (ARCHITECTURE_IA64_LINUX)

#if (_POSIX_C_SOURCE - 0 >= 200809L)

/* la fonction strsignal() est definie dans <string.h> */

#else

/* on doit declarer manuellement strsignal() ici */

extern char *strsignal (int __sig);

#endif

#endif

/*****************************************************************************/

#if defined (ARCHITECTURE_PC_LINUX) || \
    defined (ARCHITECTURE_PC_WIN32) || \
    defined (ARCHITECTURE_X64_LINUX) || \
    defined (ARCHITECTURE_IA64_LINUX)

/* on doit pallier l'absence de strlcpy() dans la glibc sous Linux */

extern size_t own_strlcpy (char *, const char *, size_t);
/* own_strlcpy() est definie dans "caesar_standard.c" */

#define strlcpy own_strlcpy

#endif

/*****************************************************************************/

#if defined (ARCHITECTURE_PC_SOLARIS) || \
    defined (ARCHITECTURE_X64_SOLARIS) || \
    defined (ARCHITECTURE_PC_WIN32) || \
    defined (ARCHITECTURE_MAC_86) || \
    defined (ARCHITECTURE_MAC_64)

/* on doit pallier l'absence de getline() qui n'existe que sous Linux */

extern ssize_t own_getline (char **, size_t *, FILE *);
/* own_getline() est definie dans "caesar_standard.c" */

#define getline own_getline

#endif

/*****************************************************************************/

#if defined (CAESAR_WITHOUT_PROTOTYPES) || \
    (defined (CAESAR_GRAPH_IMPLEMENTATION) && (CAESAR_GRAPH_IMPLEMENTATION - 0 == 0))

/*
 * les prototypes de fonctions sont desactives dans deux cas: (1) si l'on est
 * sur une architecture obsolete dont le compilateur C ne les supportait pas,
 * ou (2) si le present fichier est inclus dans un programme C produit avec
 * un compilateur compatible Open/Caesar (par exemple, Caesar, Bcg_Open,
 * etc.) mais obsolete (anterieur a la version Open/Caesar 2.3 incluse), ce
 * que l'on detecte en testant que la variable CAESAR_GRAPH_IMPLEMENTATION
 * est definie et egale a la chaine vide
 */

#define CAESAR_ARG_0() 							  ()
#define CAESAR_ARG_1(A1) 						  ()
#define CAESAR_ARG_2(A1,A2) 						  ()
#define CAESAR_ARG_3(A1,A2,A3)  					  ()
#define CAESAR_ARG_4(A1,A2,A3,A4) 					  ()
#define CAESAR_ARG_5(A1,A2,A3,A4,A5) 					  ()
#define CAESAR_ARG_6(A1,A2,A3,A4,A5,A6)					  ()
#define CAESAR_ARG_7(A1,A2,A3,A4,A5,A6,A7)				  ()
#define CAESAR_ARG_8(A1,A2,A3,A4,A5,A6,A7,A8)				  ()
#define CAESAR_ARG_9(A1,A2,A3,A4,A5,A6,A7,A8,A9)			  ()
#define CAESAR_ARG_10(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10)			  ()
#define CAESAR_ARG_11(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11)		  ()
#define CAESAR_ARG_12(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12)		  ()
#define CAESAR_ARG_13(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13)	  ()
#define CAESAR_ARG_14(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14)	  ()
#define CAESAR_ARG_15(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15) ()
#define CAESAR_ARG_16(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16) ()

#else

#define CAESAR_ARG_0() \
	(void)
#define CAESAR_ARG_1(A1) \
	(A1)
#define CAESAR_ARG_2(A1,A2) \
	(A1, A2)
#define CAESAR_ARG_3(A1,A2,A3) \
	(A1, A2, A3)
#define CAESAR_ARG_4(A1,A2,A3,A4) \
	(A1, A2, A3, A4)
#define CAESAR_ARG_5(A1,A2,A3,A4,A5) \
	(A1, A2, A3, A4, A5)
#define CAESAR_ARG_6(A1,A2,A3,A4,A5,A6) \
	(A1, A2, A3, A4, A5, A6)
#define CAESAR_ARG_7(A1,A2,A3,A4,A5,A6,A7) \
	(A1, A2, A3, A4, A5, A6, A7)
#define CAESAR_ARG_8(A1,A2,A3,A4,A5,A6,A7,A8) \
	(A1, A2, A3, A4, A5, A6, A7, A8)
#define CAESAR_ARG_9(A1,A2,A3,A4,A5,A6,A7,A8,A9) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9)
#define CAESAR_ARG_10(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10)
#define CAESAR_ARG_11(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11)
#define CAESAR_ARG_12(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12)
#define CAESAR_ARG_13(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13)
#define CAESAR_ARG_14(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14)
#define CAESAR_ARG_15(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15)
#define CAESAR_ARG_16(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16) \
	(A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16)

#endif

/*---------------------------------------------------------------------------*/

#if defined (CAESAR_WITH_OLD_PROTOTYPES)
#define CAESAR_PROMOTE_TO_INT(T) int
#else
#define CAESAR_PROMOTE_TO_INT(T) T
#endif

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
