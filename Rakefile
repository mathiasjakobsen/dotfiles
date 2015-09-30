require 'rake'

desc 'Set up dotfiles for Orion'

task :default => [:install]
task :install do
  puts "======================================================================="
  puts "Setting up dotfiles for Orion..."
  puts "======================================================================="
  puts

  install_homebrew if want_to_install?("Homebrew")
  install_homebrew_packages if want_to_install?("Homebrew packages")
  install_homebrew_cask_packages if want_to_install?("Homebrew Cask Applications")
  install_dotfiles if want_to_install?("Dotfiles for Orion")
  success
end

def want_to_install? (section)
  puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
  STDIN.gets.chomp == 'y'
end

def install_homebrew
  puts "======================================================================="
  puts "Installing Homebrew, the OSX package manager..."
  puts "======================================================================="
  sh %{which brew}
  unless $?.success?
    sh %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end
end

def install_homebrew_packages
  puts "======================================================================="
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================================="
  sh %{ #{File.dirname(__FILE__) + "/Brewfile"} }
end


def install_homebrew_cask_packages
  puts "======================================================================="
  puts "Installing Homebrew Cask Applications.."
  puts "======================================================================="
  sh %{ #{File.dirname(__FILE__) + "/Caskfile"} }
end


def install_dotfiles
  puts "======================================================================="
  puts "Setting up dotfiles.."
  puts "======================================================================="
  sh %{chsh -s /bin/zsh}
  sh %{ #{File.dirname(__FILE__) + "/Install"} }
end

def success
  puts "======================================================================="
  puts ".files installed... Please restart your new crazy-ass-development-Mac."
  puts "======================================================================="
end
