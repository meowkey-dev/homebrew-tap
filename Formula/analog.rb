class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.22.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.22.0/analog-darwin-arm64.tar.gz"
      sha256 "5da361315c87dc2a7589769ebc558e08c35b523f96046efcacba4e1ec2d95a1f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.22.0/analog-darwin-amd64.tar.gz"
      sha256 "a015ebb685132a00946d4b77c22bd5d15d8554def688b00e73b71d51bad28c1d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.22.0/analog-linux-arm64.tar.gz"
      sha256 "257b9ec8b3ec89803ced36e26e72a2b83b29ca305b96024be0399f40eb712d9c"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.22.0/analog-linux-amd64.tar.gz"
      sha256 "0bb9d0fa3e2bb2905d3b900e243512f44082588cd3f8457a1010e95dd8c6dd64"
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
