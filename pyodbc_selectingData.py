# -*- coding: utf-8 -*-
# https://code.google.com/p/pyodbc/downloads/list
import pyodbc
#cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=IMDB')
cnxn = pyodbc.connect('DSN=imdb')
cursor = cnxn.cursor()
cursor.execute("SELECT TOP 10 pkno, title, currency4b, budget FROM budget ORDER by currency4b")
rows = cursor.fetchall()

for i in rows:
    print i.pkno, i.title, i.currency4b, i.budget
	
	