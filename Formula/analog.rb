class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.7.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.1/analog-darwin-arm64.tar.gz"
      sha256 "3cbfe216b5fea7c8ed4c035db4b8a6280f36e2861c6173515178ee7b71c91bcc"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.1/analog-darwin-amd64.tar.gz"
      sha256 "edc68cda8b505ae26f1e2f55abef4ac62d676c7e89347481f636cf747de6f936"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.1/analog-linux-arm64.tar.gz"
      sha256 "adca98ec6c52d8fe370eb548f6b8828d5714c0fdee886edc161085c39b72760d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.7.1/analog-linux-amd64.tar.gz"
      sha256 "be4361630f987b775bc8e87cc3f01107d9a9178810c74f6b3af12ecd885dafe9"
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
