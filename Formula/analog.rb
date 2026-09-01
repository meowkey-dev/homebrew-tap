class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.2"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.2/analog-darwin-arm64.tar.gz"
      sha256 "9a9659b7ff08af9b9b613331bc9eef619fa32df9bad4051c012bc28404d55373"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.2/analog-darwin-amd64.tar.gz"
      sha256 "78de4554436aa1edc1a611bc29046ecd461d09b17156f7e2aa51672e17612942"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.2/analog-linux-arm64.tar.gz"
      sha256 "0f43c797d31792667a65eb9515c3e7c67cee05e81809a1b91798ab05fe052f77"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.2/analog-linux-amd64.tar.gz"
      sha256 "f85d3f88ba818e3810937293fbd3c5283abd6ed33b7291e5322b3e95c5949c56"
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
