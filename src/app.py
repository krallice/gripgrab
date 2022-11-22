#!/usr/bin/python3

import re
import time
import requests
from bs4 import BeautifulSoup

TARGETURL = "https://cannonpowerworks.com/products/grip-strength-equipment-pre-rated-grippers"
SEARCHRANGES = [
    {
        "LOWERBOUND": 130,
        "UPPERBOUND": 150
    },
]

def do_main():

    while True:

        # Retrieve URL:
        response = requests.get(TARGETURL)
        if response.status_code != 200:
            return
        
        # Parse the DOM:
        response_soup = BeautifulSoup(response.text, 'html.parser')
        gripper_options = response_soup.findAll('select', attrs = {'id': 'SingleOptionSelector-0'})[0].findAll('option')
        # gripper_options = [response_soup.findAll('option') for i in response_soup.findAll('select', attrs = {'id': 'SingleOptionSelector-0'})]
        
        for gripper in gripper_options:
            for searchrange in SEARCHRANGES:
                if (int(gripper['value'].split()[0]) > searchrange['LOWERBOUND'] and int(gripper['value'].split()[0]) < searchrange['UPPERBOUND']):
                    print(gripper['value'])

        print('---')

        time.sleep(10)

if __name__ == '__main__':
    do_main()