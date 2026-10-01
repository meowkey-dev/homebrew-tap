class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.29.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.0/analog-darwin-arm64.tar.gz"
      sha256 "f36ee68b96c3f4f90602fd50984e6223822256bbbdc6a03a3a0c1299aff1ebf8"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.0/analog-darwin-amd64.tar.gz"
      sha256 "8af511d49e270443a0bf5f64a2861c759aaffb57770c2ef636f2a6792a06aec6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.0/analog-linux-arm64.tar.gz"
      sha256 "345d80c88a535d1e65381c7008656efeb5a688fa242ec18565f10684f6698bf4"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.0/analog-linux-amd64.tar.gz"
      sha256 "3b2a42ed39f21af85a014f0a9dda2873afb453c82685fafc620aa757901bb6e0"
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
