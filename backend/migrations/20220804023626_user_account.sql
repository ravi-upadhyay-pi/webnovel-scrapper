-- Add migration script here
CREATE TABLE user_account (
    user_id  INTEGER NOT NULL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

CREATE TABLE user_session (
    session_id TEXT NOT NULL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_account (user_id)
);
