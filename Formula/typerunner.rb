class Typerunner < Formula
  desc "Terminal typing race game: outrun the pacers, clear the hurdles"
  homepage "https://github.com/tim-lgi/typerunner"
  url "https://github.com/tim-lgi/typerunner/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c4402fc2805fe4a69b0d61df95eb21366f5f2ea83093d508b678153f76a8b6ea"
  license "GPL-3.0-or-later"

  depends_on "python@3.13"

  # Pure Python with no third-party dependencies, so the package is placed
  # directly and a launcher points at it. Nothing is fetched at install time.
  def install
    (libexec/"typerunner").install Dir["src/typerunner/*"]
    (bin/"typerunner").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{Formula["python@3.13"].opt_bin}/python3.13" -m typerunner "$@"
    SH
    chmod 0755, bin/"typerunner"
  end

  test do
    assert_match "typerunner #{version}", shell_output("#{bin}/typerunner --version")
  end
end
