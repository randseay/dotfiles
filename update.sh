while true; do
    echo "The default git user is Rand Seay..."
    read -p "Do you wish specify the git user? [y/n] " yn
    case $yn in
        [Yy]* ) read -p "What is the git user name? " name
                git config --global user.name "$name"
                read -p "What is the git user email? " email
                git config --global user.email "$email"
                break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done