# An attempt at an ohai plugin for lspci
# 
#
require 'pathname'
lspci = Pathname.new("/sbin/lspci")
output = Hash.new
if lspci.exist?() && lspci.executable?()
  `/sbin/lspci -vmm`.each_line do |line|
    if line.strip.empty?
      puts "encountered an empty line"
      puts output
      output = {}
    else
      k, v = line.gsub(/[^0-9A-Za-z\:\.\,]/, '').split(/\:/,2)
      output[k] = v
    end
  end
end
 
