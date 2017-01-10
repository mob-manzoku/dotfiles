# Divided ssh config

```
$ alias ssh-config='find ~/.ssh/conf.d/ -name "*.conf" | sort | xargs cat'
$ ssh-config > ~/.ssh/config
```
