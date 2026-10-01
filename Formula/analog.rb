class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.28.2"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.2/analog-darwin-arm64.tar.gz"
      sha256 "438f4c1dfc0788f9b4e1aac8aea7dfccfad6e39cf2b1a5b9d5481b40fc5459fe"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.2/analog-darwin-amd64.tar.gz"
      sha256 "de9719209066e8ea66c512ed9dd2dcaaf1ceebbe5a3bbf2ddb2993a72ca13a6e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.2/analog-linux-arm64.tar.gz"
      sha256 "5f1c8bd4b746f79b4ad08f91a365ea8331a0db12d964d9bed6e7e0855a1c8015"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.2/analog-linux-amd64.tar.gz"
      sha256 "fbfec7361eb2c21ff1b8038eb80116cb33a6aaf4c5b6ef7e94ce994b2afb2251"
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
