class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.19.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.19.0/analog-darwin-arm64.tar.gz"
      sha256 "96eb86974921253d90a5f25b84028d99f7c918c360b865b186f8a53797a1e1a9"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.19.0/analog-darwin-amd64.tar.gz"
      sha256 "6b3ed1f2aa97ed86378457573fc8036df68c5c2c898741cd6569f84bb52a3e8f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.19.0/analog-linux-arm64.tar.gz"
      sha256 "7ff20e2d5230bc08f065a1a97e8dde7224f74c34eb2241e7e9e140ee6e16120f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.19.0/analog-linux-amd64.tar.gz"
      sha256 "415ce3692776173b6dfa8c54badc537330b3291494303f74076a527202ad4077"
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
