with (import <nixpkgs> {});
let
  env = bundlerEnv {
    name = "cvl-monet.github.io-bundler-env";
    inherit ruby;
    gemfile  = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset   = ./gemset.nix;
  };
in mkShell {
  nativeBuildInputs = [ zlib poppler_utils ruby ];
  buildInputs = [ env ];
  shellHook = ''
    serve() {
      bundle exec jekyll serve --watch
    }
    bundle exec jekyll build
'';
}
