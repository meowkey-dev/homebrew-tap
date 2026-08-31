class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.5.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.1/analog-darwin-arm64.tar.gz"
      sha256 "367339246fcd391543baa70fee0e61e8873a6df3bc05a6b469d61e087cade5c8"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.1/analog-darwin-amd64.tar.gz"
      sha256 "1ad10d6b9e98b68a914df008c6f906b7069f643a99486ba6e6a28ead6f7a1d68"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.1/analog-linux-arm64.tar.gz"
      sha256 "175ce27e347bd43bfea37f28b1c1539a7b0dd1b87fc7e4a0b931e3a9bd67d68b"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.5.1/analog-linux-amd64.tar.gz"
      sha256 "9d3e9cacb562297eb9c5b12eccbedd8535d92f07690c9ca244cc06c74b67256a"
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
