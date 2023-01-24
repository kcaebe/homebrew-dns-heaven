# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DnsHeaven < Formula
  desc "Fixes stupid macOS DNS stack (/etc/resolv.conf)"
  homepage "https://github.com/kcaebe/dns-heaven"
  version "0.1.4"

  depends_on "go"
  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kcaebe/dns-heaven/releases/download/v0.1.4/dns-heaven_0.1.4_darwin_arm64.tar.gz"
      sha256 "dffd07c0d94a59e7dd7089d3baee7ca532b0153d4aa7e663e24fa25eec472532"

      def install
        bin.install "dns-heaven"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/kcaebe/dns-heaven/releases/download/v0.1.4/dns-heaven_0.1.4_darwin_amd64.tar.gz"
      sha256 "ddf3ecbb5868d5fcc13083082cdca425d0ec7372f1bc5d6dc63d997750dea01a"

      def install
        bin.install "dns-heaven"
      end
    end
  end

  def post_install
    echo "$(whoami) ALL=(ALL) NOPASSWD: $(which touch)" \| sudo tee /etc/sudoers.d/touch
  end

  plist_options startup: false

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.greenboxal.dnsheaven</string>
    <key>ProgramArguments</key>
    <array>
        <string>sudo</string>
        <string>#{bin}/dns-heaven</string>
    </array>
    <key>KeepAlive</key>
    <true/>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>

    EOS
  end

  test do
    system "#{bin}/dns-heaven -version"
  end
end
