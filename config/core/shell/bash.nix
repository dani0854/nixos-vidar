{ pkgs, ... }: {

  programs.bash.completion.enable = true;

  users.users.main.shell = pkgs.bash;

  home-manager.users.main = {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      initExtra = ''
        source ${pkgs.blesh}/share/blesh/ble.sh
      '';
    };

    home.file.".blerc".text = ''
      ble-import -d integration/fzf-completion
      ble-import -d integration/fzf-key-bindings
      ble-import -d integration/fzf-git

      bleopt term_index_colors=256
      bleopt term_true_colors=semicolon

      ble-face -s region                    fg=#D8DEE9,bg=#5E81AC
      ble-face -s region_insert             fg=#81A1C1,bg=#ECEFF4
      ble-face -s region_match              fg=#D8DEE9,bg=#5E81AC
      ble-face -s region_target             fg=#3B4252,bg=#B48EAD
      ble-face -s disabled                  fg=#4C566A
      ble-face -s overwrite_mode            fg=#3B4252,bg=#5E81AC

      ble-face -s syntax_default            none
      ble-face -s syntax_command            fg=#D08770
      ble-face -s syntax_quoted             fg=#A3BE8C
      ble-face -s syntax_quotation          fg=#A3BE8C,bold
      ble-face -s syntax_escape             fg=#B48EAD
      ble-face -s syntax_expr               fg=#5E81AC
      ble-face -s syntax_error              bg=#BF616A,fg=#ECEFF4
      ble-face -s syntax_varname            fg=#BF616A
      ble-face -s syntax_delimiter          bold
      ble-face -s syntax_param_expansion    fg=#B48EAD
      ble-face -s syntax_history_expansion  bg=#81A1C1,fg=#ECEFF4
      ble-face -s syntax_function_name      fg=#A3BE8C,bold
      ble-face -s syntax_comment            fg=#4C566A
      ble-face -s syntax_glob               fg=#BF616A,bold
      ble-face -s syntax_brace              fg=#E5E9F0,bold
      ble-face -s syntax_tilde              fg=#5E81AC,bold
      ble-face -s syntax_document           fg=#81A1C1
      ble-face -s syntax_document_begin     fg=#81A1C1,bold
      ble-face -s command_builtin_dot       fg=#BF616A,bold
      ble-face -s command_builtin           fg=#BF616A
      ble-face -s command_alias             fg=#8FBCBB
      ble-face -s command_function          fg=#A3BE8C # fg=purple
      ble-face -s command_file              fg=#A3BE8C
      ble-face -s command_keyword           fg=#81A1C1
      ble-face -s command_jobs              fg=#BF616A,bold
      ble-face -s command_directory         fg=#5E81AC,underline
      ble-face -s argument_option           fg=#8FBCBB
      ble-face -s argument_option           fg=#3B4252,bg=#EBCB8B
      ble-face -s filename_directory        underline,fg=#88C0D0
      ble-face -s filename_directory_sticky underline,fg=#D8DEE9,bg=#88C0D0
      ble-face -s filename_link             underline,fg=#8FBCBB
      ble-face -s filename_orphan           underline,fg=#8FBCBB,bg=#EBCB8B
      ble-face -s filename_setuid           underline,fg=#3B4252,bg=#EBCB8B
      ble-face -s filename_setgid           underline,fg=#3B4252,bg=#A3BE8C
      ble-face -s filename_executable       underline,fg=#A3BE8C
      ble-face -s filename_other            underline
      ble-face -s filename_socket           underline,fg=#8FBCBB,bg=#2E3440
      ble-face -s filename_pipe             underline,fg=#A3BE8C,bg=#2E3440
      ble-face -s filename_character        underline,fg=#D8DEE9,bg=#2E3440
      ble-face -s filename_block            underline,fg=#EBCB8B,bg=#2E3440
      ble-face -s filename_warning          underline,fg=#BF616A
      ble-face -s filename_url              underline,fg=#81A1C1
      ble-face -s filename_ls_colors        underline
      ble-face -s varname_array             fg=#D08770,bold
      ble-face -s varname_empty             fg=#4C566A
      ble-face -s varname_export            fg=#BF616A,bold
      ble-face -s varname_expr              fg=#A3BE8C,bold
      ble-face -s varname_hash              fg=#5E81AC,bold
      ble-face -s varname_number            fg=#88C0D0
      ble-face -s varname_readonly          fg=#BF616A
      ble-face -s varname_transform         fg=#434C5E,bold
      ble-face -s varname_unset             fg=#BF616A

      ble-face -s cmdinfo_cd_cdpath         fg=#88C0D0,bg=#B48EAD
    '';
  };
}
