#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
@author: nick
@time：2021/1/20 11:20
"""

from django.conf import settings
import MySQLdb
import logging
error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


def DnsQuery(**kwargs):
    """
    DNS查询模块
    :param kwargs: domain
    :return:
    """
    conn = MySQLdb.connect(
        host=settings.DNS_IP,
        port=settings.DNS_PORT,
        user=settings.DNS_USER,
        passwd=settings.DNS_PWD,
        db=settings.DNS_NAME,
    )

    record = kwargs['domain'].split('.')[0]
    zone = kwargs['domain'].split('.', 1)[1]
    try:
        SQL = """
        SELECT CONCAT(a.name, '.',b.name) AS zone, CONCAT(c.name) AS region
        FROM batchcommand_domainrecord a 
        JOIN batchcommand_domainzone b  ON  b.id=a.zone_id
        JOIN batchcommand_domainregion c ON b.region_id = c.id
        WHERE a.name='{_record}' AND b.name='{_zone}'AND c.name IN('Office','IDC-GDS')
        """.format(_record=record, _zone=zone)
        # 创建游标
        cur = conn.cursor()
        cur.execute(SQL)
        ret = cur.fetchall()
        # 关闭连接
        cur.close()
        conn.close()
        retList = []
        # result = dict(zip([k[0] for k in cur.description], ret))
        if len(ret) > 0:
            for item in ret:
                retList.append({'解析区域': item[1]})
            return {'code': 201, 'msg': '找到解析!!', 'data': retList}
        else:
            return {'code': 200, 'msg': '在Office, GDS-IDC未解析...'}
    except Exception as e:
        error_logger.error(str(e))
        cur.close()
        conn.close()
        return {'code': 500, 'msg': str(e)}
