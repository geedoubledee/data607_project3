# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 12:41:20 2023

@author: glend
"""
import config
import requests as req
from requests.auth import HTTPBasicAuth
import time
import pandas as pd

lt = time.localtime()
cur_sec = lt[5]
cur_min = lt[4]
cur_hr = lt[3]
cur_day = lt[2]
cur_mon = lt[1]
cur_yr = lt[0]
cur_date = str(cur_yr) + "-" + str(cur_mon) + "-" + str(cur_day)
cur_time = str(cur_hr) + "-" + str(cur_min) + "-" + str(cur_sec)

feeds_dict = {"ai-jobs.net": "2594160",
              "CareerCastIT&Engineering": "2594162",
              "OpenDataScienceJobPortal": "2594166",
              "JobsforR-Users": "1378327",
              "MLconfJobBoard": "2594174",
              "PythonJobBoard": "977141"}

feeds = ["2594160",
         "2594162",
         "2594166",
         "1378327",
         "2594174",
         "977141"]

responses = []

#Feedbin API Call
def call_feedbin_api():
    start = "https://api.feedbin.com/v2/feeds/"
    end = "/entries.json"
    for i in range(len(feeds)):
        feed = feeds[i]
        url = start + feed + end
        response = req.get(url, auth = HTTPBasicAuth(config.feedbin_user, config.feedbin_pw)).json()
        df = pd.DataFrame(data=response)
        responses.append(df)
    big_df = pd.concat(responses)
    csv_str = cur_date + "_feeds_" + cur_time + ".csv"
    big_df.to_csv(csv_str)

def call_linkedin_api():
    url = "https://linkedin-jobs-search.p.rapidapi.com/"
    page = 1
    searching = True
    while searching:
        headers = {"content-type": "application/json",
    		"X-RapidAPI-Key": "721e8b75bamsh5449b1adc40e4afp1f81c9jsn19f891a4d6ad",
    		"X-RapidAPI-Host": "linkedin-jobs-search.p.rapidapi.com"}
        payload = {"search_terms": "data scientist",
            "location": "United States",
            "page": str(page)}
        response = req.request("POST", url, json=payload, headers=headers)
        response_json = response.json()
        try:
            df = pd.DataFrame(data=response_json)
            csv_str = cur_date + "_linkedin_pg_" + str(page) + "_" + cur_time + ".csv"
            df.to_csv(csv_str)
            page += 1
        except:
            print("broke, pg " + str(page))
            page = 1
            searching = False
            break

call_feedbin_api()
call_linkedin_api()