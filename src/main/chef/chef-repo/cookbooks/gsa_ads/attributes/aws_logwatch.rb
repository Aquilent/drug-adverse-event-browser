
default['gsa_ads']['aws_logwatch']['agent_setup_py'] = 
    "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py"

default['gsa_ads']['aws_logwatch']['default_files']["messages"]['path'] = "/var/log/messages" 
default['gsa_ads']['aws_logwatch']['default_files']["secure"]['path'] = "/var/log/secure" 
default['gsa_ads']['aws_logwatch']['default_files']["boot"]['path'] = "/var/log/boot.log" 
default['gsa_ads']['aws_logwatch']['default_files']["audit"]['path'] = "/var/log/audit/audit.log" 
default['gsa_ads']['aws_logwatch']['default_files']["cfn-init"]['path'] = "/var/log/cfn-init.log" 
default['gsa_ads']['aws_logwatch']['default_files']["cfn-init-cmd"]['path'] = "/var/log/cfn-init-cmd.log" 
default['gsa_ads']['aws_logwatch']['default_files']["gsa-ads/bootstrap"]['path'] = "/var/log/gsa-ads/bootstrap.log" 
default['gsa_ads']['aws_logwatch']['default_files']["gsa-ads/launch"]['path'] = "/var/log/gsa-ads/launch.log" 
# default['gsa_ads']['aws_logwatch']['default_files']["gsa-ads/baseline"]['path'] = "/var/log/gsa-ads/baseline.log"
