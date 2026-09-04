class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.15.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.15.0/analog-darwin-arm64.tar.gz"
      sha256 "6a450941d66773c5c71ff110e7ec17c0c753f7a91898b9d7c12de9715c5f615a"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.15.0/analog-darwin-amd64.tar.gz"
      sha256 "d8057fdac10b76c031b531fd351f9bad4253d5ff05c6e7e874df36b170243565"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.15.0/analog-linux-arm64.tar.gz"
      sha256 "dd157ae027e6885200f0b91e2c526bfeb8a3fafa0d6633be899900637ea080e4"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.15.0/analog-linux-amd64.tar.gz"
      sha256 "7c5fb88da8d6825b808fa5293f04f80aded1ad2a53fb403faa50846c6f9bc6a9"
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
