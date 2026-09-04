class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.14.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.14.0/analog-darwin-arm64.tar.gz"
      sha256 "fb16c5cc98e8ac94dd0d14365fabe2659a7be506cee8944edf10229190932f75"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.14.0/analog-darwin-amd64.tar.gz"
      sha256 "e8d710ea7b248342aafa549ea4820a237f4cd59db279885588be647545d9b9b5"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.14.0/analog-linux-arm64.tar.gz"
      sha256 "f3b5c1849a7f95b55adea9b6464813ad09e596a5bffdc2823d6aca9788ccafba"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.14.0/analog-linux-amd64.tar.gz"
      sha256 "4ffc6eb2e3670e2b1cd31f9653614004713c0f0f6255c33766e89956837f87cb"
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
