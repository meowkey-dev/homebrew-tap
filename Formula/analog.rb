class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.26.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.26.0/analog-darwin-arm64.tar.gz"
      sha256 "b51f920545b48ed9a30c84bc8230ef62ac86f26ee745a7ebae656316aa511658"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.26.0/analog-darwin-amd64.tar.gz"
      sha256 "a84e15dcde5830a478a71d2b9b2f1e24e3f297d089818d36574a82308a7d45b6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.26.0/analog-linux-arm64.tar.gz"
      sha256 "e1e1f144ef44096b154e9f0392136daa7d2f196402194dfc5a0cec9f1c04195b"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.26.0/analog-linux-amd64.tar.gz"
      sha256 "c761aab5f3ff1183d97d00387c46df709da590c1fce21eea0b4b345b2c1ba696"
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
