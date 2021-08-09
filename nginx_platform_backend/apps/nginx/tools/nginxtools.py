#!/usr/bin/env python
# -*- coding:utf-8 -*-

import logging
error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


class WriteNginxConf(object):
    """
    Nginx 配置文件写入零时文件
    """
    def __init__(self):
        pass

    def writeFile(self, domain, conf):
        path = "/srv/nginxtemp/"
        fileName = path + domain + '.conf'
        try:
            with open(fileName, 'w') as f:
                f.write(conf)
                status = {'status': 200, 'msg': path + domain + '.conf' + " 写入成功"}
        except Exception as e:
            error_logger.error(str(e))
            status = {'status': 500, 'msg': str(e)}
        return status

