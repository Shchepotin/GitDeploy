# GitDeploy

Auto git pull for your projects.

## Install
```bash
cd ~
```
    
Clone GitDeploy:

```bash
git clone https://github.com/Schepotin/GitDeploy.git mygitdeploy
```
    
```bash
cd mygitdeploy
```

Copy and rename config file:

```bash
cp config.conf.sample config.conf
```
    
Edit:
    
```bash
nano config.conf
```

## Run

Create `webhook.php` in your project:

```bash
nano webhook.php
```
    
```php
<?php
putenv("HOME=/home/YOUR_USER_NAME"); // Required

exec("nohup sh /path/to/gitdeploy/webhook.sh >> /path/to/gitdeploy/webhook.log 2>&1 &");
```

#### Github

In your repository go to `Settings > Webhooks > Add webhook` and set `Payload URL`:

```bash
http://yoursite.com/webhook.php
```
    
And press button `Add webhook`

#### Bitbucket

In your repository go to `Settings > Webhooks > Add webhook` and set `URL`:

```bash
http://yoursite.com/webhook.php
```
    
And press button `Save`