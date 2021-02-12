{ ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    shellAliases = {
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
    };
    
    initExtra =  ''
      runPackage(){ nix-shell -p $1 --command "$1 &" }
      :q(){ exit; }
      :r(){  eval $(history | tail -n1 | awk '{ s=""; for(i=2; i<=NF; i++) s=s $i " "; printf s}') }
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
          exit 1;
        fi
        echo "Checksum correct; file saved to $2";
      }
      dig() {
        for type in A AAAA CNAME MX NS PTR SOA SRV TXT
        do
          echo ""; echo "$type"; tdns query -t $type $1;
        done
      }
      '';
  };
}
