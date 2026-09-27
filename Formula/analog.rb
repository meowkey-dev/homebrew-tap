class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.25.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.25.0/analog-darwin-arm64.tar.gz"
      sha256 "7333f5ebd940ee8ff35e36f860fc1fc9d3289580e118631f0bba8513617b110d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.25.0/analog-darwin-amd64.tar.gz"
      sha256 "22da587d4bfbd3196ba6d0a87b33fccfc332418f6783a04008eeae9b66eb24a6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.25.0/analog-linux-arm64.tar.gz"
      sha256 "80b47e264f569839e03b1aaac61d7831f8f427b914abab703fc697958374add1"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.25.0/analog-linux-amd64.tar.gz"
      sha256 "2e78ef468bfaf1996dbc890d67421c0ed9a9286b85890fb19d8cb5a808aa75dc"
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
