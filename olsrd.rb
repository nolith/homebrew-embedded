require 'formula'

class Olsrd < Formula
  homepage 'http://www.olsr.org'
  url 'http://www.olsr.org/releases/0.6/olsrd-0.6.3.tar.bz2'
  version '0.6.3'
  sha1 'd949a46904e2c2ff694e8350cc5bbffb26d5011b'

  #this patch is required only for Mountain Lion
  def patches
    # The build fails because OS X defaults to RFC2292 and 
    #  requires __APPLE_USE_RFC_3542 to be set to use the newer defines.
    # http://olsr.org/bugs/print_bug_page.php?bug_id=35
    DATA if MacOS.version == :mountain_lion
  end

  def install
    args = %W[DESTDIR=#{prefix} USRDIR=#{prefix}]
    system "make", "build_all", *args
    system "make", "install_olsrd", *args
    lib.install Dir['lib/*/*.so.*'] 
  end

  def caveats; <<-EOS.undent
    -------------------------------------------
    Copy and edit #{prefix}/etc/olsrd.conf to /etc/olsrd.conf before running olsrd!!
    -------------------------------------------
    EOS
  end

  def test
    `#{sbin}/olsrd 2>/dev/null`.split("\n")[1].chomp == ' *** olsr.org -  0.6.3-git_-hash_78a8f0fcb9d6e69ec2f8e14db404aa27 ***'
  end
end

__END__
diff --git a/src/bsd/net.c b/src/bsd/net.c
index de877c1..cce8bb8 100644
--- a/src/bsd/net.c
+++ b/src/bsd/net.c
@@ -39,6 +39,8 @@
  *
  */
 
+/* This is neede to get new style options, see netinet6/in6.h */
+#define __APPLE_USE_RFC_3542 1 
 #if defined __FreeBSD_kernel__
 #define _GNU_SOURCE 1
 #endif
