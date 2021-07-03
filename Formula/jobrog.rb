class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/1.0.2.tar.gz"
  sha256 "1af0c8b66da09b1c12aaab745a62c2ddfa07333fbada67d0fc0183dbdc863b8b"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    sha256 cellar: :any_skip_relocation, catalina: "ed8979b793d03f9313edd40afbfc929bfec626a47242f6404d02794348932d6b"
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
