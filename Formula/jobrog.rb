class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/0.1.9.tar.gz"
  sha256 "c4077c7d8f4dab5a1d1d56b0c0107406b22df1f90f4acdf58d47b6cc3d4d3ca1"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    cellar :any_skip_relocation
    sha256 "0342f3b09b5fea50de7e05f06500c8e8466b109712c310a9a0400e63fbb2b401" => :catalina
    sha256 "792e26a5fe1ede4b8a565080e91482f00ae61528db74578c7289e0d7f83fffcf" => :mojave
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
