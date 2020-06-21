/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_aldebaran_initialisations.h
 *   Auteur             :       Hubert GARAVEL et Frederic LANG
 *   Version            :       1.21
 *   Date               :       2014/12/23 12:05:45
 *****************************************************************************/

#ifndef BCG_ALDEBARAN_INITIALISATIONS

#define BCG_ALDEBARAN_INITIALISATIONS

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

/*
 * le present fichier assure la compatibilite ascendante avec les fichiers
 * BCG produits par les versions de CADP depuis l'origine jusqu'a 2014-l
 * inclus ; les nouveaux fichiers BCG produits a partir de CADP 2015-a inclus
 * n'utilisent plus ce fichier
 */

#define BCG_VERSION_ALDEBARAN_INITIALISATIONS 2	

/*
 * ce fragment de code est inclus dans la zone des includes des fichiers BCG,
 * puis il est repris pour etre inclus dans la bibliotheque dynamique, et
 * plus precisement dans la fonction Bcg_INITIALIZATIONS() qui prend un
 * parametre bcg_bcg_object different de NULL
 */

{

#ifndef BCG_VERSION_ALDEBARAN_DEFINITIONS

     /*
      * on est dans le cas d'un ancien fichier BCG produit par une version de
      * CADP anterieure a CADP 2008-a inclus
      */

#if bcg_gate_size > 0

     /*
      * l'option "-unparse" n'a pas ete utilisee (c'est-a-dire, il y a au
      * moins une porte), la zone include de ce fichier BCG definit un
      * tableau bcg_gate_string[] qui n'est plus utilise par les versions
      * recentes de CADP ; on ajoute du code pour que les compilateurs C
      * n'emettent pas un avertissement "variable non utilisee"
      */
     (void) bcg_gate_string[0];
#endif

#endif

}

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
