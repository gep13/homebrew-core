class Libntlm < Formula
  desc "Implements Microsoft's NTLM authentication"
  homepage "https://www.nongnu.org/libntlm/"
  url "https://www.nongnu.org/libntlm/releases/libntlm-1.5.tar.gz"
  sha256 "53d799f696a93b01fe877ccdef2326ed990c0b9f66e380bceaf7bd9cdcd99bbd"

  bottle do
    cellar :any
    rebuild 1
    sha256 "209156538367e16b14671036085af8069c3b042c0b6b0b04678399a80e892b7d" => :mojave
    sha256 "16f8a36b728098991792d9a1f83090997db76123545250e09953b8607a943885" => :high_sierra
    sha256 "3ecf99f8e70bbbcdef3a6ce5f6fb6c887ed2a85421faf1af0b59ac7d87ae3d7d" => :sierra
    sha256 "c8da369479c9e222ee9e89af8da7991bed067ee3a1e496220226c9adc883d4a2" => :el_capitan
    sha256 "605133351d91c2a3f0f2899deef01b6536143ffe804495fb19b6e134511e2a8c" => :yosemite
    sha256 "800b5d2108aa693a47f6559797ef1c6fb3c906ecd35607e57eb96ad10cd7c78b" => :mavericks
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "config.h", "test_ntlm.c", "test.txt", "gl/byteswap.h", "gl/md4.c", "gl/md4.h"
  end

  test do
    cp pkgshare.children, testpath
    system ENV.cc, "test_ntlm.c", "md4.c", "-I#{testpath}", "-L#{lib}", "-lntlm", "-DNTLM_SRCDIR=\"#{testpath}\"", "-o", "test_ntlm"
    system "./test_ntlm"
  end
end
