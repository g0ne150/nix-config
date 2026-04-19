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
  home.file.".claude/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/nix-dotfiles/dot_claude/settings.json";
  };
  programs.claude-code = {
    enable = true;
    # mcpServers = {
    # };
    skills = ./skills;
  };

  home.file.".local/bin/claude-qwen" = {
    executable = true;
    text = common_script + ''
      export ANTHROPIC_BASE_URL=https://openrouter.ai/api
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.openrouter_api_key.path})"
      export ANTHROPIC_API_KEY=""
      export API_TIMEOUT_MS=600000
      export ANTHROPIC_MODEL=qwen/qwen3.6-plus:free
      export ANTHROPIC_DEFAULT_OPUS_MODEL=qwen/qwen3.6-plus:free
      export ANTHROPIC_DEFAULT_SONNET_MODEL=qwen/qwen3.6-plus:free
      export ANTHROPIC_DEFAULT_HAIKU_MODEL=qwen/qwen3.6-plus:free
      export CLAUDE_CODE_SUBAGENT_MODEL=qwen/qwen3.6-plus:free

      exec claude "$@"
    '';
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
