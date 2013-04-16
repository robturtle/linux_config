for d in $(ls -d *); do
	test -d "$d" || continue
	cd "$d"
	rm -rf bin .settings .classpath .project
	cd - > /dev/null
done
