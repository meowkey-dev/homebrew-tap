class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.3"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.3/analog-darwin-arm64.tar.gz"
      sha256 "7de6ba36d4bfbf42fd6419033a208c53463a2328eae54248fb05c594df8ce6b5"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.3/analog-darwin-amd64.tar.gz"
      sha256 "4a6ad3bcaa67bc30906061ab1cbdd83bac873c5516d99a5158fdb484102dfbd2"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.3/analog-linux-arm64.tar.gz"
      sha256 "704b0587dd134b53075bf134b49a7ec465cfb19c79bbd2a6ef07a670b8bdd82f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.3/analog-linux-amd64.tar.gz"
      sha256 "8bac7e851a2e1f797bfa938498a37d5438811649e29b760903ba09a5e8270793"
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
