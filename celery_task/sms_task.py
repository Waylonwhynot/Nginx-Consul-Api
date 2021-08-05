
from .celery import app

@app.task
def send_sms(mobile, code):
    from luffyapi.libs.t_sms import send_code
    res = send_code(mobile_phone=mobile, code=code)
    if res:
        return '%s手机号, 短信发送成功'%mobile
    return '%s手机号, 短信发送失败'%mobile