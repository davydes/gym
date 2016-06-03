set :rails_env, 'production'
set :rake_env,  'production'
set :user, 'deploy'

server 'logym.ru:2200',
       user: "#{fetch(:user)}",
       roles: %w{app db web}