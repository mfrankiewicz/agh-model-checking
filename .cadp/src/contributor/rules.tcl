 ###############################################################################
#                       C O N T R I B U T O R
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module              :       rules.tcl
#   Auteur              :       Julien HENRY
#   Version             :       1.24
#   Date                :       2014/05/02 16:12:42 
##############################################################################

#
# Ce modules contient les fonctions et les donnees necessaires au mecanisme
# de selection de fichiers par regle de Contributor.
#

#------------------------------------------------------------------------------

# Cette fonction recherche dans les repertoires liste's dans $directories_list
# des fichiers ayant le meme nom que $file mais avec l'une des extensions
# de $ext_list.
# Cette fonction facilite la definition de regles de selection pour les
# fichiers generes par les outils CADP.

proc exists_file {file directories_list ext_list} {

    set name [file rootname [file tail $file]]

    foreach ext $ext_list {
	foreach dir $directories_list {
	    if [file exists [file join $dir $name$ext]] {
		return 1
	    }
	}
    }

    return 0
}

#------------------------------------------------------------------------------

# Les 3 fonctions suivantes sont des applications de la fonction exists_file
# pouvant etre utilisees dans les conditions de selection de fichiers.

proc exists_file_in_this_directory {file ext_list} {
    return [exists_file $file [file dirname $file] $ext_list]
}

#------------------------------------------------------------------------------

proc exists_file_in_parent_directory {file ext_list} {
    return [exists_file $file [file dirname [file dirname $file]] $ext_list ]
}

#------------------------------------------------------------------------------

proc exists_file_in_child_directory {file ext_list} {
    set lentries [glob -nocomplain [file join $path "*"]]
    set dir_list {}
    foreach f $lentries {
	if { [file isdirectory $f] } {
	    lappend dir_list $f
	}
    }
    return [exists_file {$file $dir_list $ext_list} ]
}

#------------------------------------------------------------------------------

# Cette fonction retourne un booleen indiquant si le fichier $file contient au
# moins un des mots de $list_of_words.

proc file_contain_words {file list_of_words} {

    global GL

    set parameter [join $list_of_words |]

    if {[lsearch $GL(COMPRESSED_FORMAT) [file extension $file]] != -1} {
	global CADP_ZIP
	# le fichier $file est compresse : on le decompresse avant grep
	if {![catch {exec sh -c "$CADP_ZIP -d \"$file\" | egrep \"($parameter)\""}]} {
	    return 1
	} else {
	    return 0
	}
    } else {
	# le fichier $file n'est pas compresse
	if {![catch {exec sh -c "egrep \"($parameter)\" \"$file\""}]} {
	    return 1
	} else {
	    return 0
	}
    }
}

#------------------------------------------------------------------------------

# Cette fonction retourne un booleen indiquant si le fichier $file correspond
# a l'un des types listes dans $ext_list ; si le fichier $file est compresse
# on recupere l'extension qu'il aurait s'il etait non compresse : si $file
# vaut xxxx.bcg.gz, l'extension ".bcg" sera consideree et non ".gz".

proc file_of_type {file ext_list} {
    global GL

    set ext [file extension $file]
    if {[lsearch $GL(AUTH_COMPRESSED) $ext] != -1} {
	set ext [file extension [file rootname $file]]
    }
    if {[lsearch $ext_list $ext] != -1} {
	return 1
    } else {
	return 0
    }
}

#------------------------------------------------------------------------------

# Cette fonction retourne un booleen indiquant si le fichier $file a une
# taille en octet comprise entre $min_size et $max_size.

proc file_size_between {file min_size max_size} {
    set file_size [file size $file]
    if {($file_size < $min_size) || ($file_size > $max_size)} {
	return 0
    } else {
	return 1
    }
}

#------------------------------------------------------------------------------

# Cette fonction retourne un booleen indiquant si $file verifie ou non
# l'expression reguliere $regexp.

proc file_name_is {file regexp} {

    if { [regexp $regexp $file ] == $file } {
	return 1
    } else {
	return 0
    }
}

