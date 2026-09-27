class Kata < Formula
  desc "Script library and MCP server for reusable automation"
  homepage "https://github.com/jacobhuemmer/kata"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/jacobhuemmer/kata.git", branch: "main"

  depends_on "rust" => :build if build.head?
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.2/kata-0.1.2-darwin-arm64.tar.gz"
      sha256 "fb191994be5371b94527586411d39154f0a3ffd39ee8952c40ca528b9b49e078"
    end
    on_intel do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.2/kata-0.1.2-darwin-x86_64.tar.gz"
      sha256 "19a4e5abe9612061434ec0682f2ea222697fdf55db9533cf1389a825fc1b3c5d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.2/kata-0.1.2-linux-aarch64.tar.gz"
      sha256 "53e348d617028a83d319932a6947749b99ba6103d3260a65bd5d7c218208a786"
    end
    on_intel do
      url "https://github.com/jacobhuemmer/kata/releases/download/v0.1.2/kata-0.1.2-linux-x86_64.tar.gz"
      sha256 "28bcb3c67cd3e8d2ba2f645b3217bd0ea4b3ef89886dcb3074eec7435a2f1899"
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
