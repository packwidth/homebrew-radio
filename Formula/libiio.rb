class Libiio < Formula
  desc "A cross platform library for interfacing with local and remote Linux IIO devices"
  homepage "http://analogdevicesinc.github.io/libiio/"
  url "https://github.com/analogdevicesinc/libiio/archive/refs/tags/v0.25.tar.gz"
  sha256 "21972599a3c143ab1f98002ad2b3f28f4aff927fde5f677478311cd4e517730c"
  license "LGPL-2.1-only"

  depends_on "cmake" => :build
  depends_on "libusb"

  def install
    cmake_args = [
        "-DOSX_INSTALL_FRAMEWORKSDIR=#{frameworks}",
        "-DOSX_PACKAGE=OFF",
        "-DPYTHON_BINDINGS=ON",
      ]
    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    Dir.glob("#{frameworks}/iio.framework/Tools/*").each do |exec|
      bin.install_symlink exec if File.executable?(exec)
    end
  end

  test do
    output = shell_output("#{Formula["libiio"].bin}/iio_info --version")
    assert_match "iio_info version: 0.25", output
  end
end
