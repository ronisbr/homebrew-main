class Adolc < Formula
  desc "Package for Automatic Differentiation of Algorithms Written in C/C++"
  homepage "https://github.com/coin-or/ADOL-C"
  url "https://github.com/coin-or/ADOL-C/archive/refs/tags/releases/2.7.2.tar.gz"
  sha256 "701e0856baae91b98397960d5e0a87a549988de9d4002d0e9a56fa08f5455f6e"

  depends_on "col-pack"
  depends_on "gcc" => :build

  def install
    gcc = Formula["gcc"]
    ENV["CC"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["LD"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["CXX"] = "/usr/local/bin/g++-#{gcc.version_suffix}"

    colpack = Formula["col-pack"]

    system "./configure", "--prefix=#{prefix}",
                          "--libdir=#{prefix}/lib",
                          "--with-openmp-flag=-fopenmp",
                          "--with-colpack=#{colpack.prefix}/",
                          "--enable-sparse",
                          "--enable-docexa",
                          "--enable-addexa",
                          "--enable-parexa"
    system "make", "install"

    prefix.install "ADOL-C/examples"
  end

  test do
    system "true"
  end
end
