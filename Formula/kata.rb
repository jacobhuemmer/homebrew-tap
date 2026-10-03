class Kata < Formula
  desc "Script library and MCP server for reusable automation"
  homepage "https://github.com/masonhuemmer/kata"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/masonhuemmer/kata.git", branch: "main"

  depends_on "rust" => :build if build.head?
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/masonhuemmer/kata/releases/download/v0.1.3/kata-0.1.3-darwin-arm64.tar.gz"
      sha256 "0b1ffb59ac8c93cac80c741248726f3147533febfc7baa1cb7bdf297d6ab0895"
    end
    on_intel do
      url "https://github.com/masonhuemmer/kata/releases/download/v0.1.3/kata-0.1.3-darwin-x86_64.tar.gz"
      sha256 "86ab6068658ec82b0389106d9bdc3e1ef478668ffe4d4125e69bdb69f7686392"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/masonhuemmer/kata/releases/download/v0.1.3/kata-0.1.3-linux-aarch64.tar.gz"
      sha256 "24603c5dee36519e08e36cfe8a7f01c5f293ff3839da45fb3f379d3b1362aa45"
    end
    on_intel do
      url "https://github.com/masonhuemmer/kata/releases/download/v0.1.3/kata-0.1.3-linux-x86_64.tar.gz"
      sha256 "4cdb1180d99d0e5386c93f05177c178bcd1b990e67380521b476a82e778b4ee5"
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
