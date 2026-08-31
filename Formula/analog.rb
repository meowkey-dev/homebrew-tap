class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.6.1"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.1/analog-darwin-arm64.tar.gz"
      sha256 "c3134f114606d0db731299446fe5ccc023a285a9d011c082b8114eee611ce93f"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.1/analog-darwin-amd64.tar.gz"
      sha256 "07db33501c0a1081d86d7039f00f0b96dc33ef72c0c02b42948d1b2977c7a127"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.1/analog-linux-arm64.tar.gz"
      sha256 "cda52b8378aec9f690af97d63f726b4d82ff24c234d6c282bd413122e295a588"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.6.1/analog-linux-amd64.tar.gz"
      sha256 "fdd1f86cbf1c2601ba2b8fa2c974180c0c2c740df9c9044bf16d9d837eaa8c0b"
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
