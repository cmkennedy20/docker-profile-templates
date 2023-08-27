# Setup for Windows
1. Run the following command `notepad.exe $PROFILE`
2. Paste the content from profile-scripts.ps1 in the $PROFILE file
3. Run `. $PROFILE` to reload the terminal session
# Setup for Linux
1. Run the following command `cat ~/.bashrc | grep .bash_aliases`
2. Observe the results, if the file exists copy the file into the path the alias is defined in
3. If the file doesn't exist copy the .bash_aliases file into the ~ directory
4. If it doesn't exist, add the following command to the end your ~/.bashrc file `. ~/.bashrc`
5. Run `~/.bashrc` to reload the terminal session 