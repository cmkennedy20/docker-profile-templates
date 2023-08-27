*Setup for Windows*
* Run the following command `notepad.exe $PROFILE`
* Paste the content from profile-scripts.ps1 in the $PROFILE file
* Run `. $PROFILE` to reload the terminal session
*Setup for Linux*
* Run the following command `cat ~/.bashrc | grep .bash_aliases`
* Observe the results, if the file exists copy the file into the path the alias is defined in
* If the file doesn't exist copy the .bash_aliases file into the ~ directory
* If it doesn't exist, add the following command to the end your ~/.bashrc file `. ~/.bashrc`
* Run `~/.bashrc` to reload the terminal session 