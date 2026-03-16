SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

installed_plugins=$(rg -t lua -o --no-filename --no-heading --no-line-number -e "['\"]([\w-]+\/\w[^'\"]+)['\"]" ./nvim/.config/nvim /usr/share/omarchy-nvim/config/lua/plugins/all-themes.lua | sed 's/"//g' | sed "s/'//g" | sort --unique)

installed_plugins_total=$(echo "$installed_plugins" | wc -l)

plugins=""
for p in $installed_plugins; do
    plugin=$(sqlite3 --json "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "SELECT * FROM plugins WHERE repo = '$p';" | jq '.[0]')
    
    if [[ -z "$plugin" ]]; then
        continue
    fi

    plugins="${plugins:+$plugins,}$plugin"
done

plugins=$(echo "[$plugins]" | jq -r 'group_by(.category) | .[] | "#### \(.[0].category)\n\(map("- [\(.repo)](\(.url)) - \(.description)") | join("\n"))\n"')

installed_editor_tools=$(ls ~/.local/share/nvim/mason/packages)

editor_tools=""
for t in $installed_editor_tools; do
    tool=$(sqlite3 --json "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "SELECT * FROM editor_tools WHERE name = '$t';" | jq '.[0]')
    editor_tools="${editor_tools:+$editor_tools,}$tool"
done

editor_tools=$(echo "[$editor_tools]" | jq -r '
  ["harper-ls", "ltex-ls", "prettier"] as $skip |
  map(
    . as $item |
    (.categories | split(", ")) |
    .[] |
    {name: $item.name, url: $item.url, description: $item.description, languages: ($item.languages | split(", ")), category: .}
  ) |
  group_by(.category) |
  .[] |
  "#### \(.[0].category)\n\(map("- [\(.name)](\(.url)) - \(.description) \(if (.name | IN($skip[])) then "" else (.languages | map("<img align=\"top\" src=\"https://img.shields.io/badge/\(.)-_?style=for-the-badge&logo=\(.)&color=rgb(0%200%200%20%2F%200%25)\" />") | join(" ")) end)") | join("\n"))\n"
' | sed 's/logo=HTML/logo=html5/g' | sed 's/logo=SCSS/logo=sass/g' | sed 's/logo=Vue/logo=vuedotjs/g' | sed 's/logo=C++/logo=cplusplus/g' | sed 's/&logo=C#//g' | sed 's/C#/C%23/g' | sed 's/logo=CSS/logo=tailwindcss/g' | sed 's/CSS-_/Tailwind CSS-_/g')

python3 -c "
import sys
content = open('./readme_template.md').read()
content = content.replace('{plugins}', sys.argv[1])
content = content.replace('{editor_tools}', sys.argv[2])
print(content, end='')
" "$plugins" "$editor_tools" > ./README.md
