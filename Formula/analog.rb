class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.4.2"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.2/analog-darwin-arm64.tar.gz"
      sha256 "0436de03ddfe9d6e98f7e2548b6ddecb97d469c774112deeea4c0c8aba93a4cc"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.2/analog-darwin-amd64.tar.gz"
      sha256 "86964cfb9a0be31dd0384b1644094c82f561fe529e2dddb64782ba3b3e5ae25b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.2/analog-linux-arm64.tar.gz"
      sha256 "1c00fd3024ec03922f2ff94f979819ecb32cbfce5bd46ad0aa2436265b4d425f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.2/analog-linux-amd64.tar.gz"
      sha256 "fa806e7741f93a4e7fe44416d7863777f3b53de57243d462a15ec0979feebc8d"
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
