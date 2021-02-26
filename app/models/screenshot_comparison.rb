require 'image_size'
require 'image_geometry'

class ScreenshotComparison
  attr_reader :pass

  def initialize(test, screenshot)
    determine_baseline_image(test, screenshot)
    image_paths = temp_screenshot_paths(test)
    compare_result = compare_images(test, image_paths)
    @pass = determine_pass(test, image_paths, compare_result)
    test.pass = @pass
    save_screenshots(test, image_paths)
    remove_temp_files(image_paths)
  end

  private

  def temp_screenshot_paths(test)
    {
      diff: File.join(Rails.root, 'tmp', "#{test.id}_diff.png")
    }
  end

  def compare_images(test, image_paths)
    compare_command = compare_images_command(test.screenshot_baseline.path, test.screenshot.path, image_paths[:diff], test.fuzz_level, test.highlight_colour)
    Open3.popen3(compare_command) { |_stdin, stdout, _stderr, _wait_thr| stdout.read.split.map(&:to_f).sum/3 }
  end

  def compare_images_command(baseline_file, compare_file, diff_file, fuzz, highlight_colour)
    "gm compare -metric MAE -highlight-color '##{highlight_colour}' -file #{diff_file.shellescape} #{baseline_file.shellescape} #{compare_file.shellescape} | grep -E '(Red|Green|Blue)' | tr -s ' ' | cut -d' ' -f 3"
  end


  def determine_baseline_image(test, screenshot)
    # find an existing baseline screenshot for this test
    baseline_test = Baseline.find_by_key(test.key)

    # grab the existing baseline image and cache it against this test
    # otherwise compare against itself
    if baseline_test
      begin
        test.screenshot_baseline = baseline_test.screenshot
      rescue Dragonfly::Job::Fetch::NotFound => e
        test.screenshot_baseline = screenshot
      end
    else
      test.screenshot_baseline = screenshot
    end

    test.save!
  end

  def determine_pass(test, image_paths, compare_result)
    begin
      test.diff = (compare_result * 100).round(2)
      # TODO: pull out 0.1 (diff threshhold to config variable)
      (test.diff < 0.1)
    rescue
      # should probably raise an error here
    end
  end

  def save_screenshots(test, image_paths)
    # assign temporary images to the test to allow dragonfly to process and persist
    test.screenshot_diff = Pathname.new(image_paths[:diff])
    test.save
    test.create_thumbnails
  end

  def remove_temp_files(image_paths)
    # remove the temporary files
    File.delete(image_paths[:diff])
  end
end
