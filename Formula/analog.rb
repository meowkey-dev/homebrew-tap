class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.28.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.0/analog-darwin-arm64.tar.gz"
      sha256 "04967a98f369557e16f366faa62fd4b7619ef2f1ac79e50bf0265777d331a63a"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.0/analog-darwin-amd64.tar.gz"
      sha256 "d8e941614303a69a6b1b0a01be1ce2570aa8ee0834e42cadc6a627883675943c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.0/analog-linux-arm64.tar.gz"
      sha256 "e19b0240f6a29353feef4ef288e9e244a473a78dad204e8cd7ceee7ae88ed9fa"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.0/analog-linux-amd64.tar.gz"
      sha256 "568d79d2d7ee49da72ecc844951ce0ebaf1b8cc291d8a5faf44b451242e2bc59"
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
