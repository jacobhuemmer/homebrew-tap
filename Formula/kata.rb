class Kata < Formula
  desc "Script library and MCP server for reusable automation"
  homepage "https://github.com/jacobhuemmer/kata"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/jacobhuemmer/kata.git", branch: "main"

  depends_on "rust" => :build if build.head?
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.1/kata-0.1.1-darwin-arm64.tar.gz"
      sha256 "a9293392305fc0be21e9c8fa429c9eaa71249e4836656929767c38633a166f9b"
    end
    on_intel do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.1/kata-0.1.1-darwin-x86_64.tar.gz"
      sha256 "4166b2207d983a6c4fcceb0f0bb9fc7ee4e62e1ed38ebb9cec5e2c723be7b696"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.1/kata-0.1.1-linux-aarch64.tar.gz"
      sha256 "7456c1e61dcc1aafd70f21b1b78933be533d72704d5a07c666309aef194d4312"
    end
    on_intel do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.1/kata-0.1.1-linux-x86_64.tar.gz"
      sha256 "2ef6fa1ea3ab5439276617b2b49a62231a3759e22970e94c5e62090b67a651d2"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "crates/kata-cli")
    else
      bin.install "kata"
      pkgshare.install "THIRD-PARTY-LICENSES" if File.directory?("THIRD-PARTY-LICENSES")
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kata --version")
    ENV["KATA_HOME"] = testpath/"kata-home"
    assert_match "hello", shell_output("#{bin}/kata --plain run starter/hello").downcase
  end
end
