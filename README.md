![image](https://github.com/user-attachments/assets/d5e5f00a-868d-40cb-a0a8-79222d09b4f0)
# linkat: a-meow-zingly short urls
linkat is a link shortener service that shows a cat gif for 5 seconds before redirecting the user to the final url. It's inspired by services like **ad.fly**, but with cats instead of ads.

# linkat_api
linkat_api is the back-end for linkat. It runs on Elixir/Phoenix. The production url for this api is https://api.linkat.fun .

# Running linkat_api for the first time
## First steps
For production and development you will need to set up an env varibale with Google reCaptcha secret key. The name of the env variable should be `RECAPTCHA_SECRET_KEY_LINKAT`
## For development
The usual way of running phoenix apps. You need postgresql installed with the default user "postgres", "postgres" (you can change username and password of the database in `config/dev.exs`)
```bash
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
```

## For production

Before running the application, you need the env variables bellow:

- **SECRET_KEY_BASE:** The phoenix secret_key_base config. You can generate a secure key using `phx.gen.secret`
- **DATABASE_URL**: Postgres database URL


