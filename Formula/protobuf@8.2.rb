# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Protobuf Extension
class ProtobufAT82 < AbstractPhpExtension
  init
  desc "Protobuf PHP extension"
  homepage "https://github.com/protocolbuffers/protobuf"
  url "https://pecl.php.net/get/protobuf-4.27.3.tgz"
  sha256 "7c709680073db7fffaf95bf6b66c374cdfd0bce05a869dfbb22bf89c8492d9e5"
  head "https://github.com/protocolbuffers/protobuf.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6c6db5d0298e993f33453279959f3bfb2b3eab648b2b85e35a7e5dc738a57462"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c213b2338df0a555cf7598adfc751ff7e7728709bb90e8edba2ba105fcf94bdd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f1d605600e9bda81c480a412df977019d2eb47a48f02f8f28334b1d021b9961b"
    sha256 cellar: :any_skip_relocation, ventura:        "f7c57cbfc6c8671d9bda14e940b8be901b3ea3b71cff7c3c66adf57d1e7949f5"
    sha256 cellar: :any_skip_relocation, monterey:       "89b482c4a50be3ced89d3e8b3ecf6f6e5dd7b39ed46e75984911f9e2e5640c7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9eb158caa4d07bf38de357ff4ffab1b113156c0b114191830688471d805a32e"
  end

  def install
    Dir.chdir "protobuf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-protobuf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end

  def caveats
    <<~EOS
      Copyright 2008 Google Inc.  All rights reserved.

      Redistribution and use in source and binary forms, with or without
      modification, are permitted provided that the following conditions are
      met:

          * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
          * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following disclaimer
      in the documentation and/or other materials provided with the
      distribution.
          * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
      A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

      Code generated by the Protocol Buffer compiler is owned by the owner
      of the input file used when generating it.  This code is not
      standalone and requires a support library to be linked with it.  This
      support library is itself covered by the above license.

      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end
end
