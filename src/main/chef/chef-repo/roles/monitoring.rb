name 'monitoring'
description 'Monitoring server'

run_list(
  "recipe[gsa_ads::nagios_server]"
)

default_attributes(
  :nagios => {
    :server => {
      :vname => "nagios"
    },
    :server_auth_method => "htauth",
    :url => "192.168.0.103"
  }
)
