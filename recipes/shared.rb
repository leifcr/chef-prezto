git "/usr/src/prezto" do
  repository node[:prezto][:repo]
  reference "master"
  action :sync
end

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]

  theme = data_bag_item( "users", user_id )["prezto-theme"]

  link "/home/#{user_id}/.prezto" do
    to "/usr/src/prezto"
    not_if "test -d /home/#{user_id}/.prezto"
  end

  %w{ zshenv zshrc zlogin zlogout }.each do |zfile|
    execute "install /home/#{user_id}/#{zfile}" do
      cwd "/home/#{user_id}"
      command "cp -f /home/#{user_id}/.prezto/runcoms/#{zfile} /home/#{user_id}/.#{zfile}"
      not_if { ::File.exists?("/home/#{user_id}/.#{zfile}")}
    end
  end
end
