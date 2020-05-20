# flutter_web_nytimes

Running a test play of Flutter Web by calling the NYTimes API.<br>
The spark was [this nice video](https://www.youtube.com/watch?v=HjlnT2ieh70). For now, I mainly updated the article's title display in the card (initially, was not visibile due to white on white, and second, escaped the characters to UTF8 to look ok).

## Setup

This app uses [NYTimes' API](https://api.nytimes.com) to fetch the top stories on `techology` category. Therefore, an API key is needed. To get one, follow these steps:
1. Go to [NYTimes Developers](https://developer.nytimes.com) website
1. Register yourself and log into your account.
1. Create an *App* having *Top Stories API* enabled.
    - As a result, `App ID`, `Key`, and `Secret` values are generated
    - In this case, only the `Key` is needed.
1. Create `assets/config.json` file having the same structure as `assets/config.json.sample` or just copy paste the file and update the value of `api_key` within that file with the `Key` value of the newly created app.

## Run

Use `./run-dev_web.sh` from this repo directory.
