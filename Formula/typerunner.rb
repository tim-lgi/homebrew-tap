class Typerunner < Formula
  desc "Terminal typing race game: outrun the pacers, clear the hurdles"
  homepage "https://github.com/tim-lgi/typerunner"
  url "https://github.com/tim-lgi/typerunner/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "7fddbac636c8f9ee516373d91a799c4af42ce9c510e3fe76e6da938a5e1c4c49"
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
