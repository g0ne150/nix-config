{ ... }:
{
  age = {
    identityPaths = [ "/var/lib/agenix/zenbook" ];
    secrets = {
      zenbook_wg_private_key = {
        file = ./zenbook_wg_private_key.age;
      };
      ssh_key_general = {
        file = ./ssh_key_general.age;
        path = "/home/zapan/.ssh/general";
        mode = "400";
        owner = "zapan";
        group = "users";
      };
      ssh_key_bandwagon = {
        file = ./ssh_key_bandwagon.age;
        path = "/home/zapan/.ssh/bandwagon";
        mode = "400";
        owner = "zapan";
        group = "users";
      };
      ssh_key_home_git = {
        file = ./ssh_key_home_git.age;
        path = "/home/zapan/.ssh/home_git";
        mode = "400";
        owner = "zapan";
        group = "users";
      };
      ssh_key_github_rsa = {
        file = ./ssh_key_github_rsa.age;
        path = "/home/zapan/.ssh/github_rsa";
        mode = "400";
        owner = "zapan";
        group = "users";
      };
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
      kimi_api_key = {
        file = ./kimi_api_key.age;
        group = "users";
        mode = "440";
      };
      bigmodel_api_key = {
        file = ./bigmodel_api_key.age;
        group = "users";
        mode = "440";
      };
      brave_search_api_key = {
        file = ./brave_search_api_key.age;
        group = "users";
        mode = "440";
      };
    };
  };
}
