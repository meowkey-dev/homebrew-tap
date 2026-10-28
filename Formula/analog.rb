class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.35.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.35.0/analog-darwin-arm64.tar.gz"
      sha256 "dba63cef05cf6155392e3ed5165f24b4662202981e678d4ffedce19ce948c44e"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.35.0/analog-darwin-amd64.tar.gz"
      sha256 "89e1d89bec344d4ede7382af3d5d40089e5ee3e3935d45e99efd021ed1707b1d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.35.0/analog-linux-arm64.tar.gz"
      sha256 "533bd7c7f75ad17783e54200c7a5abac1eea139f45fc1090c586de0186f390cf"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.35.0/analog-linux-amd64.tar.gz"
      sha256 "160ba3c3b9a6ed4b1b60d7ce3fa798ef5739e08e44de3fae689ecb6f53b66e13"
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
