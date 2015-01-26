#http://www.imdb.com/search/title
### loading packages
import requests
from bs4 import BeautifulSoup
from math import ceil

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
print k
f.close()

### get total page number
left = soup.select('#left')[0]
#print left
total = left.text.encode('utf8').split('of')[1]
total_title = (total.split()[0])
print total_title
tt = int(total_title.split(',')[0] + total_title.split(',')[1])
print tt
page_number = int(ceil(float(tt)/50))
print page_number

### number of link in page.1
page_total = 0
page_format = "http://www.imdb.com/search/title?boxoffice_gross_us=10000,&release_date=2000-01-01,2014-06-30&runtime=60,&title_type=feature&user_rating=1.0,&start=%d"
f = open('data/movie_link.txt', 'w')
for page in range(1, page_number*50, 50): 
    page_total = page_total + 1
    #print page_format%(page)
    f.write(page_format%(page) + '\n')
f.close()
print page_total

http://www.imdb.com/search/title?boxoffice_gross_us=10000,&release_date=2000-01-01,2014-06-30&runtime=60,&title_type=feature&user_rating=1.0,&start=1

### all link in each page and movie title
page_total = 0
page_format = "http://www.imdb.com/search/title?boxoffice_gross_us=10000,&release_date=2000-01-01,2014-06-30&runtime=60,&title_type=feature&user_rating=1.0,&start=%d"
f = open('data/movie_title.txt', 'w')
for page in range(1, page_number*50, 50): 
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
                f.write("http://www.imdb.com" +  td.findAll('a')[0]['href'] + "\n")
    print page_total
f.close()


