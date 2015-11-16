class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :location, presence: true
  validates :country, presence: true

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country.name
  end

end
