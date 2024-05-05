return {
  "ThePrimeagen/git-worktree.nvim",
  event = "VeryLazy",
  config = function()
    require("git-worktree").setup({})
    require("telescope").load_extension("git_worktree")
    -- <Enter> - switches to that worktree
    -- <c-d> - deletes that worktree
    -- <c-f> - toggles forcing of the next deletion
  end,
}
