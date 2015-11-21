class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  validates_presence_of :first_name, :last_name, :location, :country


  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country.name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
