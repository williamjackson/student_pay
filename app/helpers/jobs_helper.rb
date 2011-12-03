module JobsHelper
  def current_department(job)
    if job.department.nil?
      "-Select Supervising department"
    else
      job.department
    end
  end
end
