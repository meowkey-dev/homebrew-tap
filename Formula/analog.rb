class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.30.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.30.0/analog-darwin-arm64.tar.gz"
      sha256 "07d67f01f4c2804a7d27e3784edcc71609b0fb5e7be5061f669738ba2c826b37"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.30.0/analog-darwin-amd64.tar.gz"
      sha256 "5bb603686883d4bea29a3fcec73179a7bbcb869e241bf79013e9d555bd3bd733"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.30.0/analog-linux-arm64.tar.gz"
      sha256 "eaa70665fe7d4e1dffa7d4383d836ef6329478cc303b93453d1697044d2db91d"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.30.0/analog-linux-amd64.tar.gz"
      sha256 "3d5ebe16d54c0dd4ec67685a329056f90dc35fb44392ea51c111c3aabf324ff8"
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
