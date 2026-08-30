class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.4.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.0/analog-darwin-arm64.tar.gz"
      sha256 "ff3bdbf30c5d4f88ea2fdc6d3d738161456b947385acbf4b25e480f7f06a22f0"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.0/analog-darwin-amd64.tar.gz"
      sha256 "d3d648d687cdbb82a89f9f589edc525ddeeee89facca1edbfdc777573afd1f88"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.0/analog-linux-arm64.tar.gz"
      sha256 "0d48fcbc6869d2c0b21bd360c82ebb3b142989ad0fe032ec48d11ba78b52fe47"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.0/analog-linux-amd64.tar.gz"
      sha256 "4a9d220174e3ce9d4f31c85e4b17f53ce6a3354e597f76bfdeee8d68c443e6dd"
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
