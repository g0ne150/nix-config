let
  zapan =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy7D9IFOBh22J6dPDq/XURswrpCrmnlsdWHefjGUtPr zapan@zenbook";
  zenbook =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZBKgTiWIU358jlDvPB5qPf2i5szeVnLLGJrOy0WN0W root@zenbook";

  default = [ zapan zenbook ];
in {
  "deepseek_api_key.age".publicKeys = default;
  "context7_api_key.age".publicKeys = default;
}
