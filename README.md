# calculator_app

お買い物中に簡単にお会計の計算ができる計算アプリです。

（買い物リスト・電卓・単価計算はまだ完成していません。）

## Demo


## Requirement
* 日本語に翻訳するために使用

```pubspec.yaml
  flutter_localizations:
    sdk: flutter
```

* ListTitleを横にスライドさせるために使用

```pubspec.yaml
  flutter_slidable: ^1.2.0
```

* DateFormatの日付を日本語にするために使用

```pubspec.yaml
  intl: ^0.17.0
```

* ローカルストレージにデータを保存するために使用

```pubspec.yaml
  shared_preferences: ^2.0.12
```


* ~~flutter_typeahead: ^3.2.4~~

* ~~faker: ^2.0.0~~

## Note
ビルドして時間が立つとエラーが起きるので、クリーンしてからもう一度ビルドしてください。

```bash
  flutter clean
```


