# flutter_web_nytimes

Running a test play of Flutter Web by calling the NYTimes API.

## Setup

This app uses [NYTimes' API](https://api.nytimes.com) to fetch the top stories on `techology` category. Therefore, an API key is needed. To get one, follow these steps:
1. Go to [NYTimes Developers](https://developer.nytimes.com) website
2. Register yourself and log into your account.
3. Create an *App* having *Top Stories API* enabled.
    - As a result, `App ID`, `Key`, and `Secret` values are generated
    - In this case, only the `Key` is needed.
4. Place the `Key` value of the newly created app into the `assets/config.json` file of this project.

