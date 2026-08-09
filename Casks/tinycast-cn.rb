cask "tinycast-cn" do
  # `version` and `sha256` are bumped automatically by the tinycast-cn Release CN workflow.
  version "0.9.1-beta.47-cn.1"
  sha256 "3b114646cef5d69bee7c392185a18cfd0bb1aa61c915126c58eee1dbb58b5458"

  url "https://github.com/conversun/tinycast-cn/releases/download/v#{version}/Tinycast-CN-#{version}.dmg",
      verified: "github.com/conversun/tinycast-cn/"
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

  # preflight runs before the new bundle is staged, so an app already in appdir means upgrade.
  # The two DSL objects share no state, hence the marker file.
  preflight do
    FileUtils.touch("#{staged_path}/.upgrade") if File.exist?("#{appdir}/Tinycast.app")
  end

  # Self-signed, not notarized: strip quarantine on install and upgrade so Gatekeeper lets it
  # launch without a manual xattr. Auto-launch only on a fresh install; upgrades stay silent.
  postflight do
    upgrade = File.exist?("#{staged_path}/.upgrade")
    FileUtils.rm_f("#{staged_path}/.upgrade")

    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tinycast.app"]

    unless upgrade
      system_command "/usr/bin/open",
                     args: ["-g", "#{appdir}/Tinycast.app"]
    end
  end

  # Quit the running copy before Homebrew replaces the bundle, or the upgrade clobbers a live
  # process. postflight relaunches it after an upgrade, never after an uninstall.
  uninstall quit: "com.conversun.tinycast-cn"

  zap login_item: "Tinycast",
      trash:      [
        "~/Library/Application Support/com.conversun.tinycast-cn",
        "~/Library/Caches/com.conversun.tinycast-cn",
        "~/Library/Preferences/com.conversun.tinycast-cn.plist",
        "~/Library/Saved Application State/com.conversun.tinycast-cn.savedState",
      ]
end
