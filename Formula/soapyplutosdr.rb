class Soapyplutosdr < Formula
  desc "Soapy SDR plugin for PlutoSDR"
  homepage "https://github.com/pothosware/SoapyPlutoSDR/wiki"
  url "https://github.com/pothosware/SoapyPlutoSDR/archive/refs/tags/soapy-plutosdr-0.2.2.tar.gz"
  sha256 "d4282a946495aa8a48f9d4ab45b230fccd0e443208b5566f806d2ca892332929"
  license "LGPL-2.1-only"

  depends_on "cmake" => :build
  depends_on "libiio"
  depends_on "soapysdr"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{Formula["soapysdr"].bin}/SoapySDRUtil --check=plutosdr")
    assert_match "Checking driver 'plutosdr'... PRESENT", output
  end
end
