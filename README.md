# Budgeting Web App

**Disclamer**: This is intended for my personal use, and has had no security testing whatsoever. Use at your own risk.

### Installation

To run the app locally:

```shell
bundle install
touch .env
```

Populate your `.env` file with the following environment variables:

```shell
PASSWORD_DANNY # The password for Danny
PASSWORD_LAURENCE # The password for Laurence
MONGODB_URI # The conntection URI for the Mongo instance to use
WEBHOOK_AUTH_TOKEN # A random string
```

Next, set up a webhook on each monzo account, with a URL in this form, where `<your_webhook_auth_token>` is the random string you set as an environment variable.

```
http://<your_app_url>/tx/<your_username>?token=<your_webhook_auth_token>
```

For example:

```
http://budget-thing.herokuapp.com/tx/danny?token=q1w2e3r4t5y6u7i8o9p0
```

Monzo transactions will be recorded in the Mongo database, and you'll be able to log into the app with your username and password.
