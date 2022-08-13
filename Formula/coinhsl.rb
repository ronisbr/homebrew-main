# This formula builds the HSL linear solvers using Coin-OR scripts.
#
# It is your responsibility to obtain a valid license for the HSL linear solvers
# and copy the .tar.gz package to `/tmp`.
class Coinhsl < Formula
  desc "HSL linear solvers build for Coin-OR"
  homepage "https://www.hsl.rl.ac.uk/ipopt/"
  url "https://github.com/coin-or-tools/ThirdParty-HSL", :using => :git, :tag => "releases/2.2.1"
  version '2.2.1'

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build

  resource "coinhsl" do
    url "file:///tmp/coinhsl-archive-2021.05.05.tar.gz"
    sha256 "5dca8552c4bd8b549cb24359d20c0ec6863542922587a9ab8265c5f0a0ebd424"
  end

  def install
    resource("coinhsl").stage do
      (buildpath/"coinhsl").install Dir["*"]
    end

    system "./configure", "--prefix=#{prefix}",
                          "--libdir=#{prefix}/lib"
    system "make", "install"

    lib.install_symlink lib/"libcoinhsl.dylib" => "libhsl.dylib"
  end
end
