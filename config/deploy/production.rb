set :rails_env, 'production'
set :rake_env,  'production'
set :user, 'deploy'
ask :server, 'logym.ru'

server fetch(:server),
       user: "#{fetch(:user)}",
       roles: %w{app db web}