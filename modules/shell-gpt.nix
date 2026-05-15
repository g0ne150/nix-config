{ ageSecrets, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "sgpt";
      runtimeInputs = [ pkgs.shell-gpt ];
      text = ''
        OPENAI_API_KEY="$(cat ${ageSecrets.deepseek_api_key.path})"
        export OPENAI_API_KEY
        export API_BASE_URL=https://api.deepseek.com
        export DEFAULT_MODEL=deepseek-v4-flash
        exec sgpt "$@"
      '';
    })
  ];
}
