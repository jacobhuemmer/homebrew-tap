class Jkins < Formula
  desc "Native Go Jenkins CLI with an encrypted local vault"
  homepage "https://github.com/masonhuemmer/jkins"
  version "2.462.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/masonhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_darwin_arm64.tar.gz"
      sha256 "5340a06ad59cb46bd397057ca70867af292ce75015e7e31cfa23b34780772bbe"
    else
      url "https://github.com/masonhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_darwin_amd64.tar.gz"
      sha256 "cf539c7853121aad7f3a0467ddb2a43bfcdf1d4c9e665113becc18d8a9616c7d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/masonhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_linux_arm64.tar.gz"
      sha256 "177ff380713068708271515986ec12d4eb61f95658cd46351a742492cab03916"
    else
      url "https://github.com/masonhuemmer/jkins/releases/download/v2.462.3/jkins_2.462.3_linux_amd64.tar.gz"
      sha256 "ca686d674d262723bf367764cce6ef7965835ab9f2b719fe46129d6b5d5ee893"
    end
  end

  def install
    bin.install "jkins"
  end

  test do
    assert_match "jkins v#{version}", shell_output("#{bin}/jkins --version")
  end
end
