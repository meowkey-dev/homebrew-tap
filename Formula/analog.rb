class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.34.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.34.0/analog-darwin-arm64.tar.gz"
      sha256 "7853f6aacd8efc1d8ff7fa06b6b4f4ac0a080e43bc55da15c1990aa53b795a2a"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.34.0/analog-darwin-amd64.tar.gz"
      sha256 "4a878a6880049b4169be8081c77eead2d2459e3069552d8450bde50a50ca795e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.34.0/analog-linux-arm64.tar.gz"
      sha256 "099cbce50cb5e023910b630c523d5f4fa3058ad6e9bc154df12bb0c9d3a8a63b"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.34.0/analog-linux-amd64.tar.gz"
      sha256 "63c0fd985c992a662062b85d3a55a256b03525a64b2e0283dcacb41a0820e3fb"
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
