class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.4.3"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.3/analog-darwin-arm64.tar.gz"
      sha256 "1f10c2147204c1c20c7b7b10419bbc4d697f4249b13ef3b96661c92d408da307"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.3/analog-darwin-amd64.tar.gz"
      sha256 "46052ebf8362ebef9ca6b69590a00abd02ce13fda9174c65ac9c1b17e47e0075"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.3/analog-linux-arm64.tar.gz"
      sha256 "f6a7be82ca56c6731678705bca07f854d41691356b1bfd938b0e5784a2292cad"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.4.3/analog-linux-amd64.tar.gz"
      sha256 "1171cab5dece3cdde01a94e9d595963fe8789d4d458ffc060b4473b4ae9624c9"
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
