import os
# 应用私钥

Path=os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pem', 'app_private_key.pem')
print(Path)
APP_PRIVATE_KEY_STRING = open(Path,encoding='utf-8').read()

# 支付宝公钥
ALIPAY_PUBLIC_KEY_STRING = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pem', 'alipay_public_key.pem'),encoding='utf-8').read()

# 应用ID
APP_ID = '2021000117695768'

# 加密方式
SIGN = 'RSA2'

# 是否是支付宝测试环境(沙箱环境)，如果采用真是支付宝环境，配置False
DEBUG = True

# 支付网关
# GATEWAY = 'https://openapi.alipaydev.com/gateway.do' if DEBUG else 'https://openapi.alipay.com/gateway.do'
GATEWAY = 'https://openapi.alipaydev.com/gateway.do?' if DEBUG else 'https://openapi.alipay.com/gateway.do?'