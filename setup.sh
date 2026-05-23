#!/bin/bash
apt update
apt install -y nginx
cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Servidor en AWS</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }
        .container {
            text-align: center;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }
        h1 {
            font-size: 3rem;
            margin: 0 0 1rem 0;
        }
        p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        .badge {
            display: inline-block;
            margin-top: 1.5rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>¡Funciona!</h1>
        <p>Mi servidor desplegado con Terraform en AWS</p>
        <div class="badge">EC2 · t3.micro · us-east-1</div>
    </div>
</body>
</html>
HTML
systemctl restart nginx
