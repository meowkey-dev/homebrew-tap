class Analog < Formula
  desc "A shared canvas for one human and their agents"
  homepage "https://github.com/meowkey-dev/analog"
  license "Apache-2.0"
  version "0.17.0"

  livecheck do
    url "https://github.com/meowkey-dev/analog/releases"
    strategy :github_latest
  end

  # The releases carry prebuilt Go binaries per platform, so the formula points
  # at the right archive directly instead of building from source.
  on_macos do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.17.0/analog-darwin-arm64.tar.gz"
      sha256 "102b65d130cf208403711a59474f49994c90a7f8e5a8bfa39e8f9e74e6fe66c2"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.17.0/analog-darwin-amd64.tar.gz"
      sha256 "1849bfadd8c200959770c02a04efc8c4a91b7e2943dba5dedd082fa3876cb910"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.17.0/analog-linux-arm64.tar.gz"
      sha256 "5e9889074b28c095065b9ee48cc341f63338ea672e7c959f675b3be9b3260ac8"
    end
    on_intel do
      url "https://github.com/meowkey-dev/analog/releases/download/v0.17.0/analog-linux-amd64.tar.gz"
      sha256 "6681d079ea276f4d6036f5e4f5c01714f3cbcdf568a5078cf94e12e9c6fae4f9"
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
