


# 生成验证码(4位数字)
import random

def get_code():
    code = ''

    for i in range(4):
        code += str(random.randint(0,9))
    return code

from . import settings
from utils.logging import get_logger
from qcloudsms_py import SmsSingleSender
from qcloudsms_py.httpclient import HTTPError

logger = get_logger('sms')
# 发送验证码
def send_code(mobile_phone:str, code:str, min=3):
    appid = settings.appid
    appkey = settings.appkey
    phone_numbers = [mobile_phone,]
    template_id = settings.template_id
    sms_sign = settings.sms_sign

    ssender = SmsSingleSender(appid, appkey)
    params = [code, min]  # 当模板没有参数时，`params = []`, 传验证码, 后面参数默认是几分钟
    try:
        result = ssender.send_with_param(86, phone_numbers[0],
                                         template_id, params, sign=sms_sign, extend="", ext="")
        if result and result.get('result') == 0:
            return True,'发送成功'
        logger.error('短信发送失败, 失败原因是: %s' % str(result.get('errmsg')))
        return False,str(result.get('errmsg'))

    except Exception as e:
        # 出异常
        logger.error('短信发送失败, 失败原因是: %s' %str(e))
        return False, str(e) 
