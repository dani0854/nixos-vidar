{ ... }:
{
  home-manager.users.main.programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "nord";
      editor = {
        bufferline = "multiple";
        color-modes = true;
        true-color = true;
      };
      keys.insert = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
        pageup = "no_op";
        pagedown = "no_op";
        home = "no_op";
        end = "no_op";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter.command = "nixfmt";
          language-servers = [
            "nixd"
            "lsp-ai"
          ];
        }
        {
          name = "go";
          language-servers = [
            "gopls"
            "golangci-lint-lsp"
            "ltex-ls"
            "lsp-ai"
          ];
        }
        {
          name = "python";
          formatter = {
            command = "ruff";
            args = [
              "format"
              "--line-length"
              "88"
              "-"
            ];
          };
          auto-format = true;
          language-servers = [
            "ruff"
            "pyright"
            "ltex-ls"
            "lsp-ai"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "ltex-ls"
          ];
        }
        {
          name = "git-commit";
          language-servers = [
            "marksman"
            "ltex-ls"
          ];
        }
      ];
    };
  };
}
