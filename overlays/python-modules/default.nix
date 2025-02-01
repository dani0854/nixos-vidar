{ pkgs }:
final: prev:
with pkgs;
with final;
{
  milc = callPackage ./milc { };
}
