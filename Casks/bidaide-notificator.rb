cask "bidaide-notificator" do
  version "0.2.2"
  sha256 "c095e52039f2ae08fd3e4af4456e9ed4d57e833fd0a3f1bc98806edc95c25abb"

  url "https://github.com/DavidUps/bidaide/releases/download/v#{version}/BidaideNotificator-#{version}.zip"
  name "Bidaide Notificator"
  desc "Menu bar app, notifications and widget for GitHub pull requests, powered by GitHub CLI"
  homepage "https://github.com/DavidUps/bidaide"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "gh"
  depends_on macos: :sonoma

  app "Bidaide Notificator.app"

  # The app is ad-hoc signed and not notarized; without this Gatekeeper refuses to open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Bidaide Notificator.app"]
  end

  uninstall quit: "com.bidaide.notificator"

  zap trash: [
    "~/Library/Application Support/BidaideNotificator",
    "~/Library/Preferences/com.bidaide.notificator.plist",
  ]

  caveats <<~EOS
    Bidaide Notificator uses your GitHub CLI session. If you have not logged in yet:
      gh auth login
  EOS
end
