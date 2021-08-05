import logging
# logger=logging.getLogger('django') # 和配置文件中loggers日志对象下的名字对应
def get_logger(name):
    logger = logging.getLogger(name)
    return logger
