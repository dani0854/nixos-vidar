{ lib, pkgs, ... }:
let
  lsp-ai-wrapper = pkgs.writeScriptBin "lsp-ai" ''
    #!/usr/bin/env bash

    export DEEPSEEK_API_KEY=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' $XDG_CONFIG_HOME/helix/deepseek_api_key 2>/dev/null)

    set -e

    ${lib.getExe' pkgs.lsp-ai "lsp-ai"} $@
  '';
in
{
  environment.systemPackages = [
    lsp-ai-wrapper
  ];

  home-manager.users.main.programs.helix.languages.language-server.lsp-ai = {
    command = "lsp-ai";
    config = {
      memory.file_store = { };
      models.deepseek-chat = {
        type = "open_ai";
        chat_endpoint = "https://api.deepseek.com/chat/completions";
        model = "deepseek-chat";
        auth_token_env_var_name = "DEEPSEEK_API_KEY";
      };
      actions = [
        {
          action_display_name = "AI Replace";
          model = "deepseek-chat";
          post_process.extractor = ''(?s)```\w*?\n(.*?)```'';
          parameters = {
            max_context = 4096;
            max_tokens = 2048;
            temperature = 0;
            messages = [
              {
                role = "system";
                content = ''
                  You are an AI coding assistant. Your task is to replace code snippets. Follow these steps:

                  1. Analyze the code context.
                  2. Analyze user input code snippet and the user cursor position marked by "<CURSOR>".
                  3. Determine the output code snippet with which the user input code snippet should be replaced, adding any necessary explanation inside that code snippet as code comments.
                  4. Produce output that ONLY contains the output code snippet, and no other text or explanations.

                  EXAMPLE INPUT:
                  ```
                  # A function that reads in user input<CURSOR>
                  ```

                  EXAMPLE OUTPUT:
                  ```
                  # Function that reads user input
                  def read_user_input():
                      user_input = input("Enter your input: ")
                      return user_input
                  ```
                '';
              }
              {
                role = "user";
                content = ''
                  Code context:
                  ```
                  {CODE}
                  ```
                '';
              }
              {
                role = "user";
                content = ''
                  ```
                  {SELECTED_TEXT}
                  ```
                '';
              }
            ];
          };
        }
      ];
    };
  };
}
