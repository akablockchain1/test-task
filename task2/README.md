# Nginx and Fluentd Setup with Log Rotation

This Ansible playbook sets up Nginx and Fluentd on your server, configures log collection and filtering, and manages log rotation to ensure only 5 days' worth of logs are kept.

## Prerequisites

- Ansible installed on your local machine
- SSH access to your target servers
- Nginx and Fluentd should be installed and running on the target servers

## Playbook Tasks

The playbook performs the following tasks:
1. Updates the apt repository cache and upgrades packages.
2. Installs and configures Nginx to serve a simple "Hello, World!" HTML page.
3. Installs and configures Fluentd to collect and filter Nginx logs.
4. Sets up log rotation using logrotate to manage log size and keep only 5 days' worth of logs.

## Instructions

1. **Clone the Repository**

```sh
git clone https://github.com/akablockchain1/test-task.git
cd nginx-fluentd-logrotate
```

2. **Configure the Inventory**
Edit the hosts file to include the target servers where Nginx and Fluentd will be set up.
```sh
[webservers]
server1 ansible_host=your_server_ip ansible_user=your_username ansible_ssh_private_key_file=path_to_your_ssh_key
```

3**Run the Ansible Playbook**
Execute the playbook to set up Nginx, Fluentd, and log rotation.
```sh
ansible-playbook -i hosts.ini nginx_fluentd_logrotate.yml
```

## Verifying the Setup

1. **Check Nginx**
Verify that Nginx is serving the "Hello, World!" page.
```sh
curl http://your_server_ip/
```

2. **Check Fluentd Logs**
Ensure that Fluentd is collecting and filtering logs correctly.
```sh
sudo tail -f /var/log/td-agent/nginx-access.log
sudo tail -f /var/log/td-agent/denylist_audit.log
```

3. **Check Log Rotation**
Verify that logrotate is configured correctly and is managing the log files.
```sh
ls -lh /var/log/td-agent/
```


## Files

1. **Clone the Repository**

- **nginx_fluentd_logrotate.yml**: The main Ansible playbook that sets up Nginx, Fluentd, and log rotation.
- **hosts**: The inventory file containing the target servers.
