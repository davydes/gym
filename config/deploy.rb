lock '3.5.0'

set :application, 'gym'
set :repo_url, 'git@github.com:davydes/gym.git'
set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, "/var/www/apps/#{fetch :application}/#{fetch :stage}"
set :scm, :git
set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :pty, true
set :keep_releases, 3
set :linked_files, fetch(:linked_files, []).push('config/application.yml', 'config/unicorn.rb', 'config/sidekiq.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'tmp/cache', 'vendor/bundle', 'public/system', 'public/uploads')
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# RVM
################################################################################

set :rvm_type, :user
set :rvm_ruby_version, '2.1.10'
set :rvm_custom_path, '~/.rvm'

################################################################################

namespace :app do
  desc 'Stop Application'
  task :stop do
    on roles(:web) do
      # Do stop
      sudo "systemctl stop #{fetch :application}-web@#{fetch :stage}"
      sudo "systemctl stop #{fetch :application}-worker@#{fetch :stage}"
    end
  end

  desc 'Start Application'
  task :start do
    on roles(:web) do
      sudo "systemctl start #{fetch :application}-web@#{fetch :stage}"
      sudo "systemctl start #{fetch :application}-worker@#{fetch :stage}"
    end
  end

  desc 'Restart Application'
  task :restart
  before :restart, :stop
  before :restart, :start
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch :branch}`
        puts "WARNING: HEAD is not the same as origin/#{fetch :branch}"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  before "deploy", "deploy:check_revision"

  desc "Upload shared configs"
  task :upload do
    on roles(:web) do
      execute "mkdir -p #{shared_path}/config"
      upload! "shared/application.#{fetch :stage}.yml", "#{shared_path}/config/application.yml"
      #upload! "shared/puma.#{fetch :stage}.rb", "#{shared_path}/config/puma.rb"
      upload! "shared/unicorn.#{fetch :stage}.rb", "#{shared_path}/config/unicorn.rb"
      upload! "shared/sidekiq.yml", "#{shared_path}/config/sidekiq.yml"
    end
  end

  after :publishing, 'app:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
