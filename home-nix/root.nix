# ============================================================
# Home Manager Configuration — root
# ============================================================
# Отдельный, намеренно минимальный профиль для root.
# Единственная задача — подключить тот же модуль Neovim
# (./modules/neovim.nix), что и у reladronekinse, чтобы конфиг
# редактора был одинаковым и под обычным пользователем, и под root
# (doas -u root nvim, su -, логин прямо под root и т.д.).
#
# Весь "рабочий стол" (wezterm, fish, niri, ironbar, wofi, курсоры)
# сюда намеренно не тянется — root он не нужен.
{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/neovim.nix
  ];

  home = {
    username      = "root";
    homeDirectory = "/root";
    stateVersion  = "26.05";
  };
}
