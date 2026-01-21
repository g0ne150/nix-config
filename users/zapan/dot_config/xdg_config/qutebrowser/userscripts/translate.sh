#!/bin/bash

# 获取文本内容：优先参数，其次选中文本
TEXT="$*"
if [ -z "$TEXT" ]; then
    TEXT="$QUTE_SELECTED_TEXT"
fi

# 如果还是空，退出
if [ -z "$TEXT" ]; then
    echo "No input or selection provided." >&2
    exit 1
fi

# 目标语言（可修改）
TARGET_LANG="zh-CN"

# URL 编码函数
urlencode() {
    local data
    data=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1")
    echo "$data"
}

ENCODED_TEXT=$(urlencode "$TEXT")

# 构造 Google Translate URL
URL="https://translate.google.com/?sl=auto&tl=${TARGET_LANG}&text=${ENCODED_TEXT}&op=translate"

# 发命令到 qutebrowser 打开新标签页
echo ":open --tab $URL" >> "$QUTE_FIFO"
