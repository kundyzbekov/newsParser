from bs4 import BeautifulSoup
import requests as req
import numpy as np
import mysql.connector
from mysql.connector import Error

cnx = mysql.connector.connect(user='root', database='test')
cursor = cnx.cursor()

query = ("SELECT * FROM resource")
cursor.execute(query)

for i in cursor:
    url = i[2]
    top_tag = i[3]
    top_tag_add = i[4]
    bottom_tag = i[5]
    bottom_tag_add = i[6]
    title_cut = i[7]
    title_cut_add = i[8]
    date_cut = i[9]
    date_cut_add = i[10]




resp = req.get(url)
soup = BeautifulSoup(resp.text, 'html.parser')
if (len(top_tag_add)> 0):
    coverpage_news = soup.find_all(top_tag, {'class': top_tag_add})
else:
    coverpage_news = soup.find_all(top_tag)

number_of_articles = len(coverpage_news)
list_links = []
list_titles = []
list_dates = []
list_content = []
list_news = []

for n in np.arange(0, number_of_articles):
    # Getting the link of the article
    link = coverpage_news[n].find('a')['href']
    list_links.append(link)

    # Getting the title
    if (len(title_cut_add)>0):
         title = coverpage_news[n].find(title_cut, {'class': title_cut_add}).get_text()
    else :
         title = coverpage_news[n].find(title_cut).get_text()
    list_titles.append(title)
        # Getting the content
    content = coverpage_news[n].find(bottom_tag).get_text()
    list_content.append(content)

    # Getting the datetime
    if (len(date_cut_add)>0):
        date = coverpage_news[n].find(date_cut, {'class' : date_cut_add})
        datetime = date.get('datetime')
    else :
        date = coverpage_news[n].find(date_cut)
        datetime = date.get('datetime')
    list_dates.append(datetime)

for n in np.arange(0, number_of_articles):
    array = [list_links[n], list_titles[n], list_dates[n], list_content[n]]
    list_news.append(array)


# print(list_news)



try:
    connection = mysql.connector.connect(host='localhost',
                                         database='test',
                                         user='root',
                                         password='')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

        for n in range(0, len(list_news)):
            sendLink = list_news[n][0]
            sendTitle = list_news[n][1]
            sendDatetime = list_news[n][2]
            sendContent = list_news[n][3]

            query = "INSERT INTO test(title, content, datetime, url, res_id, nd_date) VALUES ('" + sendTitle + "', '" + sendContent + "',  '"+sendDatetime+"' , '" + sendLink + "', (select resource_id from resource), (select unix_timestamp(sysdate()) ))"
            cursor.execute(query)
            connection.commit()


except Error as e:
    print("Error while connecting to MySQL", e)
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")



































