{
  ageSecrets,
  config,
  pkgs,
  ...
}:
let
  common_script = ''
    #!${pkgs.bash}/bin/bash
    set -eu
    export {all,http,https}_proxy=http://127.0.0.1:1080;
    export BRAVE_SEARCH_API_KEY="$(cat ${ageSecrets.brave_search_api_key.path})"

  '';
in
{
  home.file.".claude/CLAUDE.md" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/nix-dotfiles/dot_claude/CLAUDE.md";
  };
  programs.claude-code = {
    enable = false;
    # mcpServers = {
    # };
    skillsDir = ./skills;
  };

  home.file.".local/bin/claude-deepseek" = {
    executable = true;
    text = common_script + ''
      export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.deepseek_api_key.path})"
      export API_TIMEOUT_MS=600000
      export ANTHROPIC_MODEL=deepseek-chat
      export ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat
      export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

      exec claude "$@"
    '';
  };
  home.file.".local/bin/claude-kimi" = {
    executable = true;
    text = common_script + ''
      # export ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic
      # export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.moonshot_api_key.path})"
      # export ANTHROPIC_MODEL=kimi-k2.5
      # export ANTHROPIC_DEFAULT_OPUS_MODEL=kimi-k2.5
      # export ANTHROPIC_DEFAULT_SONNET_MODEL=kimi-k2.5
      # export ANTHROPIC_DEFAULT_HAIKU_MODEL=kimi-k2.5
      # export CLAUDE_CODE_SUBAGENT_MODEL=kimi-k2.5
      export ANTHROPIC_BASE_URL=https://api.kimi.com/coding/
      export ANTHROPIC_API_KEY=$(cat ${ageSecrets.kimi_api_key.path})

      exec claude "$@"
    '';
  };
  home.file.".local/bin/claude-glm" = {
    executable = true;
    text = common_script + ''
      export ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.bigmodel_api_key.path})"
      export API_TIMEOUT_MS="3000000"
      export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

      exec claude "$@"
    '';
  };
}
