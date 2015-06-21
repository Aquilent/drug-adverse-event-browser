
default['gsa_ads']['aws_codedeploy']['installer']['url'] = 
    "https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent.noarch.rpm"

if ! node['gsa_ads']['aws_logwatch'].nil? then
    default['gsa_ads']['aws_logwatch']['default_files']["aws_codedeploy"]['path'] = 
        "/var/log/aws/codedeploy-agent" 
end