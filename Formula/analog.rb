class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.0/analog-darwin-arm64.tar.gz"
      sha256 "0657c03ff4627548cb4cef697c7c42c9a3f37c4e5b0f14e70fb02fa99fe10948"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.0/analog-darwin-amd64.tar.gz"
      sha256 "f1db310d13d537374f3f0dee3123524ca986d4430098a39d779b2c53817ca27e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.0/analog-linux-arm64.tar.gz"
      sha256 "5a90128b916648c936fa5348bfa8113fc9e91007913944d3db8e68ef8b4d45df"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.0/analog-linux-amd64.tar.gz"
      sha256 "7351b03aba8089273e5f4c70ddc2e9f0d8d2b6f51274cdc56a770588bdac2bf3"
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
