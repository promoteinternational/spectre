class ProcessTestJob
  include Sidekiq::Worker
  # This must run after the copy job
  sidekiq_options queue: 'low'

  def perform(test_params)
    ImageProcessor.crop(test_params[:screenshot].path, test_params[:crop_area]) if test_params[:crop_area]
    @test = Test.create!(test_params)
    ScreenshotComparison.new(@test, test_params[:screenshot])
    @test
  end
end
