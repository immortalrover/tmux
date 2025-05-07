{ lib, pkgs }:

let
  hr =
    text:
    let
      parts = builtins.split "." text;
    in
    builtins.foldl' (text: part: if builtins.isList part then "${text}-" else text) "" (
      builtins.tail parts
    );

  config-files = lib.snowfall.fs.get-files-recursive ./config;
  extra-config = lib.concatMapStringsSep "\n" (file: ''
    # ${file}
    # ${hr file}

    ${builtins.readFile file}
  '') config-files;

  plugins = (
    with pkgs.tmuxPlugins;
    [
      sensible
    ]
  );
in
lib.mkConfig {
  inherit pkgs plugins extra-config;
}
