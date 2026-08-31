class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.6.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.0/analog-darwin-arm64.tar.gz"
      sha256 "b20e315fb302eb2193d36fcf6202e25ec6273acbd0fe90de8b31b812a8cd8d19"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.0/analog-darwin-amd64.tar.gz"
      sha256 "49a7461c23cda071fb09a86d02e22de3bd6d5d5635d8f0038bc5810cd9c3303f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.0/analog-linux-arm64.tar.gz"
      sha256 "145f252457aad2c1b78b59a3824f2efa38779457ab382c6f9c319d1fc88372bb"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.0/analog-linux-amd64.tar.gz"
      sha256 "9828d6b0cec1e64a549aab25dae9b0eae5018d8c11ba3a90c3ccc9846a35a697"
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