###############################################################################
# GL(CLASSES)
###############################################################################
#
# Contributor comprend un mecanisme lui permettant de finement selectionner
# les fichiers a envoyer. Ce systeme permet de definir des regles comme :
#   - ne selectionner que les LTS au format BCG qui ne font pas plus de 20 Mo
#   - ne selectionner que les .c qui accompagnent une specification LOTOS
#   - etc.
#
# Dans un premier temps, Contributor utilise la commande ``find'' pour
# construire une liste de fichiers a partir des repertoires de recherche et
# des extensions choisis par l'utilisateur. Chaque fichier de cette liste est
# ensuite teste avec les regles associees a son extension : si les regles
# ne sont pas toutes remplies, le fichier est exclus de la liste des fichiers
# a envoyer.
#
# La table GL(CLASSES) contient le descriptif des classes de fichiers reconnus
# par Contributor. A noter qu'une extension de fichier ne peut que dans une
# seule classe de fichier.
#
# Chaque entree de GL(CLASSES) est une liste de 3 elements :
#
#   - une chaine de caractere servant d'identifiant de classe de fichiers ;
#     cette chaine est utilisee a plusieurs endroits :
#
#       - comme identifiant dans le fichier $PREFERENCES_DIR/authorized_classes
#
#       - comme identifiant pour les objets graphiques de Tk ; cela impose que
#         l'identifiant soit un seul mot et qu'il doit imperativement
#         commencer par une miniscule
#
#   - une chaine de caractere decrivant la classe de fichiers. Elle est
#     utilisee dans la page de selection des fichiers a rechercher
#
#   - une liste contenant le descriptif des types associes a la classe de
#     fichiers ; chaque element est une liste de 2 elements :
#
#       - l'extension du type (precede par '.')
#
#       - un expression TCL evaluable a TRUE ou FALSE verifiant des proprietes
#         sur le fichier a tester. Le nom de ce fichier est contenu dans la
#         variable ``$file'' ; aucune autre variable ne doit etre utilisee.
#         D'autre part, cette expression est utilisee telle quelle comme
#         condition d'un "if" ; elle doit donc imperativement respecter les
#         regles syntaxique de TCL. 

set GL(CLASSES) {
    {   CLASS_LOTOS
	"LOTOS specifications and related files (.lotos .lot .l .f .h .lib .t)"
	{   {".lotos" {![file_contain_words "$file" {"generated by lnt2lotos"}]}} 
	    {".lot"   {[file_contain_words "$file" {"type" "process" "specification"}]}} 
	    {".l"     {[file_contain_words "$file" {"type" "process" "specification"}]}} 
	    {".lib"  {![file_contain_words "$file" {"generated by lnt2lotos"}]}}
	    {".h"    {[exists_file_in_this_directory "$file" {.lotos .lot .l}] && ![file_contain_words "$file" {"generated by caesar" "TRAIAN_ADT"}]}}
	    {".f"    {[exists_file_in_this_directory "$file" {.lotos .lot .l}] && ![file_contain_words "$file" {"generated by lnt2lotos"}]}}
	    {".t"    {[exists_file_in_this_directory "$file" {.lotos .lot .l}] && ![file_contain_words "$file" {"generated by lnt2lotos"}]}}
	}
    }
    {   CLASS_LOTOSNT
	"LNT specifications and related files (.lnt .fnt .tnt)"
	{   {".lnt" {![file_contain_words "$file" {"generated by lpp"}]}}
	    {".fnt" {[exists_file_in_this_directory "$file" {.lnt}]}}
	    {".tnt" {[exists_file_in_this_directory "$file" {.lnt}]}}
	}
    }
    {   CLASS_FSP
	"FSP specifications (.lts)"
	{   {".lts" {TRUE}}
	}
    }
    {   CLASS_LTS
	"(Networks of) Labelled Transition Systems (.aut .bcg .exp .fc2 .seq)"
	{   {".bcg" {[file_size_between "$file" 10240 104857600]}}
	    {".exp" {TRUE}}
	    {".aut" {[file_size_between "$file" 20480 20971520]}}
	    {".seq" {[file_size_between "$file" 20480 20971520]}}
	    {".fc2" {TRUE}}
	}
    }
    {   CLASS_BES
	"Boolean Equation System (.bes .blk .rbc)"
	{   {".bes" {TRUE}}
	    {".blk" {TRUE}}
	    {".rbc" {TRUE}}
	}
    }
    {   CLASS_MCL
	"Temporal Logic Formulas (.mcl .xtl)"
	{   {".mcl" {TRUE}}
	    {".xtl" {TRUE}}
	}
    }
    {   CLASS_MISC
	"Miscellaneous (.hid .hide .io .ren .rename .svl)"
	{   {".svl"    {TRUE}}
	    {".hid"    {TRUE}}
	    {".hide"   {TRUE}}
	    {".ren"    {TRUE}}
	    {".rename" {TRUE}}
	    {".io"     {TRUE}}
	}
    }
}

# Notes :
#    1) La chaine "generated by caesar" couvre aussi "generated by caesar.adt"
#       c'est-a-dire les fichiers .c produits par Caesar et les fichiers .h
#       produits par Caesar.adt.
#    2) La chaine "TRAIAN_ADT" couvre les fichiers _f.h et _t.h produits par
#       Traian.

#------------------------------------------------------------------------------

