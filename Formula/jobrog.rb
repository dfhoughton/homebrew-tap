class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/1.0.0.tar.gz"
  sha256 "0088becad1074a0e799b2511be763a1110a5003bdf6ca2b5202f8b09e43a2bb2"

#  bottle do
#    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
#    cellar :any_skip_relocation
#    sha256 "0088becad1074a0e799b2511be763a1110a5003bdf6ca2b5202f8b09e43a2bb2" => :catalina
#  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    # color codes mess with the test
    system bin/"job", "-d", "test", "configure", "--color", "false"
    system bin/"job", "-d", "test", "configure", "--precision", "0"
    # create a greppable record
    system bin/"job", "-d", "test", "add", "testing", "jobrog"
    # with a time which will be 0
    system bin/"job", "-d", "test", "done"
    output = shell_output "#{bin}/job -d test summary"
    assert_match /0\s+testing jobrog/, output
  end
end
