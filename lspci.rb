# An attempt at an ohai plugin for lspci
# 
# 
require 'pathname'
require 'mash'
lspci = Pathname.new("/sbin/lspci")
rex = Regexp.new(/"([^"]+)"/)
devices = Mash.new
if lspci.exist?() && lspci.executable?()
  `/sbin/lspci -m`.each_line do |line|
#     rexd = line.split(/"([^"]+)"/)
     rexd = line.split(rex)
     output = devices[rexd[1]] = { "devicename" => rexd[4], "type" => rexd[2], "subsystem" => rexd[7], "vendor" => rexd[3], "subvendor" => rexd[6], "revision" => rexd[5] }
    puts output
  end
end
