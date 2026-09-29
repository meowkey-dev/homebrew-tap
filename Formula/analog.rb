class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.28.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.1/analog-darwin-arm64.tar.gz"
      sha256 "53e2dec561b0e6535d191b8a10f88330d1e42828a42bbcff458223089f8ffb37"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.1/analog-darwin-amd64.tar.gz"
      sha256 "4447c723cce2b96ee0edabd1163c635c51a8346beb708c67f7e3a28d11d724df"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.1/analog-linux-arm64.tar.gz"
      sha256 "bcf274e7fc949e853f09df645e9214752dc74a6991ef13fe6fafa4e7041953b7"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.28.1/analog-linux-amd64.tar.gz"
      sha256 "f8b771acbdfe88885675a1286fecabe7e63c077a386fa16db600abd3ce9ac931"
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
