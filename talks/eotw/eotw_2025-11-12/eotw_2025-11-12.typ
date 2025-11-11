#import "@preview/diatypst:0.7.1": *

#set text(
  font: "JetBrains Mono",
)

// Doc: https://typst.app/universe/package/diatypst/
#show: slides.with(
  title: "Le Zig",
  subtitle: "Emily of the Week",
  date: "2025-11-12",
  authors: "Emily Flion",

  ratio: 16 / 9, // Size of the slides
  layout: "medium", // Size of the slide elements, medium is fine
  title-color: rgb("#013AFB"), // Epitech's color
  toc: false, // Table of content
  count: "number", // Slide numbering
  theme: "normal", // Theme of the slides, "full" hurts the eyes
)

= | C'est quoi le Zig ?

== Le C c'est cool mais...

- Erreurs facile à faire
- Système de build non-existant
- Pas de génériques
- Cross plateforme compliqué
- Syntaxe qui peut devenir compliqué

= | Une syntaxe proche du C, mais pas que...

== Hello World

Hello World en Zig:
```Zig
const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello, World!\n");
}
```

== Structures

Les structures en Zig:
```Zig
// Déclaration de la structure
const Point = struct {
    x: f32,
    y: f32,
};

// Instanciation de la structure
const p: Point = .{
    .x = 0.12,
    .y = 0.34,
};
```

== Classes ?

Faire des "classes" c'est possible:
```Zig
const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vec3 {
        return Vec3{.x = x, .y = y, .z = z};
    }

    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }
};
```

== Les tests c'est important

Les tests sont inclus dans le languages:
```Zig
test "dot product" {
    // Pas besoin de préciser le type si déduisible par le compilateur
    const v1 = Vec3.init(1.0, 0.0, 0.0);
    const v2 = Vec3.init(0.0, 1.0, 0.0);
    try expect(v1.dot(v2) == 0.0);

    // La syntaxe du dessus est juste du sucre syntaxique
    // On peut aussi l'écrire comme ça
    try expect(Vec3.dot(v1, v2) == 0.0);
}
```

== Les int c'est cool

On peut aussi avoir les tailles d'int qu'on veut:
```Zig
const a: u2 = 3; // Valide
const b: i3 = 4; // Erreur de compilation: Valeur trop grande
const c: u65535 = 0x67_3141_59265358_979_DEAD_CAFE // Valide
const d: i65536 = -42 // Erreur de compilation: Type trop grand
```

== Un système de build complet

Tout est configurable dans le fichier `build.zig` qui est lui même écrit en Zig.

```Zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("hello.zig"),
            .target = b.graph.host,
        }),
    });

    b.installArtifact(exe);
}
```

== Un système de build complet

Résultat d'un `zig build`:
```sh
$ zig build --summary all

Build Summary: 3/3 steps succeeded
install success
└─ install hello success
   └─ compile exe hello Debug native success 1s MaxRSS:136M
```

== ...et aussi cross plateforme!

Exemple de la sortie sur `liskvork`:
```sh
$ zig build -Dbuild_all -Doptimize=ReleaseSmall && ls zig-out/bin
liskvork-aarch64-freebsd-0.6.0-dev
liskvork-aarch64-linux-0.6.0-dev
liskvork-aarch64-macos-0.6.0-dev
liskvork-aarch64-netbsd-0.6.0-dev
liskvork-aarch64-windows-0.6.0-dev.exe
liskvork-riscv64-freebsd-0.6.0-dev
liskvork-riscv64-linux-0.6.0-dev
liskvork-x86_64-freebsd-0.6.0-dev
liskvork-x86_64-linux-0.6.0-dev
liskvork-x86_64-macos-0.6.0-dev
liskvork-x86_64-netbsd-0.6.0-dev
liskvork-x86_64-windows-0.6.0-dev.exe
```

C'est super simple!

== Les slices c'est vraiment sympa

```Zig
const std = @import("std");

const hello: []const u8 = "Hello";
const world: []const u8 = "World";

// C'est un tableau, pas une slice ici!
var all_together: [100]u8 = undefined;
// On concatène
// Attention à bien faire la coercion faire une slice!
const hello_world = try std.fmt.bufPrint(&all_together_slice, "{s} {s}", .{ hello, world });

try expect(std.mem.eql(u8, hello_world, "Hello World"));
```

== Appeler des fonctions C ?

Mais oui c'est possible! #strike[Avec la carte kiwi]
```Zig
const c = @cImport({
    @cInclude("stdio.h");
});
pub fn main() void {
    _ = c.printf("Hello from C!\n");
}
```

== Code compile time

#strike[Presque] Tout code Zig peut tourner au compile time:
```Zig
fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}
fn gimmeTheBiggerFloat(a: f32, b: f32) f32 {
    return max(f32, a, b);
}
fn gimmeTheBiggerInteger(a: u64, b: u64) u64 {
    return max(u64, a, b);
}

fn main() {
    const result = gimmeTheBiggerInteger(67, 42);
    const comptime_result = comptime gimmeTheBiggerInteger(67, 42);
}
```

= | C'est utilisé ?

== C'est utilisé ?

Réponse courte:
*Oui*

Réponse longue:
*Oui?*

Quelques projets Zig réels existent aujourd'hui, mais il n'y en a pas beaucoup:
- TigerBeetle | Base de donnés
- Bun | Runtime javascript
- ncdu | Utilitaire de disque
- liskvork | _Meilleur projet trust_

Ce n'est pas un language très utilisé, mais il commence à se faire sa place.

#strike[Dans tout les cas Zig > Rust]

== C'est utilisé ?

#align(center + horizon)[
*Mais du coup c'est utile d'apprendre le Zig là maintenant ?*
]

== C'est utilisé ?

#align(center + horizon)[
*Oui!*

En plus c'est un language qui est très confortable et fun à utiliser.
]
