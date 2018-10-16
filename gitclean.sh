_git_remove(){
	git filter-branch --index-filter "git rm --cached --ignore-unmatch $1" -- --all;
	# rm -Rf .git/refs/original; rm -Rf .git/logs/; git gc --aggressive --prune=now
	## verification
	#  git count-objects -v
}

z=`git verify-pack -v .git/objects/pack/pack-*.idx | sort -k 3 -n | tail -10 | cut -d' ' -f1`
#echo $z

for var in $z; do
	git rev-list --objects --all | grep $var 
done

# rm -Rf .git/refs/original; rm -Rf .git/logs/; git gc --aggressive --prune=now

_git_remove("*.deb*")