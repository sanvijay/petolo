# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :slug, presence: true, uniqueness: { scope: :start_date }

  before_validation :create_slug
  validate :end_date_cannot_be_in_past_of_start_date

  private

  def create_slug
    self.slug = title&.parameterize
  end

  def end_date_cannot_be_in_past_of_start_date
    return if start_date.blank? || end_date.blank?
    return true if start_date < end_date

    errors.add(:end_date, "can't be in the past of start date")
  end
end
