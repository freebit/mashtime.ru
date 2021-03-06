require 'capistrano-db-tasks'
lock '3.2.1'
set :application, 'mashtime.ru'
set :repo_url, 'https://github.com/BrandyMint/mashtime.ru.git'

set :deploy_to, proc { "/home/wwwmasha/#{fetch(:application)}" }
set :scm, :git

# set :format, :pretty
set :log_level, :info
# set :pty, true

set :linked_files, %w(config/database.yml config/omniauth.yml)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)

# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# if you want to remove the local dump file after loading
set :db_local_clean, true
# if you want to remove the dump file from the server after downloading
set :db_remote_clean, false

set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'

set :bundle_without, %w(development test deploy).join(' ')
set :bundle_jobs, 10

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute "/etc/init.d/unicorn-#{fetch(:application)} upgrade"
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
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

  before :compile_assets, 'bower:install'
  after :publishing, :restart
  after :finishing, 'deploy:cleanup'
end
