maintainer       "Leif Ringstad"
maintainer_email "leifcr@gmail.com"
license          "MIT"
description      "Installs/Configures prezto"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

depends          "git"
depends          "zsh"
suggests         "users"
suggests         "user"

%w( ubuntu debian centos redhat fedora ).each do |os|
  supports os
end
