let
  zapan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy7D9IFOBh22J6dPDq/XURswrpCrmnlsdWHefjGUtPr zapan@zenbook";
  zenbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZBKgTiWIU358jlDvPB5qPf2i5szeVnLLGJrOy0WN0W root@zenbook";

  default = [
    zapan
    zenbook
  ];
in
{
  "agenix_zapan_key.age".publicKeys = default; # agenix zapan private key
  "ssh_key_general.age".publicKeys = default;
  "ssh_key_bandwagon.age".publicKeys = default;
  "ssh_key_home_git.age".publicKeys = default;
  "ssh_key_github_rsa.age".publicKeys = default;
  "deepseek_api_key.age".publicKeys = default;
  "context7_api_key.age".publicKeys = default;
  "moonshot_api_key.age".publicKeys = default;
  "bigmodel_api_key.age".publicKeys = default;
  "brave_search_api_key.age".publicKeys = default;
}
