class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.29.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.1/analog-darwin-arm64.tar.gz"
      sha256 "9fdae541de082ae9c3c59a3477c88a16746d982e32dafa90a6a286e54b0835a7"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.1/analog-darwin-amd64.tar.gz"
      sha256 "0aa12c1dacecb85485516a2bb43ef06a8dabd499fcb0805bcae330e4c7680ea7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.1/analog-linux-arm64.tar.gz"
      sha256 "8b28c1578b928e8cbb010473183f2543e0b9092b0d02d7bbfb213dd3a1299c4f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.29.1/analog-linux-amd64.tar.gz"
      sha256 "b5adbd3b971596fb97c1bf14dd32a20c7fdac2b85647eebfeb3b22bdad5cf55d"
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
