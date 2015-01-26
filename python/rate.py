import requests
from bs4 import BeautifulSoup
import re

res_get = requests.session()
url = "http://www.oanda.com/currency/historical-rates/"
res = res_get.get(url)
m =  re.match(r'[^ ]*data([^ ]*?\]),"display[^ ]*', ''.join(res.text.encode('utf-8').split()))

print m.groups()




