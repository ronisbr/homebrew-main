class Psopt < Formula
  desc "PSOPT Optimal Control Software"
  homepage "https://www.psopt.net"
  url "https://github.com/PSOPT/psopt/archive/refs/tags/5.02.tar.gz"
  sha256 "15ddd9c6b1338b725b9b928f75cce88b4f2628a3f849e813bf217d7ddaac80d0"
  license "LGPL-2.1"

  depends_on "adolc"
  depends_on "cmake" => :build
  depends_on "col-pack"
  depends_on "gcc" => :build

  def install
    gcc = Formula["gcc"]
    ENV["CC"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["LD"]  = "/usr/local/bin/gcc-#{gcc.version_suffix}"
    ENV["CXX"] = "/usr/local/bin/g++-#{gcc.version_suffix}"

    system "mkdir", "build"

    chdir "build" do
      system "cmake", "..", "-DBUILD_EXAMPLES=ON", *std_cmake_args
      system "make", "install"
      prefix.install "examples"
    end
  end

  test do
    system "true"
  end
end
