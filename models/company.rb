class Company < Sequel::Model
  one_to_many :jobs

  def to_api
    {
        id: id.to_s,
        name: name,
        location: location
    }
  end

  def self.by_name(name)
    res = []
    res = where(name: /#{name}/i) if name # apply to self
    res.empty? ? [] : res
  end

  def self.company_jobs(name)
    company = Company.by_name(name)
    puts "company = #{company.inspect}" if company
    puts "company.count = #{company.count}" unless company.nil?
    company_id = company.map(:id)[0] unless company == [] || company == nil
    puts "company_id = #{company_id.inspect}"
    company_jobs = Job.company_jobs(company_id) unless company_id.nil?
    puts "company_jobs = #{company_jobs.count}"  unless company_jobs.nil?
    puts "company_jobs = #{company_jobs.inspect}"
    company_jobs.nil? ? [].to_json : collection_to_api(company_jobs)
  end

end

