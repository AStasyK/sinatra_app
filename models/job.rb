class Job < Sequel::Model
  many_to_one :company

  def to_api
    {
        id: id.to_s,
        place: place,
        name: name,
        company_id: company_id.to_s
    }
  end

  def self.company_jobs(company_id)
    where(company_id: company_id)
  end

end
