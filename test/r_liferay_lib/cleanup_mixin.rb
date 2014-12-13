module RLiferayLib
  module CleanupMixin
    def clean_up
      _clean_up
    end


    def _clean_up
      Dir[TestFiles::TEMP_DIR + '/*'].each { | file_name |
        FileUtils.rm_rf(file_name)
      }
    end

  end
end