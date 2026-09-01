class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.4"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.4/analog-darwin-arm64.tar.gz"
      sha256 "a90b5389b66f9887491162f69405736d4e8c937380a449b2631917df0cbc727a"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.4/analog-darwin-amd64.tar.gz"
      sha256 "eddcefececcea29b053344afda2f53a79c6e6a0c40afd3ba0a0ace42c9f9882e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.4/analog-linux-arm64.tar.gz"
      sha256 "8ef408ad917fefbb120989cac92e5cc8ae35976e2b66e1a5543877225e0ecd82"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.4/analog-linux-amd64.tar.gz"
      sha256 "80a23114de567b340bfac6ef5ba52eb0fb3b88e278bc285409282761983899f9"
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
