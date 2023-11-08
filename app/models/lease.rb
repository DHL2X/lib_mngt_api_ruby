class Lease < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :start_date, :end_date, presence: true
  validate :end_date_must_be_after_start_date

  def active?
    current_date = Date.today
    current_date >= start_date && current_date < end_date
  end

  def self.is_valid_to_rent(user, book)
    existing_leases = Lease.where(user: user, book: book)
    
    return false if book.active_leases_count >= book.quantity
    return true if existing_leases.empty?
    return existing_leases.none? { |lease| lease.end_date > Date.today }
  end


  private
  def end_date_must_be_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date,"must be after the start date")
    end
  end
end
