# homebrew-tinycast-cn

Homebrew tap for [**tinycast-cn**](https://github.com/conversun/tinycast-cn) — the Simplified
Chinese build of [Tinycast](https://github.com/abue-ammar/tinycast), with a fully translated
interface and pinyin (full and initials) matching for Han-script app names. Universal
(`arm64` + `x86_64`).

```sh
brew trust --tap conversun/tinycast-cn   # Homebrew requires this for third-party taps
brew tap conversun/tinycast-cn
brew install --cask tinycast-cn
```

Updates come the usual way:

```sh
brew upgrade --cask tinycast-cn
```

The build is self-signed rather than notarized, so macOS quarantines a directly downloaded DMG.
The cask clears that flag on every install and upgrade, so there is nothing to run by hand.

It installs as `Tinycast.app`, the same path the upstream `tinycast` and `tinycast-sequoia` casks
own, so it declares a conflict with both — pick one.

`version` and `sha256` in `Casks/tinycast-cn.rb` are rewritten by the tinycast-cn `Release CN`
workflow on every release. Do not edit them by hand.
