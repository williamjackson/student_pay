xml.instruct! :xml, :version=>"1.0"

xml.tag!("rows") do
  @users.each do |user|
    jobs = user.jobs
    jobs.each do |job|
      pay_sheet = job.pay_sheets.find_by_pay_period_id(@pay_period)
      xml.tag!("row", {"id" => job.id}) do
        xml.tag!("cell", (user.file))
        if jobs.size == 1
          xml.tag!("cell", (link_to user.name, user))
        else
          xml.tag!("cell", (link_to user.name, user) + " (#{job.name})")
        end
        xml.tag!("cell", job.rate)
        if pay_sheet && pay_sheet.approved?
          xml.tag!("cell", ("#{pay_sheet.total_hours}
          #{link_to "view", edit_pay_sheet_path(pay_sheet)}"))
          xml.tag!("cell", 0)
          xml.tag!("cell", (job.rate * pay_sheet.total_hours))
        elsif pay_sheet && !pay_sheet.approved?
          xml.tag!("cell", (link_to "not approved", edit_pay_sheet_path(pay_sheet)))
          xml.tag("cell", 0)
          xml.tag!("cell", 0)
        else
          xml.tag!("cell", (link_to "add pay sheet", new_pay_sheet_path(:job_id => job)))
          xml.tag("cell", 0)
          xml.tag!("cell", 0)
        end


      end
    end
  end
end