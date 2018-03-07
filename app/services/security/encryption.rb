require 'openssl'
#OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#APP_SECRET = '5d76113a80eb2cf1bea80a6c7a9acc64'

class String
  def encrypt#(key)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').encrypt
    cipher.key = Digest::SHA1.hexdigest app_secret
    s = cipher.update(self) + cipher.final

    s.unpack('H*')[0].upcase
  end

  def decrypt
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').decrypt
    cipher.key = Digest::SHA1.hexdigest app_secret
    s = [self].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end

  private
  def app_secret
    App.settings.app_secret
  end
end