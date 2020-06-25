# $ nix-build -E 'with import <nixpkgs> {}; callPackage ./pcre.nix {}'
# source: https://releases.nixos.org/nix-dev/2017-July/024061.html

{ stdenv, fetchurl }:

let
  version = "8.44";
in

stdenv.mkDerivation {
  name = "pcre-${version}";

  src = fetchurl {
    url = "https://ftp.pcre.org/pub/pcre/pcre-${version}.tar.bz2";
    sha256 = "0v9nk51wh55pcbnf2jr36yarz8ayajn6d7ywiq2wagivn9c8c40r";
  };

  configureFlags = [
    "--disable-shared"
    "--enable-unicode-properties"
    "--enable-utf8"
  ];
}
