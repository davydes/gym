set :rails_env, 'staging'
set :rake_env,  'staging'
set :user, 'deploy'

server 'dev.logym.ru:2200',
  user: "#{fetch(:user)}", 
  roles: %w{app db web}