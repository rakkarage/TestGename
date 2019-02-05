sudo dotnet publish -c Release -o /var/www/html/chat
sudo nginx -s reload
sudo systemctl restart chat.service