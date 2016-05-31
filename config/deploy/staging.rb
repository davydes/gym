set :user, 'deploy'

server '95.161.166.171',
  user: "#{fetch(:user)}", 
  roles: %w{app db web}
