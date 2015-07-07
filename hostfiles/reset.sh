#!/bin/bash
rm /etc/hosts
cp /Users/mathiasjakobsen/dotfiles/hostfiles/hosts /etc/

rm /etc/apache2/extra/httpd-vhosts.conf
cp /Users/mathiasjakobsen/dotfiles/hostfiles/httpd-vhosts.conf /etc/apache2/extra/

echo "Hostfiles was successfully reset.."
