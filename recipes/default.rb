#
# Cookbook Name:: prezto
# Recipe:: default
#

include_recipe "git"
include_recipe "zsh"

# Overwrite config file if required
file_action = node[:prezto][:keep_config] ? :create_if_missing : :create

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]
  # not working?
  # home_directory = `cat /etc/passwd | grep "#{user_id}" | cut -d ":" -f6`.chop
  home_directory = "/home/#{user_id}"

  git "#{home_directory}/.zprezto" do
    repository node[:prezto][:repo]
    reference "master"
    user user_id
    #group user_id
    action :checkout
    not_if "test -d #{home_directory}/.zprezto"
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

  %w{ zshenv zshrc zlogin zlogout }.each do |zfile|
    execute "install #{home_directory}/#{zfile}" do
      cwd "#{home_directory}"
      command "ln -s #{home_directory}/.zprezto/runcoms/#{zfile} #{home_directory}/.#{zfile}"
      not_if { ::File.exists?("#{home_directory}/.#{zfile}")}
    end
  end
end
