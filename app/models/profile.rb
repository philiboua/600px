class Profile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :location
  validates_presence_of :country

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country.name
  end

end
