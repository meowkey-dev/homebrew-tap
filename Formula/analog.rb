class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.6"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.6/analog-darwin-arm64.tar.gz"
      sha256 "390735193babbbac79e563a54a68b82b3bbba3ab0b8803db496803bc47cd73b6"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.6/analog-darwin-amd64.tar.gz"
      sha256 "6ef23ba1ae703098997f2f5966862ab1d7511d0cb5ccbd7bfa6d9164c3700758"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.6/analog-linux-arm64.tar.gz"
      sha256 "63173ebc5c43583f456b047c46bb86d6a7ee1459841fe17c1cd52caa17f6005e"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.6/analog-linux-amd64.tar.gz"
      sha256 "69907e385aef9e12b760899a45a249d2a57320534775e49fa993e3d279404696"
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
