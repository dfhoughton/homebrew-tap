class Jobrog < Formula
  desc "Command-line time tracking and note taking utility"
  homepage "https://github.com/dfhoughton/jobrog"
  url "https://github.com/dfhoughton/jobrog/archive/0.1.7.tar.gz"
  sha256 "8accd977953c336cefdb150e9d5c53fb77e5839c211df00d4b2e1aa891492114"

  bottle do
    root_url "https://dl.bintray.com/dfhoughton/bottles-tap"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "3e392453a951ba4b9df393c1a3d6f0509323144687d2b3154f47ba2cd74fb1a6" => :mojave
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
