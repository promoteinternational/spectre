class Suite < ActiveRecord::Base
  belongs_to :project
  has_many :runs, dependent: :destroy
  has_many :tests, through: :runs, dependent: :destroy
  has_many :baselines, dependent: :destroy
  after_initialize :create_slug

  def latest_run
    runs.order(id: :desc).first
  end

  def create_slug
    self.slug ||= name.to_s.parameterize
  end

  def to_param
    slug
  end

  def purge_old_runs
    self.runs.order(id: :desc).offset(30).destroy_all
  end

  def init_from_commit(commit)
    if baselines.count == 0 && commit
      from_run = Run.order(created_at: :asc).find_by_commit(commit)
      if from_run
        create_baselines(from_run)
      end
    end
  end

  def create_baselines(from_run)
    from_run.tests.each do |test|
      test.dup_baseline(self)
    end
  end
end
