class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.31.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.31.0/analog-darwin-arm64.tar.gz"
      sha256 "504101c50e0212d69a3a563e450b954c3c6fa9a37ceb02e61d80be4754a423a0"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.31.0/analog-darwin-amd64.tar.gz"
      sha256 "6733b820c6e31f53b46dee9dddc31ff90c07d07b443622dbfc9433d2d389fc54"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.31.0/analog-linux-arm64.tar.gz"
      sha256 "bfba0287cee3713096f17bcbe8c6be856366de7df208975946c01a94b99fa076"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.31.0/analog-linux-amd64.tar.gz"
      sha256 "21d7dde1f045eb085fc5a6b17100c43986686ff43b76bf9f763c7373f4b841c9"
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
