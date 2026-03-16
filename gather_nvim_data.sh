#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

installed_plugins=$(rg -t lua -o --no-filename --no-heading --no-line-number -e "['\"]([\w-]+\/\w[^'\"]+)['\"]" ./nvim/.config/nvim /usr/share/omarchy-nvim/config/lua/plugins/all-themes.lua | sed 's/"//g' | sed "s/'//g" | sort --unique)

installed_plugins_total=$(echo "$installed_plugins" | wc -l)

awesome_neovim_md=$(curl -s "https://raw.githubusercontent.com/rockerBOO/awesome-neovim/refs/heads/main/README.md")
awesome_plugins_json=$(echo "$awesome_neovim_md" | awk '
    /^###?\s/ {
        category = $0
        gsub(/^###?\s+/, "", category)
    }

    /\-.*\(https:\/\/github\.com\// {
        match($0, /\[([^\]]*)\]/, arr)
        repo = arr[1]

        match($0, /\((https:\/\/github.com\/[^\/]*\/([^)]*))\)/, arr)
        url = arr[1]
        name = arr[2]

        match($0, /\)\s-\s(.*)/, arr)
        description = arr[1]
        gsub(/\\/, "\\\\", description)
        gsub(/"/, "\\\"", description)

        print sprintf("{\"category\":\"%s\",\"repo\":\"%s\",\"url\":\"%s\",\"description\":\"%s\",\"name\":\"%s\"}", category, repo, url, description, name)
    }
' | jq -s)

awesome_plugins_list_json=$(echo "$awesome_plugins_json" | jq -c '.[]')
awesome_plugins_total=$(echo "$awesome_plugins_json" | jq length)

i=1
echo "$awesome_plugins_list_json" | while read -r p; do
    name=$(echo "$p" | jq -r '.name')
    url=$(echo "$p" | jq -r '.url')
    category=$(echo "$p" | jq -r '.category')
    repo=$(echo "$p" | jq -r '.repo')
    description=$(echo "$p" | jq -r '.description' | sed "s/'/''/g")

    sqlite3 "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "INSERT OR REPLACE INTO plugins (name, url, category, repo, description) VALUES ('$name', '$url', '$category', '$repo', '$description');"

    percent=$((i * 100 / awesome_plugins_total))
    filled=$((percent / 4))
    bar=$(printf '█%.0s' $(seq 1 $filled))
    empty=$(printf '░%.0s' $(seq 1 $((25 - filled))))

    timestamp=$(date +%T.%3N)
    printf "\r\033[2K%s | Syncing awsome-neovim plugins %s%s %d%% (%d/%d)" "$timestamp" "$bar" "$empty" "$percent" "$i" "$awesome_plugins_total"

    i=$((i + 1))
done

missing_plugins_slugs=""

for p in $installed_plugins; do
    plugin=$(sqlite3 --json "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "SELECT * FROM plugins WHERE repo = '$p';")

    if [[ -z "$plugin" ]]; then
        missing_plugins_slugs="$missing_plugins_slugs$p"$'\n'
    fi
done

missing_plugins_total=$(echo "$missing_plugins_slugs" | wc -l)

nvim_app_missing_plugins_slugs=""

i=1
for p in $missing_plugins_slugs; do
    plugin_json=$(curl -H 'Accept: application/json' -s "https://nvim.app/repos-page?q=$p&limit=1")

    values=$(echo "$plugin_json" | jq '.[0] | [.name, .url, .category // "Uncategorised", .repo, .description]')

    name=$(echo "$values" | jq -r '.[0]')
    url=$(echo "$values" | jq -r '.[1]')
    category=$(echo "$values" | jq -r '.[2]')
    repo=$(echo "$values" | jq -r '.[3]')
    description=$(echo "$values" | jq -r '.[4]' | sed "s/'/''/g")


    percent=$((i * 100 / missing_plugins_total))
    filled=$((percent / 4))
    bar=$(printf '█%.0s' $(seq 1 $filled))
    empty=$(printf '░%.0s' $(seq 1 $((25 - filled))))

    timestamp=$(date +%T.%3N)
    printf "\r\033[2K%s | Syncing nvim.app plugins %s%s %d%% (%d/%d)" "$timestamp" "$bar" "$empty" "$percent" "$i" "$missing_plugins_total"

    if [[ "$p" == "$repo" ]]; then
        sqlite3 "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "INSERT OR REPLACE INTO plugins (name, url, category, repo, description) VALUES ('$name', '$url', '$category', '$repo', '$description');"
    else
        if [ -z "$nvim_app_missing_plugins_slugs" ]; then
            nvim_app_missing_plugins_slugs="$p"
        else
            nvim_app_missing_plugins_slugs="$nvim_app_missing_plugins_slugs"$'\n'"$p"
        fi
    fi

    i=$((i + 1))
done

missing_plugins_list=$(echo "$nvim_app_missing_plugins_slugs" | sed ':a;N;$!ba;s/\n/, /g;s/^/[/;s/$/]/' )

timestamp=$(date +%T.%3N)
printf '\n'$"%s | Missing plugins: %s\n" "$timestamp" "$missing_plugins_list"

editor_tools_json_list=$(cat ~/.local/share/nvim/mason/registries/github/mason-org/mason-registry/registry.json | jq -c '.[] | {name: .name, description: .description, languages: .languages, categories: .categories, url: .homepage}')

editor_tools_total=$(echo "$editor_tools_json_list" | wc -l)

i=1
echo "$editor_tools_json_list" | while read -r t; do
    name=$(echo "$t" | jq -r '.name')
    description=$(echo "$t" | jq -r '.description' | sed "s/'/''/g")
    languages=$(echo "$t" | jq -r '.languages | join(", ")')
    categories=$(echo "$t" | jq -r '.categories | join(", ")')
    url=$(echo "$t" | jq -r '.url')

    sqlite3 "$SCRIPT_DIR/nvim/.config/nvim/plugins.sqlite" "INSERT OR REPLACE INTO editor_tools (name, description, url, languages, categories) VALUES ('$name', '$description', '$url', '$languages', '$categories');"

    percent=$((i * 100 / editor_tools_total))
    filled=$((percent / 4))
    bar=$(printf '█%.0s' $(seq 1 $filled))
    empty=$(printf '░%.0s' $(seq 1 $((25 - filled))))

    timestamp=$(date +%T.%3N)
    printf "\r\033[2K%s | Syncing mason editor tools %s%s %d%% (%d/%d)" "$timestamp" "$bar" "$empty" "$percent" "$i" "$editor_tools_total"

    i=$((i + 1))
done
