require 'formula'

class Olsrd < Formula
  homepage 'http://www.olsr.org'
  url 'http://www.olsr.org/releases/0.6/olsrd-0.6.4.tar.bz2'
  version '0.6.4'
  sha1 '9a21400e7a97c685283a4e19850b88ada32bfd9c'

  def install
    args = %W[DESTDIR=#{prefix} USRDIR=#{prefix}]
    system "make", "build_all", *args
    system "make", "install", *args
    lib.install Dir['lib/*/*.so.*'] 
  end

  def caveats; <<-EOS.undent
    Copy and edit #{prefix}/etc/olsrd.conf to /etc/olsrd.conf before running olsrd!!
    EOS
  end

  def test
    `#{sbin}/olsrd 2>/dev/null`.split("\n")[1].chomp == ' *** olsr.org -  0.6.4-git_-hash_19e589525d11de846709dc67cd3f9705 ***'
  end
end