class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.9.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.9.0/analog-darwin-arm64.tar.gz"
      sha256 "f0d903cf86bd88ed92a8627a2b0af34af8613baa83143cd3b21a98d34fda653d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.9.0/analog-darwin-amd64.tar.gz"
      sha256 "7e5a2bbccfafdc2201b097921ffc1121213c74fab2310723c0d5974217fd9d48"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.9.0/analog-linux-arm64.tar.gz"
      sha256 "dc5effa30149057a231dea8db08611818e45b654487330d4f4793374420bce94"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.9.0/analog-linux-amd64.tar.gz"
      sha256 "01f8f7656502982da19152b4fedb724e6b31893020eddb5f4138d548fdd97a23"
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
