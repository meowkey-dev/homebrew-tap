class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.20.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.20.0/analog-darwin-arm64.tar.gz"
      sha256 "660a5df65a4711f6e6f7f34b0100777e9d122f6e0f819c2e9a2d78ab332e7e36"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.20.0/analog-darwin-amd64.tar.gz"
      sha256 "2c597d2d636063bf111ecf703092dd4f71899679b17374ff9d68d3b0f6767e9f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.20.0/analog-linux-arm64.tar.gz"
      sha256 "5dcf7215a6885611877d9b310b130bdc18b9249ef2841038c69af046f438b8bf"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.20.0/analog-linux-amd64.tar.gz"
      sha256 "a2e59b435dd9df2d1de324795a1b750d204bce309b355bf510c8247aafd3427a"
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
