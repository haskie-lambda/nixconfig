# { pkgs, ... }:
# let
#   cv = [
#     "v-f-tailed"
#     "v-i-italic"
#     "v-l-italic"
#     "v-k-curly"
#     "v-w-curly"
#     "v-x-curly"
#     "v-y-straight"
#     "v-turn-v-curly"
#     "v-capital-g-toothless"
#     "v-capital-r-curly"
#     "v-capital-y-curly"
#     "v-nine-turned-six"
#     "v-lambda-curly"
#     "v-lig-ltgteq-slanted"
#   ];
# 
# in {
#   fontconfig.defaultFonts = {
#     monospace = [ "Iosevka" ];
#     sansSerif = [ "Iosevka Sparkle" ];
#     serif = [ "Iosevka Etoile" ];
#     emoji = [ "Material Design Icons" ];
#   };
# 
#   fonts = with pkgs; [
#     (iosevka.override {
#       set = "custom";
#       #family = "Iosevka";
#       privateBuildPlan = {
#       design = [
#         "common styles"
#         "sans"
#         "ligset-haskell"
#       ] ++ cv;
#       };
#     })
# 
#     (iosevka.override {
#       set = "term";
#       #family = "Iosevka Term";
#       privateBuildPlan = {
#       design = [
#         "common styles"
#         "sans"
#         "sp-term"
#         "ligset-haskell"
#       ] ++ cv;
#       };
#     })
# 
#     (iosevka.override {
#       set = "fixed";
#       #family = "Iosevka Fixed";
#       privateBuildPlan = {
#       design = [
#         "common styles"
#         "sans"
#         "sp-fixed"
#       ] ++ cv;
#       };
#     })
#     
#     (iosevka.override {
#       set = "etoile";
#       #family = "Iosevka Etoile";
#       privateBuildPlan = {
#       design = [
#         "type"
#         "slab"
#         "v-at-fourfold"
#         "v-j-serifed"
#         "no-cv-ss"
#         "no-ligation"
#       ];
#       upright = [ "v-i-serifed" "v-l-serifed" ];
#       italic = [ "v-i-italic" "v-l-italic" ];
#       oblique = [ "v-i-serifed" "v-l-serifed" ];
#       # post.design = [ "diversity-1" ];
#       # widths.normal = {
#       #   shape = 7;
#       #   menu = 5;
#       #   css = "normal";
#       # };
#       };
#     })
# 
#     (iosevka.override {
#       set = "sparkle";
#       #family = "Iosevka Sparkle";
#       privateBuildPlan = {
#       design = [
#         "type"
#         "v-at-fourfold"
#         "v-j-narrow-serifed"
#         "no-cv-ss"
#         "no-ligation"
#       ];
#       upright = [ "v-i-serifed" "v-l-serifed" "v-f-serifed" "v-r-serifed" ];
#       italic = [ "v-i-italic" "v-l-italic" "v-f-tailed" "v-r-top-serifed" ];
#       oblique = [ "v-i-serifed" "v-l-serifed" "v-f-serifed" "v-r-serifed" ];
#       #post.design = [ "diversity-1" ];
#       # widths.normal = { #weights
#       #   shape = 7;
#       #   menu = 5;
#       #   css = "normal";
#       # };
#       };
#     })
# 
#     material-design-icons
# 
#     #(nerdfonts.override{
#     #  fonts = [
#     #    "Inconsolata"
#     #    "Iosevka"
#     #  ];
#     #})
#   ];
# }
# 