from django.utils.deprecation import MiddlewareMixin

class MyMiddle(MiddlewareMixin):
    def process_response(self, request, response):
        response['Access-Control-Allow-Origin'] = '*'
        if request.method == 'OPTIONS':
            # 可以加
            response["Access-Control-Allow-Headers"] = "Content-Type"
        return response