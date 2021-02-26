require 'securerandom'

class ProcessTestJob < ApplicationJob
  queue_as :default

  def perform(test_params)
    # horrible hack to get the correct metadata through dragonfly
    # otherwise the images aren't opened inline
    file = test_params[:screenshot]
    def file.original_filename
      "#{SecureRandom.alphanumeric}.png"
    end
    ImageProcessor.crop(test_params[:screenshot].path, test_params[:crop_area]) if test_params[:crop_area]
    @test = Test.new(test_params)
    @test.save!
    ScreenshotComparison.new(@test, test_params[:screenshot])
    @test
  end
end
