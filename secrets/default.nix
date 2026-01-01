{ config, ... }: {
  age.secrets.deepseek_apk_key = { file = "./deepseek_api_key.age"; };
}
