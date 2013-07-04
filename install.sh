DO_USER_DIR="$HOME/.do_user"

if [ -d "$DO_USER_DIR" ]; then
  echo "=> do_user is already installed in $DO_USER_DIR, trying to update"
  echo -ne "\r=> "
  cd $DO_USER_DIR && git pull
  exit
fi

# Cloning to $DO_USER_DIR
git clone https://github.com/Qard/digital_ocean_multiuser.git $DO_USER_DIR

echo

# Detect profile file, .bash_profile has precedence over .profile
if [ ! -z "$1" ]; then
  PROFILE="$1"
else
  if [ -f "$HOME/.bash_profile" ]; then
	PROFILE="$HOME/.bash_profile"
  elif [ -f "$HOME/.profile" ]; then
	PROFILE="$HOME/.profile"
  fi
fi

SOURCE_STR="[[ -s "$DO_USER_DIR/do_user.sh" ]] && . "$DO_USER_DIR/do_user.sh"  # This loads do_user"

if [ -z "$PROFILE" ] || [ ! -f "$PROFILE" ] ; then
  if [ -z $PROFILE ]; then
	echo "=> Profile not found"
  else
	echo "=> Profile $PROFILE not found"
  fi
  echo "=> Append the following line to the correct file yourself"
  echo
  echo "\t$SOURCE_STR"
  echo
  echo "=> Close and reopen your terminal to start using do_user"
  exit
fi

if ! grep -qc 'do_user.sh' $PROFILE; then
  echo "=> Appending source string to $PROFILE"
  echo "" >> "$PROFILE"
  echo $SOURCE_STR >> "$PROFILE"
else
  echo "=> Source string already in $PROFILE"
fi

echo "=> Close and reopen your terminal to start using do_user"