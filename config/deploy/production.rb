set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '168.1.78.70', user: 'deploy', roles: %w{web app}