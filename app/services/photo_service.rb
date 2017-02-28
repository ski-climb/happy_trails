class PhotoService

  attr_reader :flash, :path

  def initialize(image, issue, user)
    @image = image
    @user  = user
    @issue = issue
    set_path_and_flash
    add_photo
  end

  private

    attr_reader :image, :user, :issue

    def add_photo
      issue.photos.create(url: image, user: user)
    end

    def set_path_and_flash
      if set_issue_gps_data
        @flash = 'Issue added.'
        @path  = '/'
      else
        @flash = unsuccessful_warning
        @path  = "/issues/#{issue.id}/edit"
      end
    end

    def set_issue_gps_data
      if image && gps_data = EXIFR::JPEG.new(@image.open).gps
        issue.update(latitude: gps_data.latitude, longitude: gps_data.longitude)
        return true
      end
    end

    def unsuccessful_warning
      'Could not find GPS data from image. Please select the issue location
      by dragging the blue dot to its location and clicking submit location.'
    end
end
