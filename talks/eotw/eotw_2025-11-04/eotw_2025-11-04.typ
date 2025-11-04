#import "@preview/diatypst:0.7.1": *

#set text(
  font: "JetBrains Mono",
)

// Doc: https://typst.app/universe/package/diatypst/
#show: slides.with(
  title: "La gestion de projet Open Source",
  subtitle: "Emily of the Week",
  date: "2025-11-04",
  authors: "Emily Flion",

  ratio: 16 / 9, // Size of the slides
  layout: "medium", // Size of the slide elements, medium is fine
  title-color: rgb("#013AFB"), // Epitech's color
  toc: false, // Table of content
  count: "number", // Slide numbering
  theme: "normal", // Theme of the slides, "full" hurts the eyes
)

= | Open Source ?

== OpenSource ?

/ Source Available: Avoir du code source disponible de façon publique

/ Free Software/Logiciel Libre: Logiciel qui respecte certaines libertés des utilisateurs

Un logiciel libre est forcément un logiciel Source Available, mais un logiciel Source Available n'est pas forcément un logiciel libre.

== Le logiciel libre

Selon la Free Software Foundation, il faut ces 4 libertés :

- La liberté d'*exécuter le programme*, pour tous les usages
- La liberté d'*étudier le fonctionnement* du programme et de l'*adapter à ses besoins*
- La liberté de *redistribuer des copies du programme* (ce qui implique la possibilité aussi bien de donner que de vendre des copies)
- La liberté d'*améliorer le programme* et de *distribuer ces améliorations* au public, pour en faire profiter toute la communauté

== Des exemples

/ Source Available: Redis#footnote[Redis est un cas un peu particulier, son status en tant que projet libre est fortement contesté], Unreal Engine, Amazon Lumberyard, GitLab Enterprise

/ Free Software: Linux, Blender, Krita, VSCode, SQlite#footnote[SQLite est un projet qui ne prends *aucune contribution externe*], MediaWiki

Il y a des logiciels libres et des logiciels source available partout.

= | Comment ça marche ?

== Communauté

Les projets Open Source sont des projets communautaires #footnote[À quelques exceptions prêt, comme SQLite].

Cependant tout les projets ne gèrent pas leurs communautés de la même façon.

Plusieurs choses sont à prendre en compte:
- Les *contributions*
- La/les *licence(s)*
- Les *communications*

== Les licences

Il y a plein de licences Open Source:

/ Permissives et Public Domain: MIT, BSD, Apache, CC
/ Copyleft: GPL, AGPL, LGPL, EUPL
/ Source Available: SSPL#footnote[Débatu aujourd'hui encore, certaine personnes l'appelle copyleft], BSL, Commons Clause

== Les contributions

Un projet va généralement utiliser un système de versioning comme Git, et il y a plusieurs façon d'accepter des contributions avec Git:

- *PR/MR* (Pull Requests/Merge Requests)
- *Mailing lists*

Les systèmes de PR/MR sont bien plus récent et moderne, mais contiennent quelques désavantages par rapport au fonctionnement traditionnel des mailing lists.

== Communications

Sujet compliqué dans la plupars des logiciels libres, il y a plusieurs façon de communiquer avec sa communauté:

- Serveur centrale de communication (Discord, Matrix, ...)
- Communications décentralisées (IRC, Mails, ...)

Les serveurs centraux sont bien plus attrayant de nos jours.

Cependant ils génèrent de la frustration pour certaines personnes, car forçant les communications sur des plateformes propriétaires, la plupars du temps.

== One platform to rule them all

#align(center)[
  #image("assets/github.svg", width: 40%)
  *GitHub ?*
]

= | Et l'EIP dans tout ça ?

== Des EIP Open Source

Il y en a pas des tonnes, mais certains existent:

- *CubicServer* (oui c'est mon EIP mais bon :p)
- *ATMO Engine* (EIP Toulousain tek4)
- *DaiC* (EIP Toulousain tek5)
- *NanoForge* (EIP Parisien tek4)

C'est presque toujours forcément des EIP technique, cependant il est possible de faire un EIP solution ou business en Open Source.

== Pourquoi faire de l'Open Source

#align(center + horizon)[
*Visibilité*

*Contributions*

*Communauté*
]

== Conclusion

#align(center + horizon)[
*Faites de l'Open Source, c'est cool l'Open Source ;)*
]
