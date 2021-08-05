import redis
POOL = redis.ConnectionPool(host='127.0.0.1', port=6379, username='default', password=123, db=0, max_connections=1000)

