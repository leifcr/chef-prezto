git "/usr/src/zprezto" do
  repository node[:prezto][:repo]
  reference "master"
  action :sync
end

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]

  link "/home/#{user_id}/.zprezto" do
    to "/usr/src/zprezto"
    not_if "test -d /home/#{user_id}/.zprezto"
  end

  %w{ zshenv zshrc zlogin zlogout }.each do |zfile|
    execute "install /home/#{user_id}/#{zfile}" do
      cwd "/home/#{user_id}"
      command "cp -pf /home/#{user_id}/.zprezto/runcoms/#{zfile} /home/#{user_id}/.#{zfile}"
      not_if { ::File.exists?("/home/#{user_id}/.#{zfile}")}
    end
  end
end
