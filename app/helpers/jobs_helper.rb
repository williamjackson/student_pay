module JobsHelper
  def current_supervisor(job)
    if job.supervisor.nil?
      "-Select supervisor"
    else
      job.supervisor
    end
  end
end
