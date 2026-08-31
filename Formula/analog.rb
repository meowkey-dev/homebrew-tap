class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.7.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.0/analog-darwin-arm64.tar.gz"
      sha256 "972281a30f5055ebb5fb520c1fe02084d24710f0d82c284ff4721a499e90285c"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.0/analog-darwin-amd64.tar.gz"
      sha256 "dcaee7f313fff64d115677a47376a40212c8f926deb1632399319f58c29bd592"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.0/analog-linux-arm64.tar.gz"
      sha256 "68d01d6bfbfcbb3e7b1866d74835354873985ace6923be1cff3a23111b267d6b"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.0/analog-linux-amd64.tar.gz"
      sha256 "c5258b9c15f43367fab13a117f13ab4ae0fcb6652296db39ffe7a720f2cb0c47"
    end
  end

  def install
    bin.install "analog", "analog-server", "analog-mcp"
  end

  test do
    assert_match "Run the Analog API", shell_output("#{bin}/analog-server --help")
    system "#{bin}/analog", "--help"
    # analog-mcp has no flags; an initialize round-trip proves it runs.
    assert_match "2024-11-05",
      pipe_output("#{bin}/analog-mcp", '{"jsonrpc":"2.0","id":1,"method":"initialize"}')
  end
end
