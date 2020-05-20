# flutter_web_nytimes

Running a test play of Flutter Web by calling the NYTimes API.

## Setup

This app uses [NYTimes' API](https://api.nytimes.com) to fetch the top stories on `techology` category. Therefore, an API key is needed. To get one, follow these steps:
1. Go to [NYTimes Developers](https://developer.nytimes.com) website
1. Register yourself and log into your account.
1. Create an *App* having *Top Stories API* enabled.
    - As a result, `App ID`, `Key`, and `Secret` values are generated
    - In this case, only the `Key` is needed.
1. Create `assets/config.json` file having the same structure as `assets/config.json.sample` or just copy paste the file and update the value of `api_key` within that file with the `Key` value of the newly created app.

