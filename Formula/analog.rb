class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.5"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.5/analog-darwin-arm64.tar.gz"
      sha256 "9080176f875005fb11c20af554c750c7d287aeb1ef41127de928fa2fd499df77"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.5/analog-darwin-amd64.tar.gz"
      sha256 "e96a6afc670812b0424da421d3a64cac7158d6561713fdd1d9aaa74882f84458"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.5/analog-linux-arm64.tar.gz"
      sha256 "3d5bc2502954d537f8980aeaa794791e4b4d5c15b5db0ca1dffee23d4054533d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.5/analog-linux-amd64.tar.gz"
      sha256 "775812239fcadff2d294b4a51edc907e5205746e5058ae845cb5aac942e51020"
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
