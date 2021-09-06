#   GitHubUserViewer

## このアプリについて
* GitHubのユーザーを閲覧できるクライアントアプリです

---
## セットアップ
* Homebrewがない場合はインストール 
```
https://brew.sh/index_ja
```
* homebrewでrswiftをインストール
```
$ brew install rswift
```
* コミットテンプレートの設定
```
$ sh ./Scripts/committemplete.sh
```
* 認証トークン `access_token.txt` をリポジトリ直下に格納する
    * 認証トークンはGitHubにアップロードできないため個別で格納する

---
## ライブラリ
* Swift Package Managerで管理しています
```
https://swift.org/package-manager/
```

---
## 設計
* 基本はMVVMを採用しています
* バインディングを行わないようにしています
    * ViewModelのstate変更をdelegateで受け取る形でViewを更新します

---
## リソースについて
* Rswiftを使って管理しているので下記に定義し、直定義・直指定を避けるようにしています
    * 画像 Images.xcassets
    *  色 Colors.xcassets
    * 文字 Localizable.strings

---
## 画像引用元
* アイコン画像を利用しました
```
https://icooon-mono.com/
```

---
