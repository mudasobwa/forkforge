# encoding: utf-8

module Forkforge
  module UnicodeOrgFileFormat
    HOST = 'www.unicode.org'

    @@hash = {}

    def __grab remote_folder, local_folder, file
      require 'net/http'
      Net::HTTP.start(HOST) do |http|
        resp = http.get "/#{remote_folder}/#{file}"
        if !File.exist? local_folder
          require 'fileutils'
          FileUtils.mkpath local_folder
        end
        open("#{local_folder}/#{file}", "wb") do |file|
          file.write(resp.body.gsub(/^\s*#.*?$/, '').gsub(/\R+/, "\n").gsub(/\A\R+/, ''))
        end
      end
    end
    private :__grab

    def __load remote_folder, local_folder, file
      __grab(remote_folder, local_folder, file) unless File.exist? "#{local_folder}/#{file}"
      File.read "#{local_folder}/#{file}"
    end
    private :__load

    def __hash remote_folder, local_folder, file, fields, arrayize = true
      if @@hash[self].nil?
        @@hash[self] = {}
        __load(remote_folder, local_folder, file).split(/\R/).each do |line|
          # comment is always last, while the amount of fields is subject to change
          comment = line.scan(/(?<=#).*?$/).first.strip
          line.gsub!(/;\s*#.*$/, '') unless comment.nil?
          values = line.split ';'
          key = values.first.strip
          value = (fields.map { |f|
                    [ f, values.shift.strip ]
                  } + [[ :comment, comment ]]).to_h
          arrayize ? \
            (@@hash[self][key] ||= []) << value : \
            @@hash[self][key] = value
        end
      end
      @@hash[self]
    end
    protected :__hash

    def __to_code_point cp
      cp = cp.to_s(16) if Integer === cp
      '%04X' % cp.to_i(16)
    end

    def __to_char cp
      cp = cp.to_s(16) if Integer === cp
      [cp.to_i(16)].pack('U')
    end

  end
end
