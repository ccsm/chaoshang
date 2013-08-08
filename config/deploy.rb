require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :domain, '103.6.86.110'
set :deploy_to, '/var/www/chaoshang'
set :repository, 'git@github.com:ccsm/chaoshang.git'
set :branch, 'master'
set :rvm_path,'/usr/local/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/mongoid.yml', 'log','public/uploads']

# Optional settings:
set :user, 'root'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
set :term_mode, nil #注意一定加这句话，否则mina setup不会工作


# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  #invoke :'rvm:use[ruby-1.9.3-p448@rails-3.2.12]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
 queue! %[yum install gcc*]
 queue! %[yum install readline-devel libffi-devel openssl-devel  autoconf  automake  libtool  bison]
 queue! %[yum install curl-devel]
 queue! %[yum install libxslt*]
 queue! %[yum install libxml2 libxml2-devel]
 queue! %[yum install git]
 queue! %[curl -O http://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-14.el6.art.noarch.rpm]
 queue! %[sudo rpm -Uvh atomic-release-1.0-14.el6.art.noarch.rpm]
 queue! %[sudo yum install libyaml-devel]
 queue! %[ yum install ImageMagick-devel]
 #安装rvm
 queue! %[ curl -L get.rvm.io | bash -s stable ]
 queue! %[ source ~/.bashrc ]
 queue! %[ source ~/.bash_profile ]

 queue! %[rvm pkg install libyaml]
 queue! %[rvm install 1.9.3 --with-libyaml-dir=/usr/local/rvm/usr]
 queue! %[rvm alias create default 1.9.3]
 queue! %[rvm gemset create rails-3.2.12]

 #安装mongodb
 queue! %[cd /usr/local/ ]
 queue! %[wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.5.tgz]
 queue! %[tar -zxvf mongodb-linux-x86_64-2.4.5.tgz]
 queue! %[mv mongodb-linux-x86_64-2.4.5 mongodb]
 queue! %[mkdir -p /data/logs]
 queue! %[mkdir /data/db]
 queue! %[cd /usr/local/mongodb/bin]
 queue! %[touch mongodb.conf]
 queue! %[echo 'dbpath = /data/db' >> mongodb.conf]
 queue! %[echo 'logpath = /data/logs/mongodb.log' >> mongodb.conf]
 queue! %[echo 'port = 27017' >> mongodb.conf] 
 queue! %[echo 'fork = true' >> mongodb.conf] 
  #安装redis
 queue! %[cd /usr/local/ ]
 queue! %[ wget http://redis.googlecode.com/files/redis-2.6.14.tar.gz ]
 queue! %[ tar xzf redis-2.6.14.tar.gz]
 queue! %[ mv redis-2.6.14 redis ]
 queue! %[ cd redis ]
 queue! %[ make ]
 # queue! %[ src/redis-server ] 
 #安装nginx
 invoke :'rvm:use[2.0.0@rails-4.0.0]'

 queue! %[gem install passenger]
 queue! %[passenger-install-nginx-module]
 #生成SSH-KEY(第一次输入直接敲回车，第二次和第三次是输入密码及确定。这样就会在~/.ssh/下有id_rsa和id_rsa.pub两个文件出现)
 queue! %[ssh-keygen -t rsa -C "admin@kai.ba"]
 
 queue! %[mkdir -p "#{deploy_to}/shared/log"]
 queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

 queue! %[mkdir -p "#{deploy_to}/shared/config"]
 queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

 queue! %[touch "#{deploy_to}/shared/config/mongoid.yml"]
 queue  %[echo "-----> Be sure to edit 'shared/config/mongoid.yml'."]
end

desc "boot database for mongo and redis"
task :bootdb do
 #启动mongo
 queue! %[cd /usr/local/mongodb/bin ]
 queue! %[./mongod -f mongodb.conf]
 #启动redis
 #queue! %[cd /usr/local/redis ]
 #queue! %[ src/redis-server ] 
 #记得关闭terminal,而不是ctrl+C
end

desc "start nginx"
task :start_nginx do
  queue! %[cd /opt/nginx/sbin ]
  queue! %[./nginx] 
end


desc "restart the server"
task :reboot do
  invoke :start_nginx
  queue! %[cd /data/db ]
  queue! %[rm mongdb.lock]
  invoke :bootdb
end


desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:assets_precompile'
    queue! "#{rake} db:mongoid:create_indexes RAILS_ENV=production"
  end
end

task :restart => :environment do
  queue """
  if [ -d #{deploy_to}/current/tmp ]
  then
    touch #{deploy_to}/current/tmp/restart.txt 
  else
    mkdir #{deploy_to}/current/tmp
    touch #{deploy_to}/current/tmp/restart.txt 
  fi
  chmod -R 777 #{deploy_to}/releases
  """
end

task :console => :environment do
  queue "cd #{deploy_to}/current && bundle exec rails c production"
end 
    
task :cat_server_log => :environment do
  queue "tail -f #{deploy_to}/current/log/staging.log"
end


