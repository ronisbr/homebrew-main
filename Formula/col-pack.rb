class ColPack < Formula
  desc "Graph Coloring Algorithm Package"
  homepage "https://github.com/CSCsw/ColPack"
  url "https://github.com/CSCsw/ColPack/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "b22ead7da80fa1735291b2d83198adf41bf36101e4fcb2c4f07c1cfacf211c75"
  license "BSD-3-Clause"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "libtool" => :build

  def install
    gcc = Formula["gcc"]
    ENV["CC"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["LD"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["CXX"] = "/usr/local/bin/g++-#{gcc.version_suffix}"

    system "autoreconf", "-vif"
    system "./configure", "--prefix=#{prefix}", "--enable-examples"
    system "make", "install"

    doc.install "Graphs"
  end

  test do
    chdir doc do
      system "./examples/Basic/color_graph_using_GraphColoringInterface"
    end
  end
end
