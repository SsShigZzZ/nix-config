{lib, ...}:

with lib;
{
  imports = [
    ./av
    ./cpu
    ./gpu
    ./input
    ./laptop
    ./nic
    ./storage
  ];
}
