## `gh_move_data` 

This is a quick solution to import favorites. If you have an alternate account or moving account, you can use Github CLI to export your old favorites with the following:

```bash
gh api --paginate user/starred --jq '.[].full_name' | awk '{print "https://github.com/" $1}' > starred_repos.txt
```

This is for a human-clickable format. Github uses the `user/repo` format. If you intend using the script to automatically add these favorites to the repo, use the above export format:

```bash
gh api --paginate user/starred --jq '.[].full_name' > starred_repos.txt
```

Thereafter, please run the shell script to add the list of favorites to Github account
