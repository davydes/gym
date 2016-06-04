set :rails_env, 'staging'
set :rake_env,  'staging'
set :user, 'deploy'
ask :server, 'dev.logym.ru'

server fetch(:server),
       user: "#{fetch(:user)}",
       roles: %w{app db web}