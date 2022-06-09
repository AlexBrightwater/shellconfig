# shellconfig
The files found here are just my dotfiles I juse to configure my shell. ALso, a script is included with automatically gets p10k and adds all my custom configurations.  
## Usage  
### Prerequisites
- Have ZSH installed (best unconfigured)
- Have dir ~/repos
### Usage
Get the .shellconfig.sh and throw it into your ~.
Then, execute it

## SSH
If you encounter problems with your ssh agent, remove: 

```bash
#!/bin/bash  
eval `ssh-agent -s` > /dev/null
```

to your home folder as start_ssl  
