class Product
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  #validations
  validates_presence_of :name, :type, :length, :width, :height, :weight
  validates_numericality_of :length, :width, :height, :weight, greater_than: 0
  validates_uniqueness_of :name
end
