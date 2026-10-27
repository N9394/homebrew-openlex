class Openlex < Formula
  desc "Open-source, local-first legal AI engine and CLI"
  homepage "https://github.com/N9394/openlex"
  url "https://github.com/N9394/openlex/releases/download/v0.2.0/openlex-0.2.0.tar.gz"
  sha256 "cc073d7494beb4ff15efd0673eb9c8a1a581d6ccd663b8fc78d6599998f7fdd5"
  license "Apache-2.0"

  depends_on "node"

  def install
    # Pre-built, platform-independent package (pure-JS dependencies included).
    libexec.install Dir["*"]
    (bin/"openlex").write_env_script libexec/"sidecar/bin/openlex.js", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  def caveats
    <<~EOS
      Start the engine with:
        openlex serve
      Then, in another terminal:
        openlex status

      Models: use your own key (Settings or the local API), or run a local model:
        brew install llama.cpp      # OpenLex finds llama-server on PATH
      The data policy is local-only until you allow a provider.
    EOS
  end

  test do
    assert_match "openlex", shell_output("#{bin}/openlex help")
  end
end
