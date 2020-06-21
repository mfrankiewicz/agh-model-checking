/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_predefined_initialisations.h
 *   Auteurs            :       Hubert GARAVEL et Frederic LANG
 *   Version            :       1.8
 *   Date               :       2014/08/01 13:00:47
 *****************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#define BCG_VERSION_PREDEFINED_INITIALISATIONS 2

/*
 * initialisation des fonctions dynamiques : ce fragment de code est inclus
 * dans la zone des includes des fichiers BCG, puis il est repris pour etre
 * inclus dans la bibliotheque dynamique, et plus precisement dans la
 * fonction Bcg_INITIALIZATIONS() qui recoit un parametre bcg_bcg_object
 * different de NULL
 */

{

#if bcg_gate_size > 0

     extern BCG_TYPE_C_STRING Bcg_GET_BCG_FILE_NAME ();

     bcg_gate_init (bcg_bcg_object, Bcg_GET_BCG_FILE_NAME ());

#else

     /*
      * le parametre bcg_bcg_object ne sera pas utilise, car il sert
      * uniquement a passer de l'information a bcg_gate_init() ; on ajoute du
      * code pour eviter que les compilateurs C n'emettent un message
      * d'avertissement
      */

     (void) bcg_bcg_object;

#endif

}

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif
