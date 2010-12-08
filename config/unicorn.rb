# unicorn -c /data/github/current/config/unicorn.rb -E production -D
 
# 16 workers and 1 master
#worker_processes (rails_env == 'production' ? 8 : 4)
worker_processes 2
 
# for super-fast worker spawn times
preload_app true
 
# Restart any workers that haven't responded in 30 seconds
timeout 30
 
# Listen on a Unix data socket
listen '/tmp/chromada.sock', :backlog => 2048
# listen 80
 
# master pid file
pid '/var/run/chromada.pid'
 
# the redmin app root_dir
working_directory '/var/www/chromada'

 
before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  #old_pid = RAILS_ROOT + '/tmp/pids/unicorn.pid.oldbin'
  old_pid = '/var/run/chromada.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
     begin
       Process.kill("QUIT", File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
       # someone else did our job for us
     end
  end
end
  
  
# after_fork do |server, worker|
#  ##
#  # Unicorn master loads the app then forks off workers - because of the way
#  # Unix forking works, we need to make sure we aren't using any of the parent's
#  # sockets, e.g. db connection
# 
#  ActiveRecord::Base.establish_connection
# end