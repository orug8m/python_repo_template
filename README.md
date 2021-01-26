# Python batch スクリプトのテンプレート

## 環境構築

VSCode の拡張機能 `VSCode Remote-Container` を使って python と関連ライブラリを閉じ込めます

[Container + Visual Studio Code を使った Python3 の開発環境の作り方](https://aadojo.alterbooth.com/entry/2020/08/20/102600)

```
$ cp .env{.sample,}
```

### VSCode の setting.json

- python は black で format
  - VSCode 拡張機能：Python `ms-python.python` を入れる
- default は prettier で format
  - VSCode 拡張機能：Prettier - Code formatter `esbenp.prettier-vscode` を入れる

```
{
	// linterの設定
	"python.linting.pylintEnabled": false,
	"python.linting.flake8Enabled": true,
	"python.linting.enabled": true,
	"python.linting.lintOnSave": true,
	"python.linting.flake8Args": [
		"--max-line-length",
		"88",
		"--ignore=E203,W503,W504"
	],
	"python.formatting.blackArgs": ["--line-length", "110"],
	// formatterの設定
	"python.formatting.blackPath": "/usr/local/bin/black", // Remote Container内のpath
	"python.formatting.provider": "black",
	"editor.formatOnSave": true,
	"[python]": {
		"editor.defaultFormatter": null // pythonにはprettierをformatterに指定させない
	},
	"editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

### aws cli を使えるようにしたい場合

#### host の credential を持ってくる

```
# ※ hostの`~/.aws`にシンボリックリンクを貼っている場合は参照先ファイルpath
docker cp ~/.aws repo_template_batch_1:root/.aws
```

### gpg を使ってコミットに sign している場合

[Docker コンテナ内の Git で GPG 署名する](https://fedyya.wordpress.com/2020/04/01/container-with-git-using-gpg-sign/)

```
docker cp `private_key.gpgのパス` repo_template_batch_1:src/private_key.gpg
```

```
1. gpg --import <鍵名> を実行する（秘密鍵は上記のdocker cpなどで持ってくる）
2. git config --global commit.gpgSign true を実行する
3. git config --global gpg.program gpg を実行する
4. git config --global user.siginingkey <鍵ID> を実行する
5. ~/.profile に export GPG_TTY=$(tty) を書き足す
```
