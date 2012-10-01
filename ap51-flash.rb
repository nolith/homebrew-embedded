require 'formula'

class Ap51Flash < Formula
  homepage 'http://dev.cloudtrax.com/wiki/ap51-supported-devices'
  url "http://dev.cloudtrax.com/downloads/svn/ap51-flash/", :using=> :svn, :revision=> 252
  version 'r252'

  def patches
    # Fix makefile in order to define the correct version number
    'https://github.com/nolith/homebrew-embedded/raw/master/patches/000-ap51flash-r252.diff'
  end

  def install
    cd "trunk" do
      system "make ap51-flash-osx" # if this fails, try separate make/make install steps
      system "cp ap51-flash-osx ap51-flash"
      bin.install("ap51-flash")
    end
  end

  def test
    `#{bin}/ap51-flash -v`.chomp == 'ap51-flash (r252)'
  end
end