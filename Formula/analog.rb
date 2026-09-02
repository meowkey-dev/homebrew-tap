class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.10.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.10.0/analog-darwin-arm64.tar.gz"
      sha256 "59ec69cb8d828659d73e92e61721b341e91e9d08f6be1522c2ab35581e726881"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.10.0/analog-darwin-amd64.tar.gz"
      sha256 "28c60a57d2064dcaf964fd9126d1a16e542996855ee29c07a80e01b70223dcd0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.10.0/analog-linux-arm64.tar.gz"
      sha256 "91548e43e147d42423cad2fc465506a1e8a2e5c50ee093b1baea100a73087269"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.10.0/analog-linux-amd64.tar.gz"
      sha256 "217ec85b86c4a1f3f6194def394780d9f3354e8598b68edc6a9ccfb537af81a0"
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
