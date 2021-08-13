import celery

import os

# 执行django配置文件，环境变量加入
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "nginx_platform_backend.settings.dev")

# 消息中间件
broker = 'redis://10.0.0.80:6379/1'

# 结果存储
backend = 'redis://10.0.0.80:6379/2'

app = celery.Celery('test', broker=broker, backend=backend,
                    include=['celery_task.home_task',
                             'celery_task.sms_task',
                             'celery_task.nginx_task'])

# 时区
app.conf.timezone = 'Asia/Shanghai'
# 是否使用UTC
app.conf.enable_utc = False

# 任务的定时配置
from datetime import timedelta
from celery.schedules import crontab

app.conf.beat_schedule = {
    'send-msg':{
        'task': 'celery_task.user_task.send_sms',
        # 'schedule': timedelta(hours=24*10),
        # 'schedule': crontab(hour=8, day_of_week=1),  # 每周一早八点
        'schedule': crontab(hour=8, day_of_month=1),  # 每月一号早八点
        'args': ('18964352112',),
    }
    # 'update-banner': {
    #     'task': 'celery_task.home_task.update_banner',
    #     'schedule': timedelta(seconds=10),
    #     'args': (),
    # }
}

