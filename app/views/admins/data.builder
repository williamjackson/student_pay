xml.instruct! :xml, :version=>"1.0"

xml.tag!("rows") do
  @users.each do |user|
    jobs = user.jobs
    jobs.each do |job|
      pay_sheet = job.pay_sheets.find_by_pay_period_id(@pay_period)
      xml.tag!("row", {"id" => job.id}) do
        xml.tag!("cell", user.name)
        xml.tag!("cell", job.rate)
        if pay_sheet
          xml.tag!("cell", pay_sheet.total_hours)
        else
          xml.tag!("cell", (link_to "add pay sheet", new_pay_sheet_path(:job_id => job)))
        end
      end
    end
  end
end