class CatRentalRequest < ActiveRecord::Base


  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
     message: "%{ value } is not a valid status"}

  # validate :overlapping_approved_requests

  belongs_to :cat

  def overlapping_approved_requests
    binds = { start_date: self.start_date, end_date: self.end_date }

    results = CatRentalRequest.find_by_sql([<<-SQL, binds])
      SELECT
        id
      FROM
        cat_rental_requests
      WHERE
        start_date BETWEEN :start_date AND :end_date OR end_date BETWEEN :start_date AND :end_date AND status = 'APPROVED'
    SQL

    unless results.empty?
      errors[:start_date] << "is in between a approved date"
    end

  end

  def overlapping_pending_requests
    binds = { start_date: self.start_date, end_date: self.end_date }

    results = CatRentalRequest.find_by_sql([<<-SQL, binds])
      SELECT
        id
      FROM
        cat_rental_requests
      WHERE
        start_date BETWEEN :start_date AND :end_date OR end_date BETWEEN :start_date and :end_date AND status = 'PENDING'
    SQL

  end




  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save
      overlapping_pending_requests.each do |request|
        request.deny! unless self.id == request.id
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def pending?
    self.status == "PENDING"
  end

  # def overlapping_approved_requests
  #   overlapping_requests.where(status: "approved")
  #   unless overlapping_requests.empty?
  #     errors[:start_date] << "is in between a approved date"
  #   end
  # end
end
