# Emotion Detection Twitter

This app fetches latest 100 tweets of the Twitter username provided and shows a pie chart representing 5 different emotions based on tweets.

## Getting Started

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Twitter API

Sign up for developer account on Twitter and get your own API credentials.
- [Twitter API Docs](https://developer.twitter.com/en/docs/twitter-api)

Replace the API keys and tokens in the app.py file.

## Installing jprq

JPRQ is a free and open-source Ngrok alternative to expose local servers online easily.

```
 pip3 install jprq
```
## Running flask app

```
 > python3 app.py
```

```
 > python3 -m jprq http 5000
```

- Press Ctrl+C to stop it

Replace the generated url in the getTweets() method in lib/networking.dart \
Run the flutter app now.
