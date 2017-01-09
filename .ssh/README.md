# Divided ssh config

```
$ alias ssh-config='find ~/.ssh/conf.d/ -name "*.conf" -exec cat {} \;'
$ ssh-config > ~/.ssh/config
```
