#!/bin/bash

# Define the directory path
DIR="/burstroy/webtest"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

# Create index.html
cat <<EOF > "$DIR/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Test BSP Page </h1>
    <a href="indextestws.html">indextestws</a>
</body>
</html>
EOF

# Create indextest1.html
cat <<EOF > "$DIR/indextest1.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test HTML Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #fact {
            margin-top: 20px;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <a href="index.html">Home</a>
    <h1>Random Cat Fact</h1>
    <button id="fetchFactBtn">Get Cat Fact</button>
    <div id="fact"></div>

    <script>
        document.getElementById('fetchFactBtn').addEventListener('click', function() {
            fetch('https://catfact.ninja/fact')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('fact').innerText = data.fact;
                })
                .catch(error => {
                    console.error('Error fetching cat fact:', error);
                    document.getElementById('fact').innerText = 'Failed to fetch cat fact.';
                });
        });
    </script>
</body>
</html>
EOF

# Create indextestws.html
cat <<EOF > "$DIR/indextestws.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Test Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #messages {
            border: 1px solid #ccc;
            padding: 10px;
            height: 200px;
            overflow-y: scroll;
            margin-bottom: 10px;
        }
        #messageInput {
            width: calc(100% - 120px);
            padding: 10px;
        }
        #sendButton {
            padding: 10px;
        }
    </style>
</head>
<body>
    <a href="index.html">Home</a>
    <h1>WebSocket Test Page BSP</h1>
    <div id="messages"></div>
    <input type="text" id="messageInput" placeholder="Type a message">
    <button id="sendButton">Send</button>

    <script>
        // URL тестового WebSocket-сервера
        const socketUrl = 'wss://echo.websocket.events';
        let socket;

        function initWebSocket() {
            socket = new WebSocket(socketUrl);

            socket.onopen = function(event) {
                logMessage('WebSocket connection opened.');
            };

            socket.onmessage = function(event) {
                logMessage('Received: ' + event.data);
            };

            socket.onclose = function(event) {
                logMessage('WebSocket connection closed.');
            };

            socket.onerror = function(error) {
                logMessage('WebSocket error: ' + error.message);
            };
        }

        function sendMessage() {
            const messageInput = document.getElementById('messageInput');
            const message = messageInput.value;
            if (message.trim() !== '') {
                if (socket.readyState === WebSocket.OPEN) {
                    socket.send(message);
                    logMessage('Sent: ' + message);
                    messageInput.value = '';
                } else {
                    logMessage('WebSocket is not open. Please wait and try again.');
                }
            }
        }

        function logMessage(message) {
            const messagesDiv = document.getElementById('messages');
            const messageElem = document.createElement('div');
            messageElem.textContent = message;
            messagesDiv.appendChild(messageElem);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        document.getElementById('sendButton').addEventListener('click', sendMessage);

        // Инициализация WebSocket-соединения при загрузке страницы
        window.onload = initWebSocket;
    </script>
</body>
</html>
EOF

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null
then
    sudo apt update
    sudo apt install nginx -y
fi

# Create Nginx configuration file
sudo bash -c "cat > /etc/nginx/sites-available/webtest" <<EOF
server {
    listen 80;
    server_name localhost;

    location / {
        root $DIR;
        index index.html;
        try_files \$uri \$uri/ =404;
    }

    location /ws/ {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
    }
}
EOF

# Enable the configuration and disable the default site
sudo ln -s /etc/nginx/sites-available/webtest /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Restart Nginx to apply the changes
sudo systemctl restart nginx

echo "Nginx configuration completed. Your site is now available at http://localhost"
