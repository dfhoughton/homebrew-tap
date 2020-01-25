class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/blob/master/archive/0.1.3.tar.gz"
  sha256 "6a2f14f35f565f9af7b8fb202ba2f8565f837274a927acfa65f19cc0bdbd868d"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    system bin, "--directory", "test", "add", "testing", "jobrog"
    system bin, "--directory", "test", "done"
    output = shell_output "#{bin} --directory test summary"
    assert_match /0\s+testing jobrog/, output
  end
end
