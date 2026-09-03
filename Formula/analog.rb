class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.11.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.11.0/analog-darwin-arm64.tar.gz"
      sha256 "d3bf274c9ff8e903d5c6499594fcdcb685d87a6027709654861c97f849012701"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.11.0/analog-darwin-amd64.tar.gz"
      sha256 "8138f3dec70d843361a6b7b6acd36e40ee867d2bdcf5c82eeedb421f493b4a17"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.11.0/analog-linux-arm64.tar.gz"
      sha256 "497ebfc5ea73f42130a164540dba1249620d9644ed4e25be5cc569bcc736f659"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.11.0/analog-linux-amd64.tar.gz"
      sha256 "84ea5d8416ff9acf5a57f650260a3c960318d2c2aeca6f36264c706c8637d498"
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
