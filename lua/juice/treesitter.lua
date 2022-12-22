local function setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {"bash", "c", "help", "lua", "markdown", "vim"},
    highlight = {
      enable = true,
    }
  })

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.scala = {
    install_info = {
      url = "https://github.com/eed3si9n/tree-sitter-scala.git",
      branch = "fork-integration",
      files = {"src/parser.c", "src/scanner.c"},
      requires_generate_from_grammar = false,
    }
  }
end

return {
  setup = setup
}
