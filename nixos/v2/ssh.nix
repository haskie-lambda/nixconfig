{
    programs.ssh.extraConfig = ''
        Host g0
          Hostname g0.complang.tuwien.ac.at
          User u11709041
          IdentityFile ~/.ssh/id_rsa
            ControlMaster auto
            ControlPath ~/.ssh/%C
            # ControlPath ~/.ssh/cm_socket/%r@%h:%p
            ControlPersist yes
        ForwardX11Trusted yes
        Compression yes

        Host ffp
          Hostname g0.complang.tuwien.ac.at
          User ffp11709041
          IdentityFile ~/.ssh/id_rsa
            ControlMaster auto
            ControlPath ~/.ssh/%C
            # ControlPath ~/.ssh/cm_socket/%r@%h:%p
            ControlPersist yes
    '';

    #fileSystems."/home/faebl/uni/tu_g0" = {
    #    device = "g0:/home/ublu21/u11709041";
    #    fsType = "sshfs";
        # lazy mounting and auto disconnect after 30 mins of inactivity
        #options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=2400" ]; 
    #};
}
