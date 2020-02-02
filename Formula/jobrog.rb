class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/0.1.6.1.tar.gz"
  sha256 "ab7bfab308f1962d157a03167aea3f00624b7be40fc39e8a547d57dfc44d022c"
  version "0.1.6"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    cellar :any_skip_relocation
    rebuild 2
    sha256 "0d2091977e8f62eae0bc91003dd953d3e96425146d8a8ba29a5eb52e1c92cde5" => :catalina
    sha256 "bec3499431e0bae9634d1732a9d4e2e94d0e6c8db33875134fa2789c74228002" => :mojave
  end

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
