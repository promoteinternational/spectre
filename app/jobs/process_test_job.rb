class ProcessTestJob < ApplicationJob
  queue_as :default

  def perform(test_params)
    ImageProcessor.crop(test_params[:screenshot].path, test_params[:crop_area]) if test_params[:crop_area]
    @test = Test.create!(test_params)
    ScreenshotComparison.new(@test, test_params[:screenshot])
    @test
  end
end
