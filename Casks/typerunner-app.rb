cask "typerunner-app" do
  version "0.1.0"
  sha256 "e5255de268e990b93b02741ed7ad33f02f3c4a37d7a14e744703fb4d0b9258c9"

  url "https://github.com/tim-lgi/typerunner/releases/download/app-v#{version}/Typerunner_#{version}_arm64.dmg"
  name "Typerunner"
  desc "Learn to touch type. Outrun the pacers, clear the hurdles"
  homepage "https://github.com/tim-lgi/typerunner"

  depends_on arch: :arm64

  app "Typerunner.app"

  # The app is not signed with an Apple Developer certificate, so macOS would
  # refuse to open it. Since Sequoia there is no right-click-Open bypass any
  # more: without this the only way in is System Settings > Privacy &
  # Security > Open Anyway, which is no way to hand an app to a child.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Typerunner.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/io.typerunner.app",
    "~/Library/Saved Application State/io.typerunner.app.savedState",
    "~/Library/WebKit/io.typerunner.app",
  ]
end
