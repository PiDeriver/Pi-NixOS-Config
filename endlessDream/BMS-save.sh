cd $HOME/.local/share/lr2oraja-endlessdream

saveAll(){
  echo "Save All"
  cp -r favorite $HOME/.dotfiles/endlessDream
  cp -r player $HOME/.dotfiles/endlessDream
  cp -r skin $HOME/.dotfiles/endlessDream
  cp config_sys.json $HOME/.dotfiles/endlessDream 
}

saveConfig(){
  echo "Save config_sys.json"
  cp config_sys.json $HOME/.dotfiles/endlessDream
}

savePlayer(){
  echo "Save player folder"
  cp -r player $HOME/.dotfiles/endlessDream
}

saveFavorite(){
  echo "Save favorite folder"
  cp -r favorite $HOME/.dotfiles/endlessDream
}

saveSkin(){
  echo "Save Skin"
  cp -r skin $HOME/.dotfiles/endlessDream
}

while getopts 'acpfs' OPTION; do
  case "$OPTION" in
    a)
      saveAll
      exit 1
      ;;
    c)
      saveConfig
      ;;
    p)
      savePlayer
      ;;
    f)
      saveFavorite
      ;;
    s)
      saveSkin
      ;;
    \?)
      echo "Script requires an argument: [-a] [-c] [-p] [-f] [-s]"
      echo "-a:  Save all (config_sys.json, player, favorite, and skin)"
      echo "-c:  Save config_sys.json"
      echo "-f:  Save favorite folder"
      echo "-p:  Save player folder"
      echo "-s:  Save skin folder"
      exit 1
      ;;
  esac
done
