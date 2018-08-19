module CdAdmin
  class PagesController < AdminController
    def index
      @tutor_count  = ::Tutor.unscoped.where(status: ::Tutor::VERIFIED).count
      @course_count = ::Course.unscoped.where(is_public: true, verification_status: ::Course::APPROVED).count
    end
  end
end