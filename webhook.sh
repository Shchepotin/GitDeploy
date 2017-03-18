#!/bin/sh

datetime=$(date '+%Y-%m-%d %H:%M:%S')

echo "======================= Start webhook: $datetime ======================= \n"

path_to_source=$(dirname "${BASH_SOURCE[0]}")
current_path=$(pwd)
git_deploy_path="$current_path/$path_to_source"

cd "$git_deploy_path"

source ./config.conf

#
# Queue.
#
if [[ ! -e "status.txt" ]]; then
    echo "wait" > status.txt

    while [[ "$(<status.txt)" = "wait" ]]
    do
        echo "" > status.txt

        cd $path

        config_name=$(git config --global user.name)
        config_email=$(git config --global user.email)

        if [[ "$config_name" = "" ]]; then
            git config --global user.name "$login"
        fi

        if [[ "$config_email" = "" ]]; then
            git config --global user.email "$email"
        fi

        git config remote.origin.url "$url"
        git remote update

        cd $git_deploy_path

        if [[ ! -e "hash.txt" ]]; then
            echo "" > hash.txt
        fi

        local=$(<hash.txt)

        cd $path

        remote=$(git rev-parse "$remote_branch")

        if [[ "$local" != "$remote" ]]; then
            echo "Start pull..."

            git add .
            git commit -m "Deploy"
            git pull -Xtheirs --no-commit

            cd $git_deploy_path
            # Save last hash
            echo "$remote" > hash.txt

            # Run commands after pull
            source ./commands.sh
            cd $path
        fi

        cd $git_deploy_path
    done

    rm -rf status.txt
else
   echo "wait" > status.txt
fi

echo ""