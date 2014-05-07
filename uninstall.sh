echo "Uninstalling fonts"
rm -rf $HOME/.fonts/SourceCodePro $HOME/.fonts/powerline-fonts
echo "Restoring original .zshrc file"
rm $HOME/.zshrc
cp $HOME/dotfiles/.dotfile_backups/original/.zshrc.backup $HOME/.zshrc
echo "Restoring original .vimrc file"
rm $HOME/.vimrc
cp $HOME/dotfiles/.dotfile_backups/original/.vimrc.backup $HOME/.vimrc
echo "Removing .global_gitignore file"
rm $HOME/.global_gitignore
if 
git config --global core.excludesfile ""
