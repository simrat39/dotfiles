import requests
from bs4 import BeautifulSoup
import html5lib

try:
    url = "https://www.timeanddate.com/weather/india/delhi"
    soup = BeautifulSoup((requests.get(url)).text, 'html5lib')
    weather_test = soup.find(class_="h2")
    tempra = int(((weather_test).text.split("\xa0"))[0])
    if "F" in ((weather_test).text.split("\xa0"))[1]:
        tempra = round((tempra - 32 ) * (5/9))
except requests.exceptions.ConnectionError:
    tempra = ""

if tempra != "":
    print(str(tempra)+"°C")
