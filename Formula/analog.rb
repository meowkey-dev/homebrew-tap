class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.18.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.18.0/analog-darwin-arm64.tar.gz"
      sha256 "da069f553527208201d0bb50d4b1651477fafb254303d34e86034828a49127bb"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.18.0/analog-darwin-amd64.tar.gz"
      sha256 "c4dfd4183f71caab870c7ad295e78c928349ac3020a2386c28eefcba1e718163"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.18.0/analog-linux-arm64.tar.gz"
      sha256 "1a5c7bb2cea6dd75097f51d8d5d19dc873afb306e3893bb7a1bbdd21715fe3f1"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.18.0/analog-linux-amd64.tar.gz"
      sha256 "c2514e4d30562d8ff6210368de4312e83365a98d17b5d8155ebb5b952da7cae0"
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
