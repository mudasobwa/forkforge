# encoding: utf-8

module Forkforge
  module UnicodeOrgFileFormat
    HOST = 'www.unicode.org'

    @@hashmap = {}

    def i_grab remote_folder, local_folder, file
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
    private :i_grab

    def i_load remote_folder, local_folder, file
      i_grab(remote_folder, local_folder, file) unless File.exist? "#{local_folder}/#{file}"
      File.read "#{local_folder}/#{file}"
    end
    private :i_load

    def i_hash remote_folder, local_folder, file, fields, arrayize = true
      if @@hashmap[self.name].nil?
        @@hashmap[self.name] = {}
        i_load(remote_folder, local_folder, file).split(/\R/).each do |line|
          # comment is always last, while the amount of fields is subject to change
          comment = line.scan(/(?<=#).*?$/).first.strip
          line.gsub!(/;\s*#.*$/, '') unless comment.nil?
          values = line.split ';'
          key = values.first.strip
          value = (fields.map { |f|
                    [ f, values.shift.strip ]
                  } + [[ :comment, comment ]]).to_h
          arrayize ? \
            (@@hashmap[self.name][key] ||= []) << value : \
            @@hashmap[self.name][key] = value
        end
      end
      @@hashmap[self.name]
    end
    private :i_hash

    def __to_code_point cp
      case cp
      when Integer then cp = cp.to_s(16)
      when Forkforge::CodePoint then cp = cp.code_point
      end
      '%04X' % cp.to_i(16)
    end

    def __to_char cp
      cp = cp.to_s(16) if Integer === cp
      [cp.to_i(16)].pack('U')
    end

  end
end
