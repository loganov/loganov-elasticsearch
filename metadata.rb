name             'loganov-elasticsearch'
maintainer       'Loganov Industries, LLC'
maintainer_email 'devops@loganov.com'
license          'All rights reserved'
description      'Installs/Configures ElasticSearch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

recipe           'loganov-elastisearch::default', 'Install ES'
recipe           'loganov-elasticsearch::kibana', 'Install Kibana frontend'

depends          'loganov-nginx'
depends          'yum'