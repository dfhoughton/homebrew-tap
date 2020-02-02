class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  version "0.1.6"
  url "https://github.com/dfhoughton/jobrog/archive/0.1.6.1.tar.gz"
  sha256 "ab7bfab308f1962d157a03167aea3f00624b7be40fc39e8a547d57dfc44d022c"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "42b3fd3b4aebef485f1e9fa9231ac9f081c3cf33c26a281c2cfe30c919cd67f3" => :catalina
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
