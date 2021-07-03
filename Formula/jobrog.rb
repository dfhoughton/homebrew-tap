class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/1.0.2.tar.gz"
  sha256 "1af0c8b66da09b1c12aaab745a62c2ddfa07333fbada67d0fc0183dbdc863b8b"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "1ccad86d90f6f71ffce4b415dc161b11470a88a67aa705f327e0057ac1df0948"
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
    assert_match(/0\s+testing jobrog/, output)
  end
end
