import random
from datetime import datetime

inicio = datetime(1980, 1, 1)
final =  datetime(2001, 12, 28)

random_date = inicio + (final - inicio) * random.random()

print(random_date)