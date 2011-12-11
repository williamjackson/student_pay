module SupervisorsHelper

  def render_multi_column_list(items, div)
    returning (rendered="") do
      items_size = items.size
      items_size = items_size + 1 if items_size % 2 == 1
      items.in_groups_of(items_size / 2) do |group|
        #group.each do |item|
        # if item.instance_of?(PaySheet)
        #  job = item.job
        #else
        # job = item
        #end
        #if job
        rendered << "<p> hi </p>"
        #rendered << "<%= link_to #{job.user.name}, #{job.user} %>"
        # rendered << "<%=" "(#{job.name})" "%>"
        # rendered << "<%= link_to" "view/update," "edit_pay_sheet_path(#{item}) %>" if div == "approved"
        #rendered << "<%= link_to" "add pay sheet," "new_pay_sheet_path(:job_id => #{job}) %>" if div == "missing"
        #   end
        # end
        #end
      end
    end
  end
end

