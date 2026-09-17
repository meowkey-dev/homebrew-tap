class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.23.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.23.0/analog-darwin-arm64.tar.gz"
      sha256 "1b79f0959a1abd4514de690b2fec6bb8877bd65f3288f0ccce3fe152eac7f37c"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.23.0/analog-darwin-amd64.tar.gz"
      sha256 "690c818186394322b98f161f2163da2d17a74c78ba08544999a648684169f4ae"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.23.0/analog-linux-arm64.tar.gz"
      sha256 "313a36e2ad2a92bfbac48c86d938f7ccef45764a125bac9785e1920b5031d674"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.23.0/analog-linux-amd64.tar.gz"
      sha256 "09292bc48d965a7434da17650695b623535056c3d2ce5175b8738e393d058aa4"
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
