from .celery import app

@app.task
def process_order(a, b):
    print(a)
    print(b)

    return '订单处理完成'


@app.task
def cancel_order():
    import random
    res = random.choice([0,1])
    if res == 0:
        print('订单状态改了')
        return True
    else:
        print('订单取消失败')
        return False

