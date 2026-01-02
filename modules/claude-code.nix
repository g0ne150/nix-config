{ ageSecrets, ... }: {
  programs.claude-code = {
    enable = true;
    mcpServers = {
      context7 = {
        type = "http";
        url = "https://mcp.context7.com/mcp";
        headers = { CONTEXT7_API_KEY = "$CONTEXT7_API_KEY"; };
      };
    };
  };

  home.file.".local/bin/claude-deepseek" = {
    executable = true;
    text = ''
      #!/bin/sh
      set -eu
      export CONTEXT7_API_KEY="$(cat ${ageSecrets.context7_api_key.path})"
      export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.deepseek_api_key.path})"
      export API_TIMEOUT_MS=600000
      export ANTHROPIC_MODEL=deepseek-chat
      export ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat
      export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

      exec claude "$@"
    '';
  };
  home.file.".local/bin/claude-k2" = {
    executable = true;
    text = ''
      #!/bin/sh
      set -eu
      export CONTEXT7_API_KEY="$(cat ${ageSecrets.context7_api_key.path})"
      export ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.moonshot_api_key.path})"
      export ANTHROPIC_MODEL=kimi-k2-thinking
      export ANTHROPIC_DEFAULT_OPUS_MODEL=kimi-k2-thinking
      export ANTHROPIC_DEFAULT_SONNET_MODEL=kimi-k2-thinking
      export ANTHROPIC_DEFAULT_HAIKU_MODEL=kimi-k2-thinking
      export CLAUDE_CODE_SUBAGENT_MODEL=kimi-k2-thinking

      exec claude "$@"
    '';
  };
}
