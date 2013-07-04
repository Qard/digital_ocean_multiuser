#!/bin/sh

# Auto detect the DO_USER_DIR
if [ ! -d "$DO_USER_DIR" ]; then
  export DO_USER_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-$0}) > /dev/null && pwd)
fi

# Ensure existence of accounts folder
[ -d ./accounts ] || mkdir ./accounts

do_user() {
  # If there is no action, show help text
  if [ $# -lt 1 ]; then
    do_user help
    return
  fi

  # Handle different actions
  case $1 in
    "help" )
      echo
      echo "Digital Ocean Account Manager"
      echo
      echo "Usage:"
      echo "    do_user login       Login user, if not logged in already"
      echo "    do_user change      Change to a logged in user by name"
      echo
    ;;
    "login" )
      # Ask for account information
      read -p "Account name: " name
      read -p "Client ID: " id
      read -p "API Key: " key

      # Generate account file
      rm ./accounts/$name
      echo "export DIGITAL_OCEAN_CLIENT_ID=$id" >> ./accounts/$name
      echo "export DIGITAL_OCEAN_API_KEY=$key" >> ./accounts/$name
      
      # Change to user
      echo
      do_user change $name
    ;;
    "change" )
      # Warn if user doesn't exist
			if [ ! -f ./accounts/$2 ]; then
				echo "Error: User not found"
        return
			fi

      # Change current user and source
      cp ./accounts/$2 ./current
      source ./current
      echo "Logged in as $2"
		;;
    * )
      do_user help
    ;;
  esac
}

# Source keys for current user
[ -f ./current ] && source ./current