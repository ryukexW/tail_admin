#!/bin/sh

echo "Xóa cache config..."
php artisan config:clear || true

echo "Đang chờ MySQL..."

until php -r "
\$host = getenv('DB_HOST');
\$db = getenv('DB_DATABASE');
\$user = getenv('DB_USERNAME');
\$pass = getenv('DB_PASSWORD');
\$port = getenv('DB_PORT') ?: 3306;

try {
    new PDO(
        \"mysql:host=\$host;port=\$port;dbname=\$db\",
        \$user,
        \$pass
    );
    echo 'MySQL ready';
} catch (Exception \$e) {
    exit(1);
}
"; do
    echo "MySQL chưa sẵn sàng, đợi 2s..."
    sleep 2
done

echo "MySQL đã sẵn sàng!"

php artisan key:generate --force || true
php artisan storage:link || true
php artisan migrate --seed --force || true

exec php-fpm