from alipay import AliPay
from . import settings

# 支付对象
alipay = AliPay(
    appid=settings.APP_ID,  # 商家的id号
    app_notify_url=None,
    app_private_key_string=settings.APP_PRIVATE_KEY_STRING,
    alipay_public_key_string=settings.ALIPAY_PUBLIC_KEY_STRING,
    sign_type=settings.SIGN,
    debug=settings.DEBUG
)

# 支付网关
gateway = settings.GATEWAY
