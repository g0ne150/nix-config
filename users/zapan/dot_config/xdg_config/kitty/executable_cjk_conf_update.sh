#!/bin/bash

# 用法提示
if [ "$#" -lt 2 ]; then
  echo "用法: $0 <配置文件路径> <新字体名称> [输出文件]"
  echo "示例: $0 cjk-symbol-map.conf 'LXGW WenKai Mono'"
  exit 1
fi

input_file="$1"
new_font="$2"
output_file="${3:-$input_file}"  # 默认覆盖原文件

# 使用 awk 保留注释并替换字体名
awk -v font="$new_font" '
{
  if ($1 == "symbol_map") {
    # 分离注释部分（# 开头及之后）
    comment = ""
    for (i = 4; i <= NF; i++) {
      if ($i ~ /^#/) {
        comment_start = i
        comment = $i
        for (j = i + 1; j <= NF; j++) comment = comment " " $j
        break
      }
    }
    printf "%s %s %s", $1, $2, font
    if (comment != "") printf " %s", comment
    printf "\n"
  } else {
    print
  }
}
' "$input_file" > "$output_file.tmp" && mv "$output_file.tmp" "$output_file"

echo "✔ 所有 symbol_map 行字体已替换为：$new_font"
