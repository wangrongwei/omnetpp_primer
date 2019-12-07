
#git verify-pack -v .git/objects/pack/pack-*.idx | sort -k 3 -g | tail -5

#git rev-list --objects --all | grep 8f10eff91bb6aa2de1f5d096ee2e1687b0eab007

#git filter-branch --index-filter 'git rm --cached --ignore-unmatch <your-file-name>'
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git fsck --full --unreachable
git repack -A -d
git gc --aggressive --prune=now
git push --force
