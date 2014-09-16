default['elasticsearch']['version'] = '1.1.1-1'

default['elasticsearch']['config']['network']['host'] =  'localhost'
default['elasticsearch']['config']['script']['disable_dynamic'] =  true
default['elasticsearch']['config']['discovery']['multicast'] = false

default['elasticsearch']['kibana']['enabled'] = true
default['elasticsearch']['kibana']['url'] = 'https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz'
default['elasticsearch']['kibana']['checksum'] = '88d3438a907992229111b7a7961c148bb78f9b13a927a73266c69aff8a4f5274'
default['elasticsearch']['kibana']['port'] = '80'
default['elasticsearch']['kibana']['root_dir'] = '/usr/share/nginx/kibana3'