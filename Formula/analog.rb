class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.12.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.12.0/analog-darwin-arm64.tar.gz"
      sha256 "496b47f1952ba2d1302c1c56330c21f508555bd4d015fb9d079b7a839a115240"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.12.0/analog-darwin-amd64.tar.gz"
      sha256 "df57ecc8f3037d7fcaa8cd6866c48651a34fa6e89c82db272cf8eb0d52698f6d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.12.0/analog-linux-arm64.tar.gz"
      sha256 "cd9225d2753316ff32472048c3b6943eab08b5434f850cd048f43b89c23a41f3"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.12.0/analog-linux-amd64.tar.gz"
      sha256 "f28cbcc4024ba28d5f3911f883f4a8aa9208e1e46675ab734e6607baa338e556"
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
