cask "tinycast-cn" do
  # `version` and `sha256` are bumped automatically by the tinycast-cn Release CN workflow.
  version "0.10.23-cn.1"
  sha256 "32ee5ed3f470a58e757f0eafa292b2fdaa64374c9e3cdc16cb902b554a3557a5"

  url "https://github.com/conversun/tinycast-cn/releases/download/v#{version}/Tinycast-CN-#{version}.dmg"
  name "Tinycast CN"
  desc "Tiny, fully native launcher, hotkeys, and clipboard history (Simplified Chinese build)"
  homepage "https://github.com/conversun/tinycast-cn"

  # Ships as Tinycast.app, so it owns the same path as every upstream non-beta cask.
  conflicts_with cask: [
    "abue-ammar/tinycast/tinycast",
    "abue-ammar/tinycast/tinycast-sequoia",
  ]
  depends_on macos: :tahoe

  app "Tinycast.app"

  # Self-signed, not notarized: strip quarantine on install and upgrade so Gatekeeper lets it
  # launch without a manual xattr.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tinycast.app"]
  end

  # Quit the running copy before Homebrew replaces the bundle, or the upgrade clobbers a live
  # process.
  uninstall quit: "com.conversun.tinycast-cn"

  zap login_item: "Tinycast",
      trash:      [
        "~/Library/Application Support/com.conversun.tinycast-cn",
        "~/Library/Caches/com.conversun.tinycast-cn",
        "~/Library/Preferences/com.conversun.tinycast-cn.plist",
        "~/Library/Saved Application State/com.conversun.tinycast-cn.savedState",
      ]
end
