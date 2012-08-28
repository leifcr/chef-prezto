#
# Cookbook Name:: prezto
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git"
include_recipe "zsh"

search( :users, "shell:*zsh" ).each do |u|
  user_id = u["id"]

  git "/home/#{user_id}/.prezto" do
    repository node[:prezto][:repo]
    reference "master"
    user user_id
    group user_id
    action :checkout
    not_if "test -d /home/#{user_id}/.prezto"
  end

  theme = data_bag_item( "users", user_id )["prezto-theme"]

  %w{ zshenv zshrc zlogin zlogout }.each do |zfile|
    execute "install /home/#{user_id}/#{zfile}" do
      cwd "/home/#{user_id}"
      command "cp -f /home/#{user_id}/.prezto/runcoms/#{zfile} /home/#{user_id}/.#{zfile}"
      not_if { ::File.exists?("/home/#{user_id}/.#{zfile}")}
    end
  end
end
