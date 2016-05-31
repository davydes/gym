lock '3.5.0'

set :application, 'gym'
set :repo_url, 'git@github.com:davydes/gym.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, "/var/www/apps/#{fetch :application}"
set :scm, :git
set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :pty, true
set :keep_releases, 3
set :linked_files, fetch(:linked_files, []).push('config/puma.rb', 'config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/sockets')
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# RVM
################################################################################

set :rvm_type, :user
set :rvm_ruby_version, '2.1.10'
set :rvm_custom_path, '~/.rvm'

################################################################################

namespace :deploy do
  task :setup do
    on roles(:all) do
      execute "mkdir -p #{shared_path}/config"
      execute "mkdir -p #{shared_path}/tmp/pids"
      execute "mkdir -p #{shared_path}/tmp/sockets"
      upload! "shared/application.yml", "#{shared_path}/config/application.yml"
      upload! "shared/puma.rb", "#{shared_path}/config/puma.rb"
      upload! "shared/nginx.conf", "#{shared_path}/#{fetch :application}_#{fetch :stage}"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
