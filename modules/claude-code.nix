{ pkgs, ageSecrets, ... }: {
  programs.claude-code = { enable = true; };

  home.file.".local/bin/claude-deepseek" = {
    executable = true;
    text = ''
      #!/bin/bash
      set -eu
      export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
      export ANTHROPIC_AUTH_TOKEN="$(cat ${ageSecrets.deepseek_api_key.path})"
      export API_TIMEOUT_MS=600000
      export ANTHROPIC_MODEL=deepseek-chat
      export ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat
      export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

      ${pkgs.claude-code}/bin/claude "$@"
    '';
  };
}
