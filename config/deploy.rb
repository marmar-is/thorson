# Capistrano Deploy Configurations
server '104.154.75.247', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:marmar-is/Thorson.git'
set :application,     'Thorson'
set :user,            'Matthew'
set :branch, :production # Push from production branch

#set :linked_files, fetch(:linked_files, []).push('config/database.yml')
#set :linked_dirs, fetch(:linked_dirs, []).push('shared/log', 'shared/tmp/pids', 'shared/tmp/cache', 'shared/tmp/sockets', 'vendor/bundle', 'public/system')

set :rails_env, :production
set :conditionally_migrate, true

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :unicorn_pid,     "#{shared_path}/pids/unicorn.pid"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :unicorn do
  desc 'Create Directories for Unicorn Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/sockets -p"
      execute "mkdir #{shared_path}/pids -p"
      execute "mkdir #{shared_path}/logs -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/production`
        puts "WARNING: HEAD is not the same as origin/production"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'unicorn:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :rails do
  desc "Run the console on a remote server."
  task :console do
    on roles(:app) do |h|
      execute_interactively "RAILS_ENV=#{fetch(:rails_env)} ~/.rvm/bin/rvm default do bundle exec rails console", "current"
    end
  end

  desc "View the logs on a remote server"
  task :log do
    on roles(:app) do |h|
      execute_interactively "tail -f log/#{fetch(:rails_env)}.log", "current"
    end
  end

  def execute_interactively(command, path)
    info "Connecting with #{fetch(:user)}@#{host}"
    cmd = "ssh #{fetch(:user)}@#{host} -p 22 -t 'cd #{fetch(:deploy_to)}/#{path} && #{command}'"
    exec cmd
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
