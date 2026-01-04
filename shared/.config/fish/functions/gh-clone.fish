# Clone git repo into ~/Development/$org/$repo
function gh-clone
    if test (count $argv) -eq 0
        echo "Usage: gh-clone <git-repo-url>"
        echo "Examples:"
        echo "  gh-clone git@github.com:user/repo.git"
        echo "  gh-clone https://github.com/user/repo.git"
        return 1
    end

    set -l repo_url $argv[1]
    set -l org
    set -l repo_name

    # Extract org/repo from SSH format: git@github.com:org/repo.git
    if string match -rq '^git@[^:]+:([^/]+)/([^/]+)(\.git)?$' $repo_url
        set org (string match -r '^git@[^:]+:([^/]+)/([^/]+)(\.git)?$' $repo_url)[2]
        set repo_name (string match -r '^git@[^:]+:([^/]+)/([^/]+)(\.git)?$' $repo_url)[3]
        # Remove .git suffix if present
        set repo_name (string replace -r '\.git$' '' $repo_name)
    # Extract org/repo from HTTPS format: https://github.com/org/repo.git
    else if string match -rq '^https://[^/]+/([^/]+)/([^/]+)(\.git)?$' $repo_url
        set org (string match -r '^https://[^/]+/([^/]+)/([^/]+)(\.git)?$' $repo_url)[2]
        set repo_name (string match -r '^https://[^/]+/([^/]+)/([^/]+)(\.git)?$' $repo_url)[3]
        # Remove .git suffix if present
        set repo_name (string replace -r '\.git$' '' $repo_name)
    else
        echo "Error: Unable to parse repository URL format"
        echo "Supported formats:"
        echo "  SSH: git@github.com:org/repo.git"
        echo "  HTTPS: https://github.com/org/repo.git"
        return 1
    end

    set -l repo_path "$HOME/Development/$org/$repo_name"

    # Create directory if it doesn't exist
    mkdir -p (dirname $repo_path)

    # Clone the repository
    echo "Cloning $repo_url into $repo_path"
    if git clone $repo_url $repo_path
        echo "Successfully cloned to $repo_path"
        cd $repo_path
    else
        echo "Failed to clone repository"
        return 1
    end
end
