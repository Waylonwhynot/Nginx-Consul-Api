from rest_framework.exceptions import AuthenticationFailed, ValidationError
from rest_framework.views import exception_handler
from .response import APIResponse
from .logging import get_logger

logger = get_logger('django')


def common_exception_handler(exc, context):
    # context['view'] 是对应View的对象, 错误日志想拿到类名
    response = exception_handler(exc, context)
    logger.error('ip为%s的用户，访问%s视图类出错,错误信息是%s' % (
        context.get('request').META.get('REMOTE_ADDR'), str(context.get('view')), str(exc)))
    if not response:  # drf 自己处理不了, 丢给django处理的, 我们自己处理
        # 好多逻辑, 更具体的捕获异常
        if isinstance(exc, KeyError):
            return APIResponse(code=888, msg='key error', result={str(exc)})
        return APIResponse(code=777, msg='error', result='服务器异常, 请联系系统管路员')
    else:
        return APIResponse(code=999, msg=response.data.get('detail', '服务器异常，请联系系统管理员'))
        # return APIResponse(code=999, msg='drf-error', result={response.data})


# 自定义异常类
from rest_framework.exceptions import  APIException

class MyException(APIException):
    status_code = 405
    default_detail = '校验出错了'
    default_code = '错误'

    def __init__(self, detail=None, code=None):
        super().__init__(detail=None, code=None)