{
  pkgs,
  jetbrains-mono,
}:
pkgs.buildTypstDocument rec {
  name = "eotw_2025-11-27";
  src = ./.;
  file = "${name}.typ";
  format = "pdf";
  typstEnv = p: [p.diatypst p.grayness];

  buildPhase = ''
    runHook preBuild
    mkdir -p $out
    typst c ${file} --root ./ -f ${format} $out/${name}.pdf
    runHook postBuild
  '';
}
