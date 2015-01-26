# https://code.google.com/p/pyodbc/downloads/list
# http://www.imdb.com/search/title
### loading packages
import requests
from bs4 import BeautifulSoup
from math import ceil
import pyodbc

### post payload
payload={
	"realm":"title",
	"title_type":"feature",
	"release_date-min":"2000-01-01",
	"release_date-max":"2014-06-30",
	"user_rating-min":"3.0",
	"user_rating-max":"10",
	"countries":"us",
	"languages":"en",
	"runtime-min":"60",
	"count-detailed":"50",
	"count-simple":"100",
	"boxoffice_gross_us-min":"10000",
	"sort":"boxoffice_gross_us,desc"
}

# All link in page.1
url = "http://www.imdb.com/search/process"
res = requests.post(url, data=payload)
res_text = res.text.encode('utf-8')
#print res_text
soup = BeautifulSoup(res_text)
#print soup
k = 0
f = open('data/move1.txt', 'w')

# cursor.execute("insert into [mydb].[dbo].[ConvertToolLog] ([Message]) values('test')")
cnxn = pyodbc.connect('DSN=imdb')
cursor = cnxn.cursor()

for results in soup.select('.results'):
    #print results[0]
    for tr in results.findAll('tr'):
        td_title = tr.findAll('td', {'class':'title'})
        for td in td_title:
            k = k+1
            #print td.find('a').text      #movie's title 
            #print td.find('a')['href']   #movie's link
            #print td.findAll('a')[0]['href']
            f.write("http://www.imdb.com" + td.findAll('a')[0]['href'] + "\n")
            # insert into SQL Server 2012
            cursor.execute("insert into movieLink values(?)", td.findAll('a')[0]['href'])
            cnxn.commit()
print k
f.close()