class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.24.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.24.0/analog-darwin-arm64.tar.gz"
      sha256 "199960bdd6b122263f9eddbcb0aff7c3440f0c20224406ad2b308d30bb4813c5"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.24.0/analog-darwin-amd64.tar.gz"
      sha256 "4c5d8fdac6cfae080b34ffd0010e0e0897a8be0f493d9428242e062f6eff6bc9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.24.0/analog-linux-arm64.tar.gz"
      sha256 "d736e5ee30548093420bec5a3002cddfc4a44034ba64e8c8f4795635faf48762"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.24.0/analog-linux-amd64.tar.gz"
      sha256 "6b6f73ce4aca8c58f360fece2e1f916e249d8250075cb6ee4cd69430f01a2d8d"
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
