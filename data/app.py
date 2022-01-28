from flask import Flask, jsonify

import os
import pandas as pd
import numpy as np
import re
import tweepy
from tweepy import OAuthHandler
import neattext.functions as nfx
import joblib
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split

df = pd.read_csv("Hope.csv")

consumerKey = os.environ.get('consumerKey')
consumerKeySecret = os.environ.get('consumerKeySecret')
accessToken = os.environ.get('accessToken')
accessTokenSecret = os.environ.get('accessTokenSecret')

authenticate = tweepy.OAuthHandler(consumerKey, consumerKeySecret)
authenticate.set_access_token(accessToken, accessTokenSecret)
api = tweepy.API(authenticate, wait_on_rate_limit = True)

df['Clean_Text'] = df['Text'].apply(nfx.remove_urls)
df['Clean_Text'] = df['Clean_Text'].apply(nfx.remove_stopwords)
df['Clean_Text'] = df['Clean_Text'].apply(nfx.remove_punctuations)
df['Clean_Text'] = df['Clean_Text'].apply(nfx.remove_userhandles)
df['Clean_Text'] = df['Clean_Text'].apply(nfx.remove_special_characters)
df['Clean_Text'] = df['Clean_Text'].apply(nfx.remove_numbers)

Xfeatures = df['Clean_Text']
Ylabels = df['Emotion']
cv = CountVectorizer()
X = cv.fit_transform(Xfeatures)
X_train, X_test, Y_train, Y_test = train_test_split(X, Ylabels, test_size=0.3, random_state=42)
nv_model = MultinomialNB()
nv_model.fit(X_train, Y_train)

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Emotion Detection of Tweets</p>"

@app.route("/predict/<username>",methods = ['GET'])
def predict(username):
    client = tweepy.Client(bearer_token='AAAAAAAAAAAAAAAAAAAAALRqXAEAAAAAUbngmJpG%2B2UsCz8n7zRjtnHM1tU%3DMcXUdpsohSYq5QKsIFEEXeukm4DOSnLcu6EAzoPb1OaknooGeK')
    # client = tweepy.Client(bearer_token=os.environ.get('bearer_token'))
    screen_name = username
    user = client.get_user(username=screen_name)
    ID = user.data['id']
    tweets = client.get_users_tweets(id=ID, max_results=100)
    tDict = {}
    for i in range(0, tweets.meta['result_count']):
        tDict[i] = tweets.data[i].text
    tDF = pd.DataFrame(tDict.items(), columns=['S_No', 'Tweet'])
    tDF['Clean_Tweet'] = tDF['Tweet'].apply(nfx.remove_urls)
    tDF['Clean_Tweet'] = tDF['Clean_Tweet'].apply(nfx.remove_stopwords)
    tDF['Clean_Tweet'] = tDF['Clean_Tweet'].apply(nfx.remove_punctuations)
    tDF['Clean_Tweet'] = tDF['Clean_Tweet'].apply(nfx.remove_userhandles)
    tDF['Clean_Tweet'] = tDF['Clean_Tweet'].apply(nfx.remove_special_characters)
    tDF['Clean_Tweet'] = tDF['Clean_Tweet'].apply(nfx.remove_numbers)
    result = []
    for i in range(0, len(tDF)):
        result.append(predict_emotion([tDF['Clean_Tweet'][i]],nv_model))
    return jsonify(result)

def predict_emotion(sample_text,nv_model):
    vect_text = cv.transform(sample_text).toarray()
    arr = nv_model.predict(vect_text)
    return arr[0]


if __name__ == "__main__":
    app.run(debug=True)