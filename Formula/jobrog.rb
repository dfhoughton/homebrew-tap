class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/0.3.3.tar.gz"
  sha256 "1e7e531e20bb003d9c9f4379b3fca389d419a5a29d8e6ecf243555acaecce79f"

#  bottle do
#    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
#    cellar :any_skip_relocation
#    sha256 "085a1d11897d723012156c6c0b579b053c25de391fdf0841d639dbf531629ca0" => :catalina
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
