# Start nginx
sudo systemctl start nginx

# Put link of file into proper nginx location
sudo ln -sf $(readlink -f $1) /usr/share/nginx/files/.

# Get IPv6 address and print it 
ip a | grep inet6 | grep global | head -n 1 | awk '{ print $2 }' | sed 's#/.*##' | sed 's#^#[#' | sed "s%$%]:625/$(basename $1)%" 
