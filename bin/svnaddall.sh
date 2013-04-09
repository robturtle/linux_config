svn st | grep '^\?' | grep -v 'build' | tr '^?' ' ' | sed 's/[ ]*//' | sed 's/[ ]/\ /g' | xargs svn add
