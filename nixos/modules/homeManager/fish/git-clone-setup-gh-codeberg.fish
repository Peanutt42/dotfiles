if test -z "$repo"
	echo "Usage: clone-mirror <repo-dir> [codeberg_url github_url]"
	return 1
end

if test -d "$repo"
	if not test -d "$repo/.git"
		echo "Error: $repo exists but is not a git repository"
		return 1
	end

	set already_cloned 1
	set repo_dir (path resolve "$repo")
	set repo_name (basename "$repo_dir")
else
	set already_cloned 0
	set repo_dir "./$repo"
	set repo_name "$repo"
end

if test -z "$codeberg_url"
	set codeberg_url "git@codeberg.org:Peanutt42/$repo_name.git"
end
if test -z "$github_url"
	set github_url "git@github.com:Peanutt42/$repo_name.git"
end

if test $already_cloned -eq 0
	echo "Cloning $codeberg_url..."
	git clone "$codeberg_url" "$repo_dir"; or return 1
	echo ""
end

cd "$repo_dir"; or return 1

git remote set-url origin "$codeberg_url"; or return 1

git config --unset-all remote.origin.pushurl 2>/dev/null

git remote set-url --add --push origin "$codeberg_url"; or return 1
git remote set-url --add --push origin "$github_url"; or return 1

echo "Successfully setup GitHub and Codeberg origin remote urls:"
git remote -v
