class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.33.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.33.0/analog-darwin-arm64.tar.gz"
      sha256 "fc68db7b5fcba56fc7db63a063f95947462e4202323785a7cd1683739f093818"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.33.0/analog-darwin-amd64.tar.gz"
      sha256 "f2d3f109e1549317edc53c41f30a44c45f1f3e9447bd651cc0d3312b4260a7fb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.33.0/analog-linux-arm64.tar.gz"
      sha256 "e8723721bff26251d3e380fc15ce6d61ef5647a48712e53afcf0c57cffcb0543"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.33.0/analog-linux-amd64.tar.gz"
      sha256 "71be76d8771ef41f770d7ef474e7861b64c76604f61c297f01cc8fc4b5d04017"
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
