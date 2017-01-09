# Divided ssh config

```
$ alias ssh-config='find ~/.ssh/conf.d/ -type f -exec cat {} \;'
$ ssh-config > ~/.ssh/config
```
