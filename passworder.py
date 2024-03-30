from jupyter_server.auth import passwd
from random import randint

with open('/tmp/.env', mode='w') as f:
    print('\n--------------------------------------------')
    print('Please set a password for Jupyter Notebook')
    f.write('JUPYTER_PASSWORD="'+str(passwd()).replace('$', '\$')+'"\n')
    f.write(f'JUPYTER_PORT={randint(49152, 65535)}')