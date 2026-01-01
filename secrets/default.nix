{ ... }: {
  age.identityPaths = [ "/var/lib/agenix/zenbook" ];
  age.secrets.deepseek_api_key = {
    file = ./deepseek_api_key.age;
    group = "users";
    mode = "440";
  };
}
