cask "bidaide-notificator" do
  version "0.2.1"
  sha256 "5eb4c3b4c3d76fe1570ef164c2954f03ee3509e3f08584c13176f74daf488525"

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
