{ ... }: {

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        proxyCommand = "nc -X 5 -x 127.0.0.1:1080 %h %p";
        port = 443;
        identityFile = "~/.ssh/github_rsa";
      };

      "kube-worker1.home" = {
        hostname = "zapan.club";
        port = 22223;
        User = "zapan";
        forwardAgent = true;
        identityFile = "~/.ssh/general";
      };

      "kube-master.home" = {
        hostname = "10.0.2.1";
        user = "zapan";
        identityFile = "~/.ssh/general";
        proxyJump = "kube-worker1.home";
      };

      "kube-root-ceph.home" = {
        hostname = "10.0.2.3";
        user = "zapan";
        identityFile = "~/.ssh/general";
        proxyJump = "kube-worker1.home";
      };

      "kube-root-ceph2.home" = {
        hostname = "10.0.2.7";
        user = "zapan";
        identityFile = "~/.ssh/general";
        proxyJump = "kube-worker1.home";
      };

      "git.zapan.club" = {
        hostname = "10.109.55.111";
        identityFile = "~/.ssh/home_git";
        proxyJump = "kube-worker1.home";
      };

      # Bandwagon vps 2 MegaBox pro
      "bwg2.zapan.club" = {
        hostname = "104.224.154.100";
        user = "zapan";
        identityFile = "~/.ssh/bandwagon";
      };

      "cloudcone.zapan.club" = {
        hostname = "142.171.146.89";
        port = 22222;
        user = "root";
        identityFile = "~/.ssh/general";
      };
    };

  };
}
