server '3.114.128.239', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/kanami.kumaki/.ssh/id_rsa'