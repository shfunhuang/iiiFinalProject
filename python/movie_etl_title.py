#http://www.imdb.com/search/title
### loading packages
import requests
from datetime import date,datetime
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
left = soup.select('#left')[0]
#print left
total = left.text.encode('utf8').split('of')[1]
total_title = (total.split()[0])
#print total_title
tt = int(total_title.split(',')[0] + total_title.split(',')[1])
print "total title:", tt
page_number = int(ceil(float(tt)/50))
print "number of page:", page_number
### all link in each page and movie title
page_total = 0
page_format = "http://www.imdb.com/search/title?boxoffice_gross_us=10000,&release_date=2000-01-01,2014-06-30&runtime=60,&title_type=feature&user_rating=1.0,&start=%d"
#f = open('data/movie_title.txt', 'w')

# cursor.execute("insert into [mydb].[dbo].[ConvertToolLog] ([Message]) values('test')")
cnxn = pyodbc.connect('DSN=imdb')
cursor = cnxn.cursor()

k = 0
start = datetime.now()
for page in range(1, page_number*50, 50):
	try:
		page_total = page_total + 1
		url = page_format%(page)
		res = requests.get(url)
		res_text = res.text.encode('utf-8')
		soup = BeautifulSoup(res_text)
		for results in soup.select('.results'):
			for tr in results.findAll('tr'):
				td_title = tr.findAll('td', {'class':'title'})
				for td in td_title:
					k = k+1
					#f.write("http://www.imdb.com" +  td.findAll('a')[0]['href'] + "\n")
					cursor.execute("insert into movieLinkTitle values(?)",  "http://www.imdb.com" + td.findAll('a')[0]['href'])
					cnxn.commit()
		print page_total
	except BaseException, e:
		print page_total, e
#f.close()
end = datetime.now()
print "start:", start
print "end:", end
