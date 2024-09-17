{ config, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      nors = "doas nixos-rebuild switch";
      norb = "doas nixos-rebuild boot";

      txn = "tmux new";
      txl = "tmux list-sessions";
      txa = "tmux attach -t";

      ls = "eza";
      la = "eza -a";
      tree = "eza -T";
      cat = "bat";

      vim = "nvim";
      vi = "nvim";
      v = "nvim .";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      theme = "intheloop";
      plugins = [ "git" "rust" "direnv" ];
    };
    syntaxHighlighting.enable = true;
    initExtra = ''
      bindkey '^b' history-incremental-pattern-search-backward

      eval "$(direnv hook zsh)"
    '';
  };
}
