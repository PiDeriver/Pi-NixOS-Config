cd $HOME/.local/share/beatoraja

saveAll(){
  echo "Save All"
  cp -r favorite $HOME/.dotfiles/beatorajaInitialSetup
  cp -r player $HOME/.dotfiles/beatorajaInitialSetup
  cp -r skin $HOME/.dotfiles/beatorajaInitialSetup
  cp config_sys.json $HOME/.dotfiles/beatorajaInitialSetup 
}

saveConfig(){
  echo "Save config_sys.json"
  cp config_sys.json $HOME/.dotfiles/beatorajaInitialSetup
}

savePlayer(){
  echo "Save player folder"
  cp -r player $HOME/.dotfiles/beatorajaInitialSetup
}

saveFavorite(){
  echo "Save favorite folder"
  cp -r favorite $HOME/.dotfiles/beatorajaInitialSetup
}

saveSkin(){
  echo "Save Skin"
  cp -r skin $HOME/.dotfiles/beatorajaInitialSetup
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
