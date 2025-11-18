#import "@preview/diatypst:0.7.1": *
#import "@preview/grayness:0.4.1": *

#set text(
  font: "JetBrains Mono",
)

// Doc: https://typst.app/universe/package/diatypst/
#show: slides.with(
  title: "Les systèmes d'exploitation",
  subtitle: "Emily of the Week",
  date: "2025-11-27",
  authors: "Emily Flion",

  ratio: 16 / 9, // Size of the slides
  layout: "medium", // Size of the slide elements, medium is fine
  title-color: rgb("#013AFB"), // Epitech's color
  toc: false, // Table of content
  count: "number", // Slide numbering
  theme: "normal", // Theme of the slides, "full" hurts the eyes
)

= | C'est quoi un OS ?

== C'est quoi un OS ?

#align(center + horizon)[
  *Ensemble de programmes qui dirige l'utilisation des ressources d'un ordinateur par des logiciels applicatifs*#footnote[Oui c'est juste la définition de wikipédia, je sais]
]

== Les composants

Il y a plusieurs composants dans un système d'exploitation:

- Noyau (Kernel)
- Bibliothèques système
- Applications utilisateurs

Les bibliothèques système et les applications utilisateurs sont considérées comme étant le *userspace*.

Le Noyau est appelé *kernel space*.

== Les applications utilisateurs

C'est toutes les applications que vous utilisez tout les jours:

- Navigateur Web
- Terminal
- Editeur de code
- Invite de commandes
- Utilitaires terminaux (comme `ls`, `find`, `grep`, etc...)
- Et tout plein d'autre

== Les bibliothèques système

Tout les essentiels à l'utilisation de votre système:

- La libc
- ncurses
- etc...

La ligne entre applications utilisateurs et bibliothèques système est très fine. Beaucoup disent que la distinction n'a pas d'intérêt à être faites.

== Le Noyau

Il n'y en a qu'un seul, mais il peut exister sous différentes façon:

- Noyaux monolithiques
- Micro-noyaux

La plupars des noyaux sont aujourd'hui monolithiques, mais certains micro-noyaux sont en cours de développements et sont plutot intéressant.

#let img-block(path) = image(path, height: 100pt)

#align(horizon, grid(
  columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
  [], img-block("assets/tux.svg"), [], img-block("assets/windows.svg"), [], img-block("assets/macos.svg"), [],
))

On ne parlera ici que des noyaux monolithiques cependant.

= | Comment ça marche ?

== Le démarrage

Plusieurs étapes doivent passer avant de pouvoir afficher une fenêtre.

Le première est tout simplement le boot (démarrage en bon Français), où le bootloader doit juste charger et lancer le noyau.

#align(center + horizon, image-show(read("assets/grub.webp", encoding: none), height: 120pt))

En fonction du système d'exploitation ou de l'architecture du système cela change *beaucoup*.

== Mise en place du matériel

Quand le noyau démarre, il mets en place tout le matériel qu'il peut.

- Slot PCI{,e} -> Une carte graphique par exemple
- Mémoire -> Surtout les plages mémoires utilisable
- Carte réseau -> Même si intégrée dans la carte mêre
- Et tout plein d'autres choses

#align(horizon + center)[
  *Bref, le noyau a beaucoup de travail à faire au démarrage*
]

== Lancement du userspace

On évite de tout faire tourner au même endroit que le noyau, pour des questions de sécurité et de prévention de crash.

Pour ça on lance un programme qu'on appelle l'*init*.

Sur Linux beaucoup d'init différents existent:

- systemd -> Presque partout
- OpenRC -> Rare de voir
- SysVinit -> Classique
- upstart -> Super mort de nos jours
- init -> L'original, plus du tout utilisé

== Le but du programme d'init

#align(center + horizon)[
  Lancer tout les services nécessaires à faire tourner le système, et lancer l'utilisateur principal dans une session utilisable.
]

== Communication entre userspace et kernelspace

Il faut bien pouvoir communiquer avec le noyau depuis des applications classiques de temps en temps.

Pour cela une seule solution:

#align(center)[
  *Les appels système*

  _syscall en Anglais_
]

Le but des appels systèmes c'est tout juste d'arréter l'execution du processeur, pour que le noyau puisse traiter une demande/tâche#footnote[sur x86, arm et riscv].

== Faire son propre OS ?

#align(horizon)[
  - Est-ce que c'est dur ? *Oui*

  - Est-ce que c'est intéressant ? *Oui*

  - Est-ce que vous devriez tenter ? *Oui ? Peut-être*
]

== EOTW - Les systèmes d'exploitation

#text(size: 32pt, align(center + horizon)[
  *Des questions ?*
])

