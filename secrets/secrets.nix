let
  zapan =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINy7D9IFOBh22J6dPDq/XURswrpCrmnlsdWHefjGUtPr zapan@zenbook";
in { "deepseek_api_key.age".publicKeys = [ zapan ]; }
