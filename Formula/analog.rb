class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.13.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.13.0/analog-darwin-arm64.tar.gz"
      sha256 "1eba258c06f0f685c7dcff1d3b036e2d874ebc359db33f6af11deb86e69da179"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.13.0/analog-darwin-amd64.tar.gz"
      sha256 "12cf59efa03de6604df085aa334c07d7366daf030d73c88c54fdcb72fc03fc9f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.13.0/analog-linux-arm64.tar.gz"
      sha256 "d37a032b57fb7264cc5eccc3083e85c4b00f1345c1bf9eb7e9aa04d1954a4c37"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.13.0/analog-linux-amd64.tar.gz"
      sha256 "f71293cda95eedec5e4e832eabd13b5d34a710f694655ba3133e4be5085967dd"
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
