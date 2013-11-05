# Brief: Make github push/pull faster
# You may specify a folder which is your repo
# Otherwise it will search for every sub folder 
# might be your repo.
# 
# To make it faster, it will make a permenent ssh
# link in the background.

username="robturtle"

if [ "$1" == "" ]; then
    for dir in $(ls); do
        test -d "$dir" || continue
        dir=$(echo "$dir" | cut -d'/' -f1) # remove trailing '/'

        test -d "$dir/.git" \
        && echo "Speed up for repo $username/$dir" \
        && ssh git@github.com git-receive-pack "$username/$dir" &
    done
else
    repo=$(echo "$1" | cut -d'/' -f1) # remove trailing '/'
    echo "Speed up for repo $username/$repo"
    ssh git@github.com git-receive-pack "$username/$repo" &
fi
