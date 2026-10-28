class Openlex < Formula
  desc "Open-source, local-first legal AI engine and CLI"
  homepage "https://github.com/N9394/openlex"
  url "https://github.com/N9394/openlex/releases/download/v0.2.1/openlex-0.2.1.tar.gz"
  sha256 "ffa396dca5e273df2862a9fd1ca934136cc1cc9661c0dfeaadca2ceb08abf806"
  license "Apache-2.0"

  depends_on "node"

  def install
    # Pre-built, platform-independent package (pure-JS dependencies included).
    libexec.install Dir["*"]
    (bin/"openlex").write_env_script libexec/"sidecar/bin/openlex.js", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  def caveats
    <<~EOS
      Start OpenLex:
        openlex            # the terminal app (setup wizard on first run)
      or run only the engine:
        openlex serve

      Models: bring your own key (openlex use anthropic; openlex key anthropic),
      or run a local model:
        brew install llama.cpp      # OpenLex finds llama-server on PATH
      Client data stays on this computer until you allow a provider (openlex policy).
    EOS
  end

  test do
    assert_match "openlex", shell_output("#{bin}/openlex help")
  end
end
