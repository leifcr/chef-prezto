#
# Cookbook Name:: prezto
# Recipe:: default
#

include_recipe "git"
include_recipe "zsh"

# Overwrite config file if required
file_action = node[:prezto][:keep_config] ? :create_if_missing : :create
git_action = node[:prezto][:keep_git] ? :checkout : :sync

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]
  # not working?
  # home_directory = `cat /etc/passwd | grep "#{user_id}" | cut -d ":" -f6`.chop
  home_directory = "/home/#{user_id}"

  git "#{home_directory}/.zprezto" do
    repository node[:prezto][:repo]
    reference "master"
    enable_submodules true
    user user_id
    #group user_id
    action git_action
  end

  template "#{home_directory}/.zpreztorc" do
    source 'zpreztorc.erb'
    owner user_id
    #group user_id
    mode "644"
    variables(
        :theme          => node[:prezto][:theme],
        :prezto_modules => node[:prezto][:prezto_modules],
        :editor         => node[:prezto][:editor],
        :dotexpansion   => node[:prezto][:dotexpansion],
        :autotitle      => node[:prezto][:autotitle]
    )
    action file_action
  end

  %w{ zshenv zshrc zlogin }.each do |zfile|
    execute "install #{home_directory}/#{zfile}" do
      cwd "#{home_directory}"
      command "ln -s #{home_directory}/.zprezto/runcoms/#{zfile} #{home_directory}/.#{zfile}"
      not_if { ::File.exists?("#{home_directory}/.#{zfile}")}
    end
  end
end
