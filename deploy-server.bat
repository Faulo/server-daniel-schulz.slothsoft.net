call git pull
if not %errorlevel% == 0 pause
call composer install --ignore-platform-reqs --no-dev
if not %errorlevel% == 0 pause