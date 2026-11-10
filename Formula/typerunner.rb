class Typerunner < Formula
  desc "Terminal typing race game: outrun the pacers, clear the hurdles"
  homepage "https://github.com/tim-lgi/typerunner"
  url "https://github.com/tim-lgi/typerunner/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "6e5dc939298cd609347533bf42fb44c1ab051f3954de0dac9e3a96f9d1b6e7ae"
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
