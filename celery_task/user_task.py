
from .celery import app

@app.task
def send_sms(phone):
    import time
    time.sleep(1)
    print('%s短信发送成功'%phone)
    return '%s短信发送成功'%phone