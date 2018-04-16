
# 記事データインポート

```
# インストール
$ brew install embulk
$ embulk gem install embulk-output-td


# api key
guess.ymlを編集

# guessする
$ embulk guess guess.yml -o load.yml

$ embulk preview load.yml

$ embulk run load.yml

```

https://docs.treasuredata.com/articles/embulk-import-local


