require 'date'
require 'nokogiri'
require 'open-uri'
require 'curb-fu'

module MEGAFON
  CAPTCHA_DECODER  = '/var/www/sites/corporatino/vendor/capcha'
  IMAGE_PATH       = '/var/www/sites/corporatino/vendor/captcha/'

  URL              = 'https://serviceguide.megafonkavkaz.ru/'
  CAPTCHA_URL      = 'ps/scc/php/cryptographp.php'
  CHECK_URL        = 'ps/scc/php/check.php?CHANNEL=WWW'
  BASE_LOGIN_URL   = 'SCC/SC_BASE_LOGIN'
  LOCK_USERS_URL   = 'SCWWW/LOCK_ACTION'
  UNLOCK_USERS_URL = 'SCWWW/UNLOCK_ACTION'
  END_SESSION_URL  = 'SCWWW/CLOSE_SESSION'
  DEFAULT_HEADERS  = {'User-Agent'      => 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2',
                      'Accept-Charset ' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3'}

  class Megafon
    def initialize(login, password, abonents = [[][]])
      puts "Trying to login as #{login}"
      @session_id = login_abonent login, password

      throw "Failed login at #{login}" if @session_id.nil?
      puts "Logged in as #{login}"
      process(abonents[0], 'lock')
      process(abonents[1])
      logout login
    end

    def make_post_request(path = "", form_data = {}, params = {})
      url = URI.join(URL, path).to_s
      CurbFu.post({ :url => url,
                    :protocol => "https",
                    :headers => DEFAULT_HEADERS.merge(params)},
                    form_data)
    end

    def make_get_request(path = "", params = {})
      url = URI.join(URL, path).to_s
      CurbFu.get :url => url, :headers => DEFAULT_HEADERS.merge(params)
    end

    def write_captcha(captcha, salt)
      f = File.new(IMAGE_PATH + "captcha_" + salt + ".png", "wb")
      f.write(captcha.body)
      f.close
      IMAGE_PATH + "captcha_" + salt + ".png"
    end

    def login_abonent(login, password)
      phpsessid = make_get_request.headers['Set-Cookie'].split("\; ")[0].split("=")[1]
      captcha = make_get_request(CAPTCHA_URL + "?PHPSESSID=#{phpsessid}&ref=212&w=130",
          {'Cookie' => "PHPSESSID=#{phpsessid}",
           'Accept' => 'image/png,image/*;q=0.8,*/*;q=0.5'})
      captcha_file = write_captcha(captcha, phpsessid)
      puts "Current phpsessid: #{phpsessid}\n==============Captcha received==============="
      captcha_code = `#{CAPTCHA_DECODER} #{captcha_file}`.to_s.split("\n").last.chomp.lstrip.rstrip
      p "Captcha code is: #{captcha_code}"
      `rm #{captcha_file}`
      initial_login = make_post_request(CHECK_URL,
          {
            'CODE' => captcha_code,
            'LOGIN' => login,
            'PASSWORD' => password,
            'PHPSESSID' => phpsessid
          }, {'Cookie' => "PHPSESSID=#{phpsessid}"})
      init = Nokogiri::XML(initial_login.body).css('SESSION_ID')

      if init.count > 0 then init.text else nil end
    end

    def process(abonents, action = "unlock")
      if action == 'unlock'
        action_url = UNLOCK_USERS_URL
        action_form_data = {
          "START_DATE" => "", 'FLAG_SYSDATE' => 1,
          'CHANNEL' => 'WWW', "SESSION_ID" => @session_id,
          "P_USER_LANG_ID" => "1"}
      elsif action == 'lock'
        action_url = LOCK_USERS_URL
        action_form_data = {
          'FLAG_SYSDATE' => 1, "P_USER_LANG_ID" => "1",
          'D1' => DateTime.now.strftime("%d.%m.%Y %H:%M:%S"),
          'D2' => DateTime.now.next_month.strftime("%d.%m.%Y 00:00:00"),
          'CHANNEL' => 'WWW', "SESSION_ID" => @session_id}
      end

      for abonent in abonents do
        puts "Trying to #{action} #{abonent}"
        make_post_request(action_url,action_form_data.merge('CUR_SUBS_MSISDN' => abonent, 'SUBSCRIBER_MSISDN' => abonent))
      end
    end

    def logout(login)
      puts "Logging off #{login}"
      make_post_request(END_SESSION_URL, {
        'CHANNEL' => 'WWW',      'SESSION_ID' => @session_id,
        'P_USER_LANG_ID' => '1', 'CUR_SUBS_MSISDN' => login,
        'SUBSCRIBER_MSISDN' => login})
    end
  end
end
