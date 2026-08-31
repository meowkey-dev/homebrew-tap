class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.8.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.1/analog-darwin-arm64.tar.gz"
      sha256 "8779754961d05e4339b446ccb5831fbc56a16ab86702656a0d761cdc6518624f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.1/analog-darwin-amd64.tar.gz"
      sha256 "009d15db17091724b7417e91be126de54f08213188aeb4faec84993ddcccfca1"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.1/analog-linux-arm64.tar.gz"
      sha256 "d480a164240bbfc7e1885eba2b3d4fc92c8b60f07ea85273933868ff9b3b66c2"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.8.1/analog-linux-amd64.tar.gz"
      sha256 "651deadf565b5d54e1bec34ae6560bdecc8d8395b0607b662a682560614a5fa5"
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
