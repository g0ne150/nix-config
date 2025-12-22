# To list all .desktop-files, run
#
# for global packages
# `ls /run/current-system/sw/share/applications`
# for user packages
# `ls /etc/profiles/per-user/$(id -n -u)/share/applications`
# for home-manager packages
# `ls ~/.nix-profile/share/applications`

{ pkgs, ... }: {
  home.packages = with pkgs; [
    dialect # Translate between languages
    baobab # Disk Usage Analyzer
    gnome-calculator # Calculator
    gnome-connections # RDP client
    gnome-system-monitor

    qutebrowser
    nautilus
    evolution
    papers
    loupe # Image viewer
    gnome-text-editor
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "text/xml" = "org.qutebrowser.qutebrowser.desktop;";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";

      "inode/directory" = "org.gnome.Nautilus.desktop;";

      "x-scheme-handler/mailto" = "org.gnome.Evolution.desktop";

      "application/pdf" = "org.gnome.Papers.desktop";

      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";

      "text/plain" = "org.gnome.TextEditor.desktop";
    };
  };

}
