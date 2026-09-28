class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.27.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.27.0/analog-darwin-arm64.tar.gz"
      sha256 "8be3564d6e1cf4362625d2cb1900e3af78c6cd89bf41e689406d59076754c2aa"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.27.0/analog-darwin-amd64.tar.gz"
      sha256 "0f9d16c6b132f68dc357d5f930941c216e1f1f9c7b45d76a1046405a3b5ccf88"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.27.0/analog-linux-arm64.tar.gz"
      sha256 "c8bb9e52a9f98dce903761598740218a75694aaaae9b6e408f1eb8c48334257f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.27.0/analog-linux-amd64.tar.gz"
      sha256 "f052959f26994dd3bae56d46ecda07afabfe8fa9c9839aa1f5012c362ae0dd71"
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
