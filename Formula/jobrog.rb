class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  version "0.2.1.1"
  url "https://github.com/dfhoughton/jobrog/archive/0.2.1.tar.gz"
  sha256 "38d0448ff25d3af639a21beb3263ea0c60c2df26b11bea1d70c9a88203ee3631"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    cellar :any_skip_relocation
    sha256 "16d3a94ce31369bce72c027ea2721a56b8ebee7e9cb4a45aa97b016ea9491846" => :catalina
    sha256 "eab4020e3fb836995d2762e0c402981e0c767151d874a1c852817fc244b8dc79" => :mojave
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
