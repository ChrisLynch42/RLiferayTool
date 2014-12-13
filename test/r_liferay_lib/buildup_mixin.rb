module RLiferayLib
  module BuildupMixin
    def build_up
      _build_up
    end


    def _build_up
      FileUtils.mkpath(TestFiles::WEB_INF_DIR)
      FileUtils.mkpath(TestFiles::JSP_DIR)
    end

  end
end