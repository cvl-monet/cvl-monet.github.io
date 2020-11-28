{ pkgs ? import <nixpkgs> {},
  ruby ? pkgs.ruby_2_7}:
let
 gems = pkgs.bundlerEnv {
    name = "exampleApp";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
    # groups = [ "default" "production" "development" "test" ];
  };
in
with pkgs;
mkShell {
  nativeBuildInputs = [ zlib ];
  buildInputs = [ gems ];
  shellHook = ''
    bundle exec jekyll build
  '';
}

