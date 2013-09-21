source 'http://ruby.taobao.org'

gem 'rails', '4.0.0'
# Mongoid 辅助插件
#gem 'mongo'
gem "mongoid", github: 'mongoid/mongoid', ref: '11e45e5a30a45458b83db99ab6c9d9ccc337e66f'
gem 'mongoid_auto_increment_id', "0.6.1"


gem 'execjs'
gem 'therubyracer', :platforms => :ruby

gem "bson_ext","1.8.0"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'compass-rails',github: 'milgner/compass-rails', branch: 'rails4'


gem 'rails_kindeditor','~> 0.4.0'#, :path => "vendor/gems/rails_kindeditor"

gem 'active_hash' # 用于保存配置型(枚举)记录
gem 'haml-rails'
gem 'simple_form',"3.0.0.rc"

gem 'devise' # For authentication
gem 'rails-i18n' # For some out-of-the-box default locales

gem 'gon'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'mongoid-tree', :require => 'mongoid/tree'
gem 'mongoid-list'


gem 'stringex', "~> 2.0.8"

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem "carrierwave"   
gem "carrierwave-mongoid", git: "git://github.com/jnicklas/carrierwave-mongoid.git"
gem 'mongoid-grid_fs', github: 'ahoward/mongoid-grid_fs'


#paging
gem 'kaminari'                 
gem 'bootstrap-kaminari-views' 

gem "mini_magick"

gem 'active_hash'# 用于保存配置型(枚举)记录

gem 'inherited_resources' # For refactoring of controllers

gem 'anjlab-bootstrap-rails', '>= 2.3', :require => 'bootstrap-rails'


gem 'mongoid_taggable'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Set up testing environment
group :test, :development do
  gem 'fabrication'
  gem "rspec-rails" # Testing framework
  gem 'rb-inotify', :require => false # For guard automated tests
  gem 'rb-fsevent', :require => false # For guard automated tests
  gem 'rb-fchange', :require => false # For guard automated tests
  gem 'rack-mini-profiler'
  gem 'mina'
end

group :test do
  gem 'simplecov', '>=0.3.8', :require => false # Detecting code smells
  gem 'database_cleaner'
  gem 'launchy'
  #gem "factory_girl_rails" # Fixture replacement
  gem "capybara" # Better integration testing
  gem "guard-rspec" # For automated tests
  gem 'mongoid-rspec' # Rspec matchers for mongoid
end





# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
