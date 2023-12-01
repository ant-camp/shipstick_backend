class Product
  include Mongoid::Document

  # Fields
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  # Validations
  validates :type, :length, :width, :height, :weight, presence: true, allow_blank: false
  validates :name, uniqueness: true, presence: true, allow_blank: false
  validates_numericality_of :length, :width, :height, :weight, greater_than: 0

 # Find the next closest matching product
  def self.find_best_match(length, width, height, weight)
    all_products = Product.all

    # Assign scores to each product based on how well they fit the criteria
    scored_products = all_products.map do |product|
      dimension_score = 0
      dimension_score += 1 if product.length >= length
      dimension_score += 1 if product.width >= width
      dimension_score += 1 if product.height >= height
      weight_score = product.weight >= weight ? 1 : 0
      
      total_score = dimension_score + weight_score
      [product, total_score]
    end

    # Sort by score (higher is better), then by size and weight difference
    sorted_products = scored_products.sort_by do |product, score|
      size_diff = (product.length - length).abs + (product.width - width).abs + (product.height - height).abs
      weight_diff = (product.weight - weight).abs
      [-score, size_diff, weight_diff]
    end
    
    # Select the product with the best score
    best_product, best_score = sorted_products.first
    
    if best_score > 3
      best_product
    else
      nil
    end
  end
end
