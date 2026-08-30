class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.4.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.1/analog-darwin-arm64.tar.gz"
      sha256 "5ebb4382cb46ae665de493b644065003a0dd3723e93f9f198e5f0d3e9de4644d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.1/analog-darwin-amd64.tar.gz"
      sha256 "c3bba520124c8907c8eb1504b1f823640bc043456c7ac5954373d562186ac10a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.1/analog-linux-arm64.tar.gz"
      sha256 "c79d0087b43967ab63a5fec8bdbd06af5852b81eb7b859847d324776b66c5dfe"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.1/analog-linux-amd64.tar.gz"
      sha256 "7635085d7a47596a1b8bd3e36c96a72dc2eedb20019701d1710e8a87ff002cb0"
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
