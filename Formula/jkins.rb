class Jkins < Formula
  desc "Native Go Jenkins CLI with an encrypted local vault"
  homepage "https://github.com/jacobhuemmer/jkins"
  version "2.462.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jacobhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_darwin_arm64.tar.gz"
      sha256 "765abd3d311aeb529ee7d2afdcc97a3f03e8b866e4161a244d750832946e5ba4"
    else
      url "https://github.com/jacobhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_darwin_amd64.tar.gz"
      sha256 "c2e3483baccc83ffdf10d9f8cd0112452853ffed14ba98a0d4d956ee961c6e9a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jacobhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_linux_arm64.tar.gz"
      sha256 "e9072a8c768a95cf4386b3dc39237287cdacee23918869580178a8187b583d33"
    else
      url "https://github.com/jacobhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_linux_amd64.tar.gz"
      sha256 "89a11cf4fde2eebbfad88ef730f00c1d07cbdc1cb814a6c9d034bbfc8a942ba4"
    end
  end

  def install
    bin.install "jkins"
  end

  test do
    assert_match "jkins v#{version}", shell_output("#{bin}/jkins --version")
  end
end
