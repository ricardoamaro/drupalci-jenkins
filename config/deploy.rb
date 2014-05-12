# Deploy variables.
set :user, "cloud-user"
set :runner, "cloud-user"
set :port, 22
set :tmp_dir, "/tmp/drupalci-jenkins"
set :repository, "git@github.com:nickschuch/drupalci-jenkins.git"
ssh_options[:forward_agent] = true

# Register hooks.
before "puppet:prepare", "puppet:cleanup"
before "puppet:noop", "puppet:prepare"
before "puppet:apply", "puppet:prepare"
after "puppet:noop", "puppet:cleanup"
after "puppet:apply", "puppet:cleanup"

# All Puppet related commands.
namespace :puppet do

  # Prepares the puppet repository via librarian puppet.
  task :prepare do
    run "git clone --quiet #{repository} #{tmp_dir}"
    run "cd #{tmp_dir} && bundle install --path vendor/bundle"
    run "cd #{tmp_dir}/puppet && bundle exec librarian-puppet install"
  end

  task :cleanup do
    run "rm -fR #{tmp_dir}"
  end

  # This will show the changes that will be applied.
  task :noop do
    run "cd #{tmp_dir}/puppet && bundle exec sudo puppet apply --noop --modulepath ./modules --hiera_config ./etc/hiera.yaml site.pp"
  end

  # Apply the changes.
  task :apply do
    run "cd #{tmp_dir}/puppet && bundle exec sudo puppet apply --modulepath ./modules --hiera_config ./etc/hiera.yaml site.pp"
  end

end
