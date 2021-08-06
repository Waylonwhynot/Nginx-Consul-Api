from rest_framework.response import Response


class APIResponse(Response):
    def __init__(self, code=20000, message='成功', data=None, status=None,
                 template_name=None, headers=None,
                 exception=False, content_type=None, **kwargs):
        response_dic = {'code': code, 'message': message}
        if data:
            response_dic = {'code': code, 'msg': message, 'data': data}
        response_dic.update(kwargs)

        super(APIResponse, self).__init__(data=response_dic, status=status,
                                          template_name=template_name, headers=headers,
                                          exception=exception, content_type=content_type)
