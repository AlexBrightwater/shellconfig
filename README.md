# shellconfig
Just my files used on all my systems.  

If you encounter problems with your ssh agent, add: 

```bash
#!/bin/bash  
eval `ssh-agent -s` > /dev/null
```

to your home folder as start_ssl  
