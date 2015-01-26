#coding:utf-8
from PIL import Image
import pyodbc

def shrinkImg(pkno):
    link = "E:/Dropbox/III/movie/img/"
    im = Image.open(link + pkno + ".jpg")
    #nim = im.resize( (int(im.size[0]*ratio), int(im.size[1]*ratio)), Image.BILINEAR )
    # goldener schnitt golden ratio
    nim = im.resize( (250, 400), Image.BILINEAR )
    #print nim.size
    nim.save(link + "./img2/" + pkno + ".jpg")
	
cnxn = pyodbc.connect('DSN=imdb_complete')
cursor = cnxn.cursor()
cursor.execute("SELECT distinct pkno FROM movie_image_link")
rows = cursor.fetchall()
k = 0
for i in rows:
    k = k + 1
    shrinkImg(i.pkno)
print k

cnxn.close()
#%%

