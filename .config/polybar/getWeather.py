import requests
from bs4 import BeautifulSoup
import html5lib

url = "https://www.timeanddate.com/weather/india/delhi"

soup = BeautifulSoup((requests.get(url)).text, 'html5lib')

weather_test = soup.find(class_="h2")

final_weather = ""

for anything in (weather_test).text.split("\xa0"):
    final_weather += anything

print(final_weather)