{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.2.0";
          sha256 = "1gfyrgn23zpwv1vj37gf28hf5z0ka0w5qm6286a7qixwv7ijnrx9";
        };
      }
    ];
    shellAliases = {
      ansi2html = "sh /etc/nixos/v2/pkgConfigs/ansi2html.sh";
      udm = "udisksctl mount -b";
      vmi = "vim";
      v = "vim";
      fix-audio = ''pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=1'';
      fix-wallpaper = ''pscircle; systemctl --user restart psc-updater'';
      toJson = ''
                  awk 'BEGIN {print "["} 
                  NR==1 { for (i=1;i<=NF;i++){ H[i]=$i} }
                  NR>1 {
                    s="";
                    st="";
                    for(j=1;j<=NF;j++){
                      st=sprintf("\"%s\": \"%s\"", H[j],$j);
                      s=j==1?st:sprintf("%s, %s", s, st)
                    }
                    printf("{ %s }\n", s)
                   }
                  END {print "]"}'
      '';
      rp = "runPackage";
      pstop = ''
          ps aux --sort -rss | 
            head | 
            sed "s#/nix/store/.*/##" | 
            awk '{ for (i=1; i<=12; i++) { if(i==12) { split($i,s,/ /); printf "%s ", s[0]; } else {printf "%8s ", $i;} } printf "\n"; }'
        '';
        calc = ":c";
    };
    
    initExtra =  ''
      cowcite(){
            args=(-b -d -g -L -n -N -p -s -t -w -y);
            animals=(bong bud-frogs bunny cower daemon default dragon dragon-and-cow default elephant default ghostbusters head-in default kiss kosh default milk moofasa moose mutilated default sheep skeleton stegosaurus default three-eyes turkey turtle tux default www);
            arg='' + "$" + ''{args[ $(( RANDOM % 13 )) ]};
            animal='' + "$" + ''{animals[ $(( RANDOM % 32 )) ]};
            curl -s http://bash.org/\?random |
                grep -E '<p class="qt">.*</p>' |
               head -n 1 |
                sed -E 's%.*<p class="qt">(.*)</p>.*%\1%' |
                sed -e 's/&amp;/&/g; s/\&lt;/</g; s/\&gt;/>/g; s/\&quot;/"/g; s/\&#39;/'"'"'/g' |
                cowsay -f "$animal" "$arg" -- ;
      }
      runPackage(){ nix-shell -p $1 --command "$1 &" }
      :q(){ exit; }
      :r(){  eval $(history | tail -n1 | awk '{ s=""; for(i=2; i<=NF; i++) s=s $i " "; printf s}') }
      :c(){ echo $(( $1 )) }
      addHeaders() { awk -v h=$1 "BEGIN {print h} 1" $2; }
      checkPdf() {nix-shell -p python python27Packages.capstone --command "python3 ~/sec_tools/pyew/pyew.py $1" }
      getVerifiedFile(){
        if (( $# != 4 )); then
          echo "Usage: getVerifiedFile url name algorithm checksum";
        fi
        curl $1 > $2;
        checksum=$(eval "$3 $2" | awk '{ print toupper ($1) }');
        sum=$(echo $4 | awk '{ print toupper ($0) }');
        if [[ "$checksum" != "$sum" ]]; then
          echo "Checksums not equal; file deleted";
          echo $checksum;
          echo $sum;
        fi
        echo "Checksum correct; file saved to $2";
      }
      dig() {
        for type in A AAAA CNAME MX NS PTR SOA SRV TXT
        do
          echo ""; echo "$type"; tdns query -t $type $1;
        done
      }
      
      enter-tu-g0() {sshfs g0:/home/ublu21/u11709041 /home/faebl/uni/tu_g0 -o reconnect}
      exit-tu-g0() {fusermount -u /home/faebl/uni/tu_g0}

      enter-tu-ffp() {sshfs ffp:/home/ffp21/ffp11709041 /home/faebl/uni/tu_ffp -o reconnect}
      exit-tu-ffp() {fusermount -u /home/faebl/uni/tu_ffp}

      enter-tu-ffp101() {sshfs ffp:/home/ffp21/ffp101 /home/faebl/uni/tu_ffp101 -o reconnect}
      exit-tu-ffp101() {fusermount -u /home/faebl/uni/tu_ffp101}

      mountRunning=false;
      mountIfNotMounted() {
        if [ "$mountRunning" != "true" ]; then
            if ! ([ -f $2/.bash_profile ] || [ -f $2/.bashrc ] || [ -f $2/GRUPPENNUMMER ]); then
                mountRunning=true;
                $1;
                echo "mounted"
                cd $2; # ~/uni/tu_g0;
                mountRunning=false;
            fi
        fi
      }
      unmountRunning=false;
      unmountIfMounted() {
        if ([ -f $2/.bash_profile ] || [ -f $2/.bashrc ]) && [ "$unmountRunning" != "true" ]; then
            unmountRunning=true;
            $1;
            echo "unmounted"
            unmountRunning=false;
        fi
      }
    
      cd () { builtin cd "$@" && chpwd; }
      pushd () { builtin pushd "$@" && chpwd; }
      popd () { builtin popd "$@" && chpwd; }
      chpwd () {
        case $PWD in
          /home/faebl/uni/tu_g0|/home/faebl/uni/tu_g0/*) 
                mountIfNotMounted enter-tu-g0 /home/faebl/uni/tu_g0;;
          /home/faebl/uni/tu_ffp|/home/faebl/uni/tu_ffp/*)
                mountIfNotMounted enter-tu-ffp /home/faebl/uni/tu_ffp;;
          /home/faebl/uni/tu_ffp101|/home/faebl/uni/tu_ffp101/*)
                mountIfNotMounted enter-tu-ffp101 /home/faebl/uni/tu_ffp101;;
          *) 
                unmountIfMounted exit-tu-g0 /home/faebl/uni/tu_g0;
                unmountIfMounted exit-tu-ffp /home/faebl/uni/tu_ffp;
                unmountIfMounted exit-tu-ffp101 /home/faebl/uni/tu_ffp101;;
        esac
      }
      '';
  };
}
