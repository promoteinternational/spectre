class RunsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    project = Project.find_by_slug!(params[:project_slug])
    suite = project.suites.find_by_slug!(params[:suite_slug])
    @run = suite.runs.find_by_sequential_id!(params[:sequential_id])
    @test_filters = TestFilters.new(@run.tests, true, params)

    respond_to do |format|
      format.html
      format.json {
        render json: @run.to_json(:include => :tests)
      }
    end
  end

  def new
    @run = Run.new
  end

  def create
    project = Project.find_or_create_by(name: params[:project])
    suite = project.suites.find_or_create_by(name: params[:suite])
    suite.init_from_commit(params[:init_from_commit])
    @run = suite.runs.create(commit: params[:commit])
    render :json => @run.to_json
  end

  def pass_all
    project = Project.find_by_slug!(params[:project_slug])
    suite = project.suites.find_by_slug!(params[:suite_slug])
    @run = suite.runs.find_by_sequential_id!(params[:sequential_id])
    @run.transaction do
      @run.tests.each do |test|
        test.pass = true
        test.save
      end
    end
    redirect_to project_suite_url(project, suite)
  end
end
