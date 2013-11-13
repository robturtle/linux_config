# Brief: Make github push/pull faster

username="robturtle"

if [ "$1" == "" ]; then
    # TODO get parent directory's name
    echo "Specify a repo's name"
else
    repo=$(echo "$1" | cut -d'/' -f1) # remove trailing '/'
    echo "Speed up for repo $username/${repo}.git"
    ssh git@github.com git-receive-pack "$username/${repo}.git"
fi
