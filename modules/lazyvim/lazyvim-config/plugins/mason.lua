return {
    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                -- TODO 如果这样配置会报错: GitHubRegistrySource(repo=g0ne150/mason-registry) failed to install: Failed to fetch latest registry version from GitHub API.
            },
        },
    },
}
