class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.16.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.16.0/analog-darwin-arm64.tar.gz"
      sha256 "ae4587c9708ffeddd7e19c35d4c933cc3f05bab7d625725ad50eefab50774ee3"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.16.0/analog-darwin-amd64.tar.gz"
      sha256 "1f32217ea4f298d86fe5112cee54e1352ddd863038cecc1dca4aa3d65c247bba"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.16.0/analog-linux-arm64.tar.gz"
      sha256 "bfa5e0a07838a562843a1e7bf208a773cbf9c62793b7f88be1ac774aaeec6323"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.16.0/analog-linux-amd64.tar.gz"
      sha256 "2fcb8d98700b9e91047e66705d77098a408f3ad4e6c2d8977bcc29d81cffdb57"
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
