{ ... }: {
  age = {
    identityPaths = [ "/var/lib/agenix/zenbook" ];
    secrets = {
      deepseek_api_key = {
        file = ./deepseek_api_key.age;
        group = "users";
        mode = "440";
      };
      context7_api_key = {
        file = ./context7_api_key.age;
        group = "users";
        mode = "440";
      };
      moonshot_api_key = {
        file = ./moonshot_api_key.age;
        group = "users";
        mode = "440";
      };
      bigmodel_api_key = {
        file = ./bigmodel_api_key.age;
        group = "users";
        mode = "440";
      };
    };
  };
}
