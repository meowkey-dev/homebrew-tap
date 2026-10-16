class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.32.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.32.0/analog-darwin-arm64.tar.gz"
      sha256 "4415d28f9767b37619f252f93575eaf6e608748a235809a97e980daf6c0b4ecc"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.32.0/analog-darwin-amd64.tar.gz"
      sha256 "fd64a6d5ee89c544bc05a1004a970cc1fd3518126cd23d7a8febad4220098213"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.32.0/analog-linux-arm64.tar.gz"
      sha256 "383f2d76975c157ccb75769e207bc8fe85b1aa1c321402c2abb87ca67993ba36"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.32.0/analog-linux-amd64.tar.gz"
      sha256 "8b405f5c05bff61ecaeed4c97070c953a6a856ef7efd0572fbd09ac6e291ca55"
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
