class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.21.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.21.0/analog-darwin-arm64.tar.gz"
      sha256 "cc31bb49026cfa05ee82aabdd01f224172a8af7d574c628ffdbe950a77c8870d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.21.0/analog-darwin-amd64.tar.gz"
      sha256 "e8f22f5ae4fc2a8f81682d5265161b793977a4d607ac409e765bc52bf00abfff"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.21.0/analog-linux-arm64.tar.gz"
      sha256 "886caa287586d7549a82ee6a94d7c660c1d5b2272744f43b78f1c9372157dd1d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.21.0/analog-linux-amd64.tar.gz"
      sha256 "d3d78f8933f48b486ba2f8ed4963c750b7a14f6d3e03194eb8829fb5a2acb044"
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
