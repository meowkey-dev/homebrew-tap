class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.5.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.0/analog-darwin-arm64.tar.gz"
      sha256 "aba9804269def5a7b603383ba650640823d7d46436cf3fcda478543e9a24966a"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.0/analog-darwin-amd64.tar.gz"
      sha256 "ecf01c4513d41dbba4a847ea64115297b4b81d569eab1371c92a6318e0bea4f4"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.0/analog-linux-arm64.tar.gz"
      sha256 "23e25f009f41eb2786ed44270f48799b2baa7c97f6f8c784d7fe3b9c727064ab"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.0/analog-linux-amd64.tar.gz"
      sha256 "1b946c9173d05023e2b2c4a00ce9cba745a3a9a8089d1afaae7e5e6423046190"
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
