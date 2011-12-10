module SupervisorsHelper

  def render_multi_column_jobs(jobs, cols=2)
    returning (rendered="") do
      jobs.in_groups_of(jobs.size/cols) do |group|
        rendered << %{ <div class='narrow-col'><ul> }
        group.each do |job|
          rendered << "<li> </li>" if job
        end
        rendered << %{ </ul></div> }
      end
    end
  end
end
