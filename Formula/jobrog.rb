class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/2d07a77431e87cad0712a27552ff775fc2906eb1.tar.gz"
  sha256 "3aae3164ff1fc9f84a94d70839c42085d32cc55a99298d58499f638ee4580299"

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
