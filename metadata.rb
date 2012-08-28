maintainer       "Cameron Johnston"
maintainer_email "cameron@rootdown.net"
license          "Apache 2.0"
description      "Installs/Configures prezto (an oh-my-zsh fork)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.4.4"

depends          "git"
depends          "zsh"
suggests         "users"
suggests         "user"

%w( ubuntu debian
    centos redhat fedora ).each do |os|
  supports os
end
